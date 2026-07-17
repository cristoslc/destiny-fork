# docs/

This directory contains the project's documentation, split into two architectural surfaces plus cross-cutting hubs.

## Technical architecture (how the system is built and deployed)

- `ARCHITECTURE.md` — C4 model hub → `docs/technical-architecture/`
- `docs/technical-architecture/c4/` — C4 level diagrams
- `docs/technical-architecture/tech-stack.md` — language, framework, and infrastructure decisions

## Domain architecture (what the system means to its domain experts)

- `DOMAIN-MODEL-L1.md` — L1 prose glossary (at the surface)
- `docs/domain-architecture/CONTEXT-MAP.md` — bounded context relationships
- `docs/domain-architecture/DOMAIN-EVENTS.md` — cross-context integration events
- `docs/domain-architecture/DOMAIN-MODEL-L2.md` — L2 ubiquitous language
- `docs/domain-architecture/events/` — event contract YAML specs

## Cross-cutting

- `DEVELOPER-WORKFLOWS.md` → `docs/developer-workflows/`
- `USER-EXPERIENCE.md` → `docs/user-experience/`
- `AGENTS.md` → `docs/agents-detail/`
- `adr/` — architecture decision records
- `plans/` — implementation plans
- `musings/` — pre-artifact thought capture
- `retros/` — post-session reflection docs
- `tech-debt/` — pre-existing LSP errors and tech debt

See `AGENTS.md` and `PURPOSE.md` for project context.
