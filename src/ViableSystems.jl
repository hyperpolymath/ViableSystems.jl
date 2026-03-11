# SPDX-License-Identifier: PMPL-1.0-or-later
"""
    ViableSystems

Implementation of Stafford Beer's Viable System Model (VSM) and Checkland's Soft
Systems Methodology (SSM). Models organisational viability through five recursive
systems, variety checks, and algedonic alerts, with optimisation via simulated
annealing and genetic algorithms.

# Key Features
- VSM Systems 1-5 with `ViableOrganization` container
- Variety checking and algedonic alert signalling
- SSM CATWOE analysis and root definition generation
- Simulated annealing and genetic algorithm optimisation
- Boundary objects for inter-system knowledge sharing

# Example
```julia
using ViableSystems
org = ViableOrganization("Acme Corp")
check_variety(org)
algedonic_alert(org, :performance_drop)
```
"""
module ViableSystems

include("VSM.jl")
include("SSM.jl")
include("optimization.jl")
include("boundary.jl")

using .VSM
using .SSM
using .SystemOptimization
using .BoundaryObjects

# Re-export everything
export System1, System2, System3, System4, System5, ViableOrganization
export algedonic_alert, check_variety
export CATWOE, RootDefinition, analyze_problem
export simulated_annealing_optimize, genetic_algorithm_optimize
export SystemBoundaryObject, SharedModel, create_boundary_object

end # module
