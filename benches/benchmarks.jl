# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# BenchmarkTools benchmarks for ViableSystems.jl

using BenchmarkTools
using ViableSystems

const SUITE = BenchmarkGroup()

SUITE["vsm"] = BenchmarkGroup()

SUITE["vsm"]["check_variety"] = @benchmarkable check_variety(100, 150)

SUITE["vsm"]["create_organization"] = @benchmarkable ViableOrganization(
    "Bench Org",
    [System1(:u, "activity", true)],
    "S2", "S3", "S4", "S5",
    1,
)

SUITE["vsm"]["algedonic_alert"] = let
    org = ViableOrganization("Alert Org", [System1(:u, "ops", true)], "S2", "S3", "S4", "S5", 1)
    @benchmarkable algedonic_alert($org, "Benchmark alert")
end

SUITE["ssm"] = BenchmarkGroup()

SUITE["ssm"]["root_definition"] = let
    c = CATWOE("Customers", "Actors", "Transformation",
               "Worldview", "Owner", "Environment")
    @benchmarkable RootDefinition($c)
end

SUITE["ssm"]["analyze_problem"] = @benchmarkable analyze_problem("Worker morale decline")

SUITE["boundary"] = BenchmarkGroup()

SUITE["boundary"]["create_boundary_object_small"] = @benchmarkable create_boundary_object(
    "Interface",
    ["throughput", "latency"],
    [:S3, :S4],
)

SUITE["boundary"]["create_boundary_object_large"] = @benchmarkable create_boundary_object(
    "Large Interface",
    ["c$i" for i in 1:20],
    [Symbol("S$i") for i in 1:10],
)

if abspath(PROGRAM_FILE) == @__FILE__
    tune!(SUITE)
    results = run(SUITE, verbose=true)
    BenchmarkTools.save("benchmarks_results.json", results)
end
