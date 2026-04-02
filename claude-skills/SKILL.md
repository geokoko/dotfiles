---
name: geo
version: 1.0.0
description: |
  Personal skills registry for efficient Claude Code usage. Provides stack context
  awareness and routes to specialized sub-skills for planning, review, debugging,
  shipping, and safety guardrails.
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
---

# Stack Context

## Environment

- Shell: zsh
- Editor: Neovim
- OS: Linux (Fedora)
- Version control: git, PRs on GitHub

## Coding Preferences

- Handle errors explicitly. Never silently swallow exceptions.
- Prefer small, composable functions over large monoliths.
- When adding a new dependency, state it explicitly and explain why.
- Do not add logging frameworks, observability tooling, or new abstractions without asking first.
- Prefer readable over clever. Name things for what they do.
- Complete implementations over shortcuts. The delta between 80 lines and 150 lines is meaningless — finish it properly.

## Skill Routing

When the user's request matches an available geo skill, invoke it as the first action:

| Intent | Command |
|--------|---------|
| New feature idea, brainstorming | `/geo:office-hours` |
| Architecture, "how should I design this" | `/geo:plan` |
| Bug, error, "why is this broken" | `/geo:investigate` |
| Code review, check my diff | `/geo:review` |
| QA pass, find bugs | `/geo:qa` |
| Security audit | `/geo:cso` |
| Ship, push, create PR | `/geo:ship` |
| Update docs after shipping | `/geo:document-release` |
| Weekly check-in | `/geo:retro` |
| Safety mode | `/geo:careful` or `/geo:guard` |
| Scope edits to one directory | `/geo:freeze` |
