# SPDX-License-Identifier: PMPL-1.0-or-later
using Test
using ViableSystems

@testset "ViableSystems.jl" begin

    # ─────────────────────────────────
    # VSM: Viable System Model
    # ─────────────────────────────────
    @testset "VSM" begin

        @testset "System1 construction" begin
            s1 = System1(:ops_alpha, "Manufacturing widgets", true)
            @test s1.id == :ops_alpha
            @test s1.activity == "Manufacturing widgets"
            @test s1.local_management == true
        end

        @testset "ViableOrganization construction" begin
            ops = [
                System1(:unit_a, "Assembly", true),
                System1(:unit_b, "Quality control", false),
            ]
            org = ViableOrganization(
                "Acme Corp",
                ops,
                "Scheduling system",
                "Operations audit",
                "Market research",
                "Board governance",
                1,
            )
            @test org.name == "Acme Corp"
            @test length(org.s1_operations) == 2
            @test org.s2_coordination == "Scheduling system"
            @test org.s3_control == "Operations audit"
            @test org.s4_intelligence == "Market research"
            @test org.s5_policy == "Board governance"
            @test org.recursion_level == 1
        end

        @testset "ViableOrganization is mutable" begin
            org = ViableOrganization(
                "Mutable Corp",
                System1[],
                "S2", "S3", "S4", "S5",
                0,
            )
            org.name = "Renamed Corp"
            @test org.name == "Renamed Corp"

            push!(org.s1_operations, System1(:new_unit, "New activity", true))
            @test length(org.s1_operations) == 1

            org.recursion_level = 3
            @test org.recursion_level == 3
        end

        @testset "algedonic_alert" begin
            org = ViableOrganization(
                "Crisis Inc",
                [System1(:floor, "Production", true)],
                "S2", "S3", "S4", "S5",
                1,
            )
            # algedonic_alert prints and returns nothing
            @test algedonic_alert(org, "Safety incident on shop floor") === nothing
        end

        @testset "check_variety" begin
            # System capacity insufficient
            result = check_variety(10, 5)
            @test result.balanced == false
            @test result.gap == 5
            @test occursin("Increase", result.advice)

            # System has sufficient variety
            result = check_variety(5, 10)
            @test result.balanced == true
            @test result.gap == 5
            @test occursin("sufficient", result.advice)

            # Exactly balanced
            result = check_variety(7, 7)
            @test result.balanced == true
            @test result.gap == 0

            # Edge case: zero complexity
            result = check_variety(0, 0)
            @test result.balanced == true
            @test result.gap == 0

            # Edge case: very large gap
            result = check_variety(1000, 1)
            @test result.balanced == false
            @test result.gap == 999
        end
    end

    # ─────────────────────────────────
    # SSM: Soft Systems Methodology
    # ─────────────────────────────────
    @testset "SSM" begin

        @testset "CATWOE construction" begin
            c = CATWOE(
                "Students",
                "Teachers",
                "Curriculum delivery",
                "Education empowers",
                "University Board",
                "Budget constraints",
            )
            @test c.customers == "Students"
            @test c.actors == "Teachers"
            @test c.transformation == "Curriculum delivery"
            @test c.worldview == "Education empowers"
            @test c.owner == "University Board"
            @test c.environment == "Budget constraints"
        end

        @testset "RootDefinition" begin
            c = CATWOE(
                "Patients",
                "Nurses",
                "Patient care",
                "Health is a right",
                "NHS Trust",
                "Funding cuts",
            )
            rd = RootDefinition(c)
            @test rd isa String
            @test occursin("NHS Trust", rd)
            @test occursin("Nurses", rd)
            @test occursin("Patient care", rd)
            @test occursin("Patients", rd)
            @test occursin("Funding cuts", rd)
            @test occursin("Health is a right", rd)
        end

        @testset "analyze_problem" begin
            result = analyze_problem("Declining worker morale in NHS trusts")
            @test result isa String
            @test occursin("rich picture", result)
        end
    end

    # ─────────────────────────────────
    # SystemOptimization
    # ─────────────────────────────────
    @testset "SystemOptimization" begin

        @testset "simulated_annealing_optimize" begin
            cost_fn(x) = (x - 3)^2
            result = simulated_annealing_optimize(cost_fn, 5.0)
            # Placeholder returns initial state unchanged
            @test result == 5.0

            # With keyword args
            result2 = simulated_annealing_optimize(cost_fn, 10; temp=2.0, cooling=0.99)
            @test result2 == 10
        end

        @testset "genetic_algorithm_optimize" begin
            population = [1, 2, 3, 4, 5]
            fitness(x) = -abs(x - 3)
            result = genetic_algorithm_optimize(population, fitness)
            # Placeholder returns first element
            @test result == 1
        end
    end

    # ─────────────────────────────────
    # BoundaryObjects
    # ─────────────────────────────────
    @testset "BoundaryObjects" begin

        @testset "SharedModel construction" begin
            sm = SharedModel("Common Ontology", ["term1", "term2", "term3"])
            @test sm.name == "Common Ontology"
            @test length(sm.agreed_concepts) == 3
            @test "term2" in sm.agreed_concepts
        end

        @testset "SystemBoundaryObject construction" begin
            sm = SharedModel("Interface Spec", ["throughput", "latency"])
            sbo = SystemBoundaryObject("S3-S4 Bridge", sm, [:S3, :S4])
            @test sbo.name == "S3-S4 Bridge"
            @test sbo.model === sm
            @test :S3 in sbo.interface_points
            @test :S4 in sbo.interface_points
        end

        @testset "create_boundary_object" begin
            sbo = create_boundary_object(
                "Cross-team Dashboard",
                ["KPI-A", "KPI-B"],
                [:S1, :S3, :S4],
            )
            @test sbo isa SystemBoundaryObject
            @test sbo.name == "Cross-team Dashboard"
            @test sbo.model isa SharedModel
            @test sbo.model.agreed_concepts == ["KPI-A", "KPI-B"]
            @test length(sbo.interface_points) == 3
        end

        @testset "create_boundary_object edge cases" begin
            # Empty concepts
            sbo = create_boundary_object("Minimal", String[], Symbol[])
            @test isempty(sbo.model.agreed_concepts)
            @test isempty(sbo.interface_points)

            # Single system
            sbo = create_boundary_object("Solo", ["concept"], [:S5])
            @test length(sbo.interface_points) == 1
        end
    end

end # top-level testset
