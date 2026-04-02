# geo — Personal Claude Code Skills

A lean skills registry for Claude Code. Structured workflows for planning, reviewing, debugging, shipping, and safety — without telemetry, update nags, or bloat.

## Install

```bash
cd ~/.dotfiles/claude-skills
./install.sh
```

This symlinks the repo into `~/.claude/skills/geo/`. Restart Claude Code after installing.

To uninstall:

```bash
rm ~/.claude/skills/geo
```

## Skills

### Thinking (before code)

| Command | Purpose |
|---------|---------|
| `/geo:office-hours` | Product brainstorming. Six forcing questions to pressure-test ideas before writing code. Outputs a design doc. |
| `/geo:plan` | Lock architecture. Reads design docs from office-hours, produces implementation plan with steps, edge cases, and test matrix. |

### Analysis (during code)

| Command | Purpose |
|---------|---------|
| `/geo:review` | Pre-landing code review. Checks correctness, security, consistency, hygiene. Reports CRITICAL/WARNING/SUGGESTION. |
| `/geo:investigate` | Root-cause debugging. Iron law: understand before fixing. 6-step process from reproduce to proposed fix. |
| `/geo:qa` | Adversarial QA pass. Generates happy path, edge case, failure, and security test cases. Reports coverage gaps. |
| `/geo:cso` | Security audit. OWASP Top 10 + STRIDE threat model. Confidence-gated findings only. |

### Shipping (after code)

| Command | Purpose |
|---------|---------|
| `/geo:ship` | Pre-push checklist (debug code, secrets, tests, review) then PR creation. Blocks on critical issues. |
| `/geo:document-release` | Post-ship documentation sync. Surgical updates to README, ARCHITECTURE, CLAUDE.md, CHANGELOG. |
| `/geo:retro` | Weekly retrospective. Commit stats, shipped features, stale branches, honest assessment. |

### Safety (guardrails)

| Command | Purpose |
|---------|---------|
| `/geo:careful` | Warns before destructive commands (rm -rf, DROP TABLE, force-push, etc.). Session-scoped. |
| `/geo:freeze [dir]` | Blocks Edit/Write outside a specified directory. Prevents scope creep during debugging. |
| `/geo:unfreeze` | Removes the freeze boundary. |
| `/geo:guard [dir]` | Maximum safety: activates both careful + freeze together. |

### Auto-activating

The root `geo` skill provides **stack context** — coding preferences, environment info, and automatic routing to the right sub-skill based on intent.

## Workflow

Typical feature workflow:

```
/geo:office-hours  →  brainstorm, validate, write design doc
/geo:plan          →  lock architecture, get approval
(write code)
/geo:review        →  catch bugs before shipping
/geo:ship          →  run checklist, create PR
/geo:document-release  →  sync docs
```

For debugging:

```
/geo:investigate   →  find root cause
/geo:careful       →  activate safety guardrails (optional)
(fix the bug)
/geo:review        →  verify the fix
/geo:ship          →  ship it
```

## Design Principles

- **No telemetry.** No analytics, no usage tracking, no phone-home.
- **No preamble bloat.** Skills contain instructions, not infrastructure.
- **Report first, fix on request.** Review, QA, and CSO report findings. They don't auto-fix.
- **Understand before acting.** Investigate requires root cause before any fix attempt.
- **Complete over clever.** Finish implementations properly. The delta between 80% and 100% is almost always worth it.

## Structure

```
claude-skills/
├── SKILL.md              ← Root skill (stack context + routing)
├── install.sh            ← Symlinks to ~/.claude/skills/geo/
├── office-hours/SKILL.md
├── plan/SKILL.md
├── review/SKILL.md
├── investigate/SKILL.md
├── qa/SKILL.md
├── cso/SKILL.md
├── ship/SKILL.md
├── document-release/SKILL.md
├── retro/SKILL.md
├── careful/
│   ├── SKILL.md
│   └── bin/check-careful.sh
├── freeze/
│   ├── SKILL.md
│   └── bin/check-freeze.sh
├── unfreeze/SKILL.md
├── guard/SKILL.md
└── .sessions/            ← Design docs (gitignored)
```

## State

The freeze/guard hooks store state in `~/.geo/freeze-dir.txt`. This file is cleaned up by `/geo:unfreeze` or when the session ends.

No other state is written anywhere.
