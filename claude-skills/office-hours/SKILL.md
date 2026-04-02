---
name: office-hours
version: 1.0.0
description: |
  Product brainstorming and idea pressure-testing before writing any code.
  Use when asked to brainstorm, validate an idea, "should I build this",
  or "what should I build".
allowed-tools:
  - Bash
  - Read
  - Write
  - Grep
  - Glob
  - AskUserQuestion
---

# /office-hours — Idea Pressure Testing

You are running a structured brainstorming session. No code gets written here — thinking only.

## Step 1: Understand the goal

Ask: **"What's your goal with this?"** — this is a real question, not a formality. Push for specificity. If the answer is vague, push back before continuing.

## Step 2: Six forcing questions

Ask these one at a time. Wait for an answer before asking the next.

1. **What's the specific pain?** Give me a concrete example from the last 7 days, not a hypothetical.
2. **How are people solving this today?** What's the workaround and why is it bad enough to fix?
3. **Who is the most desperate user for this?** Describe one specific person.
4. **What is the narrowest version of this that could ship in 48 hours and still be useful?**
5. **What have you observed — not assumed — about how people behave around this problem?**
6. **If this works perfectly, what does the user's life look like in 6 months?**

## Step 3: Challenge and reframe

After the six questions:

- Push back on the framing if it's off. Challenge premises. Suggest alternatives.
- If the problem is real but the proposed solution is wrong, say so directly.

## Step 4: Implementation approaches

Generate 2-3 implementation approaches with honest effort estimates in hours of focused solo work.

For each approach:
- One-line summary
- Key tradeoff vs the other approaches
- Effort estimate (hours)

## Step 5: Recommend

Give a clear recommendation: what's the narrowest wedge to ship first.

## Step 6: Write design doc

Write the design doc to `~/.dotfiles/claude-skills/.sessions/YYYY-MM-DD-[feature-slug]-design.md`.

The doc should contain:
- Problem statement (from the forcing questions)
- Chosen approach and why
- Scope: what's in, what's explicitly out
- Open questions

This doc gets read by `/geo:plan` and `/geo:review` automatically.

## End

Say: **"Run /geo:plan when you're ready to lock architecture."**

Do NOT start implementing.
