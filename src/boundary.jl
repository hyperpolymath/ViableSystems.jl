# SPDX-License-Identifier: PMPL-1.0-or-later
module BoundaryObjects

export SystemBoundaryObject, SharedModel, create_boundary_object

struct SharedModel
    name::String
    agreed_concepts::Vector{String}
end

"""
    SystemBoundaryObject
    An artifact used to align different VSM systems (e.g. aligning S1 operations with S4 strategy).
"""
struct SystemBoundaryObject
    name::String
    model::SharedModel
    interface_points::Vector{Symbol} # Systems that use this object
end

function create_boundary_object(name, concepts, systems)
    model = SharedModel(name, concepts)
    return SystemBoundaryObject(name, model, systems)
end

end # module
