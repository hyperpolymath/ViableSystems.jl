# SPDX-License-Identifier: PMPL-1.0-or-later
module SSM

export CATWOE, RootDefinition, analyze_problem

"""
    CATWOE: Soft Systems Methodology framework.
    - C: Customers
    - A: Actors
    - T: Transformation
    - W: Weltanschauung (Worldview)
    - O: Owner
    - E: Environmental constraints
"""
struct CATWOE
    customers::String
    actors::String
    transformation::String
    worldview::String
    owner::String
    environment::String
end

"""
    RootDefinition
    A formal statement of the human activity system based on CATWOE.
"""
function RootDefinition(c::CATWOE)
    return "A system owned by $(c.owner) where $(c.actors) perform $(c.transformation) for $(c.customers) within $(c.environment) given $(c.worldview)."
end

"""
    analyze_problem(description)
    Stub for qualitative analysis of ill-structured problems.
"""
function analyze_problem(desc::String)
    println("Analyzing Soft System Problem: $desc 🌀")
    return "Initial rich picture nodes identified."
end

end # module
