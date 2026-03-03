---
description: Review session work for errors, edge cases, and refactoring opportunities
---

# Session Review Command

You are reviewing the work done in the current session. Your goal is to identify errors, missed edge cases, obvious refactoring opportunities, and conformance issues with the project's established conventions and best practices.

## Step 1: Gather Context

1. Run `git diff` to see all unstaged/staged changes in the working tree
2. Run `git diff --cached` to see staged changes specifically
3. Run `git log --oneline -20` to understand recent commit history
4. Read the project's `CLAUDE.md` to refresh on conventions and best practices

Combine all of this to understand the full scope of work done this session.

## Step 2: Read All Changed Files

For every file that was modified, added, or deleted:
- Read the **full file** (not just the diff) to understand the complete context
- Note what was changed and how it fits into the surrounding code

Do NOT skip any files. Read them all before starting analysis.

## Step 3: Analyze for Issues

Evaluate the work across these categories, reporting findings for each:

### 3a: Errors and Bugs
- Logic errors, off-by-one mistakes, nil/null safety issues
- Missing error handling at system boundaries
- Race conditions in concurrent code
- Incorrect method signatures or wrong return types
- Broken associations, missing foreign keys, or invalid queries

### 3b: Edge Cases
- Empty collections, nil values, missing records
- Boundary conditions (zero, negative, very large values)
- Missing validation on user input
- Behavior when external services are unavailable
- Unicode, special characters, or unexpected input formats

### 3c: Refactoring Opportunities
- Duplicated logic that should be extracted
- Long methods that should be broken up
- Poor naming that obscures intent
- Missing or misused abstractions (e.g., should be a concern, service, or value object)
- Code that fights the framework instead of using built-in patterns

### 3d: Convention Conformance
- Check against CLAUDE.md project conventions
- Routing conventions (param names, namespace patterns)
- Testing conventions (what should/shouldn't have tests)
- Component conventions (ViewComponent patterns, naming)
- Service layer patterns (value objects, Data.define usage)
- Audit logging — should any new user actions be logged?
- Activity tracking — should any new jobs be trackable?
- System status — should any new checks be added?
- Background job patterns (discard_on, queue selection, Turbo broadcasts)

### 3e: Security
- SQL injection, XSS, command injection risks
- Mass assignment vulnerabilities (strong params)
- Sensitive data exposure (logging, error messages)
- Missing authorization checks (if applicable)
- OWASP top 10 concerns

### 3f: Performance
- N+1 queries (missing includes/eager loading)
- Unnecessary database queries in loops
- Missing database indexes for new columns or query patterns
- Expensive operations that should be background jobs

## Step 4: Report Findings

Present findings organized by severity:

### Critical (must fix)
Issues that will cause bugs, data loss, or security vulnerabilities in production.

### Important (should fix)
Edge cases, missing validations, or convention violations that could cause problems.

### Suggestions (nice to have)
Refactoring opportunities and style improvements that would improve code quality but aren't urgent.

For each finding:
1. State the issue clearly in one sentence
2. Reference the specific file and line(s)
3. Explain **why** it's a problem
4. Suggest a fix

If a category has no findings, say so explicitly — don't skip it silently.

## Step 5: Summary

End with a brief overall assessment:
- How many findings in each severity level
- Whether the work is ready to commit/merge as-is or needs fixes first
- One sentence on the overall quality of the work

## Important Guidelines

- Be thorough but practical — focus on real issues, not style nitpicks
- Don't flag things that are intentional patterns in this codebase (check CLAUDE.md)
- Consider the broader system impact of changes, not just the changed files in isolation
- If you're unsure whether something is an issue, mention it as a question rather than a definitive finding
- Do NOT make any changes — this is a read-only review
