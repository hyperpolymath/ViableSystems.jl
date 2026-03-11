# SPDX-License-Identifier: PMPL-1.0-or-later
module VSM

export System1, System2, System3, System4, System5, ViableOrganization
export algedonic_alert, check_variety

"""
    System1: Operations
    The primary activities of the organization.
"""
struct System1
    id::Symbol
    activity::String
    local_management::Bool
end

"""
    ViableOrganization
    The 5-system model by Stafford Beer.
"""
mutable struct ViableOrganization
    name::String
    s1_operations::Vector{System1}
    s2_coordination::String # Anti-oscillatory mechanisms
    s3_control::String      # Inside & Now / Day-to-day
    s4_intelligence::String # Outside & Then / Future planning
    s5_policy::String       # Identity & Balance between S3 and S4
    recursion_level::Int
end

"""
    algedonic_alert(org, message)
    Triggers an emergency signal from System 1 directly to System 5.
"""
function algedonic_alert(org::ViableOrganization, msg::String)
    println("🚨 ALGEDONIC ALERT in $(org.name): $msg")
    println("  -> System 5 (Policy) notified immediately.")
end

"""
    check_variety(environment_complexity, system_capacity)
    Ashby's Law of Requisite Variety: 'Only variety can absorb variety'.
"""
function check_variety(env::Int, sys::Int)
    if sys < env
        return (balanced=false, gap=env-sys, advice="Increase system complexity or attenuate environment.")
    else
        return (balanced=true, gap=sys-env, advice="System has sufficient variety.")
    end
end

end # module
