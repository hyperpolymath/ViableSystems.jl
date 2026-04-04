# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# E2E pipeline tests for ViableSystems.jl

using Test
using ViableSystems

@testset "E2E Pipeline Tests" begin

    @testset "Full VSM design pipeline" begin
        # Build a multi-level viable organisation and run diagnostics
        ops = [
            System1(:unit_a, "Product assembly", true),
            System1(:unit_b, "Quality assurance", true),
            System1(:unit_c, "Logistics", false),
        ]
        org = ViableOrganization(
            "Hyperpolymath Widgets Ltd",
            ops,
            "Weekly coordination meetings",
            "Monthly operations audit",
            "Quarterly market research",
            "Annual board governance",
            2,
        )

        @test org.name == "Hyperpolymath Widgets Ltd"
        @test length(org.s1_operations) == 3

        # Variety check: sufficient system capacity
        vr = check_variety(100, 200)
        @test vr.balanced == true

        # Variety check: insufficient capacity triggers advice
        vr2 = check_variety(200, 50)
        @test vr2.balanced == false
        @test occursin("Increase", vr2.advice)

        # Algedonic alert
        @test algedonic_alert(org, "Conveyor belt failure in unit_a") === nothing
    end

    @testset "Full SSM pipeline" begin
        c = CATWOE(
            "Workers",
            "Managers",
            "Improve productivity",
            "People-centred org",
            "Board of Directors",
            "Budget constraints",
        )
        rd = RootDefinition(c)
        @test occursin("Managers", rd)
        @test occursin("Board of Directors", rd)

        analysis = analyze_problem("High staff turnover in public sector")
        @test occursin("rich picture", analysis)
    end

    @testset "Boundary object creation pipeline" begin
        sbo = create_boundary_object(
            "S3-S4 Interface",
            ["throughput", "latency", "error_rate"],
            [:S3, :S4, :S5],
        )
        @test sbo isa SystemBoundaryObject
        @test length(sbo.model.agreed_concepts) == 3
        @test :S5 in sbo.interface_points
    end

    @testset "Error handling: empty operations list" begin
        org = ViableOrganization("Empty Org", System1[], "S2", "S3", "S4", "S5", 0)
        @test isempty(org.s1_operations)
        @test algedonic_alert(org, "Test alert") === nothing
    end

end
