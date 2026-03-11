<!-- SPDX-License-Identifier: PMPL-1.0-or-later -->
<!-- TOPOLOGY.md — Project architecture map and completion dashboard -->
<!-- Last updated: 2026-02-19 -->

# ViableSystems.jl — Project Topology

## System Architecture

```
                        ┌─────────────────────────────────────────┐
                        │          ENVIRONMENT / CONTEXT          │
                        ├─────────────────────────────────────────┤
                        │  ┌────────────┐      ┌────────────┐     │
                        │  │ Stakehold. │ ◀──▶ │ Environment│     │
                        │  │ (Clients)  │      │ (Variety)  │     │
                        │  └─────┬──────┘      └─────▲──────┘     │
                        │        │                   │            │
                        └────────┼───────────────────┼────────────┘
                                 │                   │
                                 ▼                   │
                        ┌────────────────────────────┼────────────┐
                        │           APPLICATION LAYER             │
                        ├─────────────────────────────────────────┤
                        │  ┌──────────────────┐      ┌──────────┐ │
                        │  │   Viable System  │      │ Soft Sys │ │
                        │  │   Model (VSM)    │ ───▶ │ (SSM)    │ │
                        │  └────────┬─────────┘      └─────┬────┘ │
                        │           │                      │      │
                        │  ┌────────▼─────────┐      ┌─────▼────┐ │
                        │  │   Algedonic      │      │ Boundary │ │
                        │  │    Loops         │ ◀──▶ │ Objects  │ │
                        │  └────────┬─────────┘      └─────┬────┘ │
                        │           │                      │      │
                        │  ┌────────▼─────────┐      ┌─────▼────┐ │
                        │  │   Recursive      │      │ Variety  │ │
                        │  │   Analysis       │ ───▶ │ Balancer │ │
                        │  └──────────────────┘      └──────────┘ │
                        └──────────────────────┬──────────────────┘
                                               │
                        ┌──────────────────────▼──────────────────┐
                        │         REPO INFRASTRUCTURE             │
                        │  .github/workflows/ (RSR Gate)          │
                        │  Project.toml                           │
                        └─────────────────────────────────────────┘
```

## Completion Dashboard

```
COMPONENT                          STATUS              NOTES
─────────────────────────────────  ──────────────────  ─────────────────────────────────
CORE CYBERNETICS
  VSM (System 1-5)                  ██████████ 100%    Structs for all 5 systems
  Algedonic Loops                   ████████░░  80%    Alert dispatch logic
  Requisite Variety                 ██████░░░░  60%    Variety calculation tools

SOFT SYSTEMS
  SSM (CATWOE)                      ██████████ 100%    Analysis structures complete
  Root Definitions                  ████████░░  80%    Synthesis logic
  Boundary Objects                  ██████░░░░  60%    Interface definitions

INFRASTRUCTURE
  Recursive Viability               ██████░░░░  60%    Hierarchy management
  Project.toml                      ██████████ 100%    Metadata complete
  .github/workflows/ (CI)           ██████████ 100%    RSR standard compliance

─────────────────────────────────────────────────────────────────────────────
OVERALL:                            ██████░░░░  ~60%   Functional Cybernetic Base
```

## Key Dependencies

```
CATWOE Analysis ──────► Root Definition ──────► Boundary Objects
                                                   │
Variety Mapping ──────► VSM Structure ───────────┤
                                                   │
Recursive Checks ─────► Algedonic Loops ──────► COMPLETE
```

## Update Protocol

This file is maintained by both humans and AI agents. When updating:

1. **After completing a component**: Change its bar and percentage
2. **After adding a component**: Add a new row in the appropriate section
3. **After architectural changes**: Update the ASCII diagram
4. **Date**: Update the `Last updated` comment at the top of this file

Progress bars use: `█` (filled) and `░` (empty), 10 characters wide.
Percentages: 0%, 10%, 20%, ... 100% (in 10% increments).
