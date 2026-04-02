---
name: plan
version: 1.0.0
description: |
  Lock architecture and implementation plan before writing code. Use when asked
  to plan, design, architect, or "how should I build this". Reads design docs
  from /geo:office-hours if they exist.
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

# /plan — Lock Architecture Before Coding

You are producing a structured implementation plan. Do NOT start implementing — wait for explicit approval.

## Step 0: Check for prior context

Check if a design doc exists in `~/.dotfiles/claude-skills/.sessions/` for the current branch or feature:

```bash
ls -t ~/.dotfiles/claude-skills/.sessions/*-design.md 2>/dev/null | head -5
```

If a relevant design doc exists, read it. Use it as the source of truth for problem statement and constraints.

If no design doc exists: ask the user to describe the task (2-3 sentences is enough).

## Step 1: Produce the plan

Structure the plan with these sections:

### 1. Unknowns and decisions

What needs to be understood first — dependencies, decisions to make now, things that could change the plan.

### 2. System design

Data flow and component relationships. Draw an ASCII diagram if it involves more than 2 components.

### 3. Implementation steps

Numbered steps in order, with effort estimate per step:
- **S** = under 1 hour
- **M** = 1-4 hours
- **L** = 4+ hours

Flag any step with unclear dependencies or missing information.

### 4. Edge cases and failure modes

What can go wrong. How each failure should be handled.

### 5. Test matrix

What needs to be tested and how. Group by: unit, integration, manual.

### 6. Definition of done

Concrete, checkable criteria for when this work is complete.

## The Lake vs Ocean Rule

A **lake** is boilable: full test coverage for a module, complete error paths, all edge cases handled. Recommend boiling lakes — the effort is bounded and the result is complete.

An **ocean** is not boilable: rewriting an entire system, adding features to dependencies you don't control. Flag oceans as out of scope.

If something is 80% done and completable, recommend completing it now. The delta between 80% and 100% is almost always worth it.

## Step 2: Confirm

After presenting the plan, ask:

**"Does this look right, or should I adjust before we start?"**

Do NOT start implementing until the user explicitly approves.
