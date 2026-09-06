---
description: Review session work for errors, edge cases, and needless complexity
---

# Session Review Command

You are reviewing the work done **by this agent in this session only**. Your goal is to identify errors, missed edge cases, needless complexity, and conformance issues with the project's established conventions.

Report what is actually wrong. A review that pads itself with suggestions nobody asked for is worse than a short one: it costs the reader time and it hides the finding that mattered.

## CRITICAL: Multi-Agent Scope Rules

**Multiple Claude Code agents frequently work on this codebase concurrently.** The git working tree likely contains uncommitted changes from OTHER agents that are NOT part of your work. You MUST scope this review strictly to files YOU changed in THIS session.

- **ONLY report issues in files you created or modified in this session.** If you see changes in `git diff` to files you didn't touch, those belong to another agent — do not flag issues in them.
- **Do NOT flag issues in other agents' files.** Do not report bugs, style issues, or missing tests for code you didn't write this session.
- You MAY read other files for context (e.g., to understand how your code integrates with existing code, check method signatures, verify associations), but **all reported findings must be about YOUR code only.**
- If you are unsure whether you changed a file, err on the side of excluding it from findings.

## Step 1: Gather Context

1. Review your own conversation history to build a list of files YOU created or modified in this session
2. Run `git diff` to see all unstaged/staged changes in the working tree
3. Run `git diff --cached` to see staged changes specifically
4. Run `git log --oneline -20` to understand recent commit history
5. Read the project's `CLAUDE.md` to refresh on conventions and best practices

**Filter the diff output to ONLY the files you changed.** Ignore everything else. Combine this to understand the scope of YOUR work this session.

## Step 2: Read All Changed Files (YOUR files only)

For every file that YOU modified, added, or deleted in this session:
- Read the **full file** (not just the diff) to understand the complete context
- Note what was changed and how it fits into the surrounding code

Do NOT skip any of YOUR files. Read them all before starting analysis.
You MAY read other files (including ones changed by other agents) for context — e.g., to understand interfaces, verify integration points, or check conventions. But **only report findings for YOUR files.**

## Step 3: Analyze for Issues

Use these categories as places to *look*, not as buckets to fill. A category
with nothing wrong in it produces no finding and no line of output — an empty
category is the normal case, and inventing something to say about it is worse
than silence, because it buries the findings that are real.

The bar for a finding: **something is wrong, or will be wrong under an input
the code can actually receive.** Not something that could be arranged
differently. If you cannot state what breaks and roughly when, it is not a
finding.

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

### 3c: Simplification
The target is the smallest idiomatic code that does the job, so this category
mostly finds things to **remove**:
- Code that fights the framework instead of using what it already provides
- Speculative generality: a configuration knob with one value, an abstraction
  with one caller, an extension point for a case nobody has asked for, a
  wrapper around a single library call, a cache nobody measured the need for
- Defensive code that cannot fire — a rescue around something that does not
  raise, a validation on a field only our own code writes
- Genuine duplication (the same logic in three places, drifting), not two
  similar-looking lines
- Poor naming that obscures intent

Do **not** propose extracting a concern, service, or value object to make
code "cleaner" when the plain version is readable and works. YAGNI: a
refactor is a finding only when the current shape is already causing a
problem you can name.

### 3d: Convention Conformance
- Check against CLAUDE.md project conventions
- Routing conventions (param names, namespace patterns)
- Testing conventions (what should/shouldn't have tests)
- Component conventions (ViewComponent patterns, naming)
- Service layer patterns (value objects, Data.define usage)
- Background job patterns (discard_on, queue selection, Turbo broadcasts)

Where the project already has audit logging, activity tracking, or system-status
checks, new code of the same kind joins them — that is conformance. Proposing
one of those systems where the project does not have it is a feature request,
not a review finding.

### 3e: Security
A security finding names **the attacker, the reachable path, and what they
get**. Real ones get reported in full, at whatever length they need:
- SQL injection, XSS, command injection where untrusted input actually reaches
  the sink
- Mass assignment (strong params) on attributes a user must not set
- Sensitive data in logs, error messages, or responses
- A missing authorization check on a surface a different user can reach

Generic hardening with no reachable path is not a finding. If the answer to
"who is the attacker and how do they get here" is "nobody, currently", leave
it out.

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

### Worth doing
Simplifications that would remove real complexity. Omit this section entirely
if there are none — it is not a quota, and style preferences do not belong in
it.

For each finding:
1. State the issue clearly in one sentence
2. Reference the specific file and line(s)
3. Explain what breaks, and under what input or conditions
4. Suggest the smallest fix that works

## Step 5: Summary

End with a brief overall assessment:
- How many findings in each severity level
- Whether the work is ready to commit/merge as-is or needs fixes first
- One sentence on the overall quality of the work

## Important Guidelines

- **ONLY review YOUR changes from THIS session.** Other agents have uncommitted work in the tree — ignore it completely.
- Be thorough but practical — focus on real issues, not style nitpicks
- **A clean review is a legitimate result.** "No findings" said in one line is
  a better review than five manufactured suggestions
- Don't flag things that are intentional patterns in this codebase (check CLAUDE.md)
- Consider the broader system impact of your changes, not just the changed files in isolation
- If you're unsure whether something is an issue, mention it as a question rather than a definitive finding
- Do NOT make any changes — this is a read-only review
