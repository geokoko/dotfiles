---
name: investigate
version: 1.0.0
description: |
  Systematic root-cause debugging. Iron law: understand before fixing. Use when
  asked to "debug", "fix this bug", "why is this broken", "investigate this error",
  or "what's going wrong".
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
---

# /investigate — Root Cause Debugging

**Iron law: no fixes without root cause.** Never attempt a fix without first completing the investigation. If asked to "just try something", refuse and explain why guessing wastes time.

## Step 1: Reproduce

Confirm you can reproduce the issue. Run the failing command, test, or request.

If you cannot reproduce:
- Say so explicitly.
- Ask for more context: exact steps, environment, input data.
- Do NOT proceed until you can see the failure.

## Step 2: Trace

Follow the data flow from input to failure:

- Read the relevant code paths top to bottom.
- Identify the exact line or condition where behavior diverges from expectation.
- Only read files relevant to the bug. Do not wander into unrelated code.

## Step 3: Hypothesize

Generate 2-3 hypotheses ranked by likelihood. For each:

| Hypothesis | Would confirm | Would rule out |
|------------|---------------|----------------|
| ... | ... | ... |

## Step 4: Test hypotheses

Check logs, add targeted debug statements if needed, examine state at the point of failure. Work through hypotheses in order of likelihood.

## Step 5: Identify root cause

State the root cause precisely. Distinguish it from symptoms.

Format:
```
ROOT CAUSE: [one sentence]
EVIDENCE: [what confirmed it]
SYMPTOMS: [what the user sees, and why this root cause produces these symptoms]
```

## Step 6: Propose fix

One fix per root cause. If multiple fixes are possible, explain the tradeoff:

| Fix | Pros | Cons |
|-----|------|------|
| ... | ... | ... |

Wait for approval before applying.

## Escalation rule

If 3 consecutive fix attempts fail to resolve the issue:
1. **STOP.**
2. Report what was learned.
3. Ask the user to reframe the problem.

Do not keep guessing. Bad fixes compound.
