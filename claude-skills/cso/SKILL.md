---
name: cso
version: 1.0.0
description: |
  Security audit — OWASP Top 10 + STRIDE threat model on current changes
  or the full codebase. Use when asked to "security audit", "check for
  vulnerabilities", "threat model", or "security review".
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
---

# /cso — Security Audit

You are performing a security audit. Report only — do NOT fix anything automatically.

## Step 0: Determine scope

- Default: current uncommitted changes + branch diff.
- If the user passes `--full`: audit the entire codebase.

```bash
_BASE=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')
[ -z "$_BASE" ] && _BASE=$(git rev-parse --verify origin/main 2>/dev/null && echo main || echo master)
git diff $_BASE...HEAD --stat
```

## Step 1: OWASP Top 10

Check for the most likely vulnerabilities given the project's stack:

| # | Category | What to look for |
|---|----------|-----------------|
| A01 | Broken Access Control | Missing auth checks, IDOR, privilege escalation |
| A02 | Cryptographic Failures | Hardcoded secrets, weak hashing, PII in logs |
| A03 | Injection | SQL injection, command injection, XSS, prompt injection |
| A04 | Insecure Design | Missing rate limiting, no abuse prevention |
| A05 | Security Misconfiguration | CORS wildcards, debug mode in prod, permissive headers |
| A06 | Vulnerable Components | Known CVEs in dependencies |
| A07 | Auth Failures | Weak sessions, missing MFA hooks, credential stuffing vectors |
| A08 | Data Integrity Failures | Trusting unsigned data, insecure deserialization |
| A09 | Logging Failures | Missing audit trail, secrets in logs |
| A10 | SSRF | Unvalidated URLs in server-side requests |

## Step 2: STRIDE Threat Model

For each component that handles external input:

- **Spoofing** — Can an attacker impersonate a legitimate user or service?
- **Tampering** — Can request data be modified in transit or at rest?
- **Repudiation** — Can actions be performed without audit trail?
- **Information Disclosure** — Can sensitive data leak through errors, logs, or side channels?
- **Denial of Service** — Can the service be overwhelmed or made unavailable?
- **Elevation of Privilege** — Can a normal user gain admin access?

## Step 3: AI-specific checks (if applicable)

If the project uses AI/LLM APIs:

- Prompt injection via user-controlled input reaching the AI layer
- Missing sanitization before AI API calls
- AI responses being trusted and executed without validation
- Token/cost abuse through unbounded AI calls

## Step 4: Secrets archaeology

```bash
git log --all --diff-filter=D -- '*.env' '*.key' '*.pem' 2>/dev/null | head -10
```

Search for hardcoded secrets in current code:

- API keys, tokens, passwords in source files
- `.env` files committed to git
- Secrets in CI/CD config files

## Step 5: Report

**Confidence gate:** Only report findings with 8/10+ confidence in the main findings. Lower-confidence suspicions go in a separate "Worth Investigating" section.

For each finding:

```
### [SEVERITY] Finding title

**Category:** OWASP A0X / STRIDE category
**Location:** file:line
**Confidence:** X/10

**Vulnerability:** What the issue is.

**Exploit scenario:** How an attacker would exploit this, step by step.

**Recommended fix:** What to change, specifically.
```

Group findings by severity: **CRITICAL** > **HIGH** > **MEDIUM** > **LOW**.

End with a summary count and overall risk assessment.
