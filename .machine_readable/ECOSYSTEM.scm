;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm for ViableSystems.jl
;; Media Type: application/vnd.ecosystem+scm

(ecosystem
  (version "1.0")
  (name "ViableSystems.jl")
  (type "julia-package")
  (purpose "Viable Systems Model and Soft Systems Methodology for organizational cybernetics")

  (position-in-ecosystem
    (domain "systems-science")
    (role "Computational modelling of Beer's VSM and Checkland's SSM")
    (maturity "alpha"))

  (related-projects
    ((name . "hyperpolymath ecosystem")
     (relationship . part-of)
     (nature . "Julia packages for interdisciplinary computing"))))
