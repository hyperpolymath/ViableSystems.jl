# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# Property-based invariant tests for ViableSystems.jl

using Test
using ViableSystems

@testset "Property-Based Tests" begin

    @testset "Invariant: check_variety gap is always |system_capacity - env_complexity|" begin
        for _ in 1:50
            sc = rand(0:500)
            ec = rand(0:500)
            vr = check_variety(sc, ec)
            @test vr.gap == abs(sc - ec)
        end
    end

    @testset "Invariant: check_variety balanced iff system_capacity >= env_complexity" begin
        for _ in 1:50
            sc = rand(0:500)
            ec = rand(0:500)
            vr = check_variety(sc, ec)
            @test vr.balanced == (sc >= ec)
        end
    end

    @testset "Invariant: create_boundary_object preserves concept count" begin
        for _ in 1:50
            n = rand(0:10)
            concepts = ["concept_$(rand(1:999))" for _ in 1:n]
            sbo = create_boundary_object("BoundaryObj", concepts, [:S1, :S2])
            @test length(sbo.model.agreed_concepts) == n
        end
    end

    @testset "Invariant: create_boundary_object preserves interface point count" begin
        for _ in 1:50
            m = rand(1:8)
            pts = [Symbol("S$i") for i in 1:m]
            sbo = create_boundary_object("Obj", ["c"], pts)
            @test length(sbo.interface_points) == m
        end
    end

    @testset "Invariant: algedonic_alert always returns nothing" begin
        for _ in 1:20
            org = ViableOrganization("Org $(rand(1:999))", System1[], "S2", "S3", "S4", "S5", rand(0:5))
            @test algedonic_alert(org, "Alert message $(rand(1:999))") === nothing
        end
    end

end
