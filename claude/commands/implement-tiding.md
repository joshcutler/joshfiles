# Implement a Tiding Issue

You are implementing an issue for the Tiding platform (`joshcutler/tiding`
epics/children; `tiding-server`, `tiding-runtime`, `tiding-ios` for code;
M-issues in `joshcutler/magpie` use `/implement-magpie` instead — its container
and vault guardrails apply there and not here).

## Phase 0: The gate

1. `gh issue view <N> --repo joshcutler/tiding` — body, labels, comments.
2. **If the issue carries `needs-spec`: halt.** Tell the user to run
   `/feature-tiding <N>` first. Do not spec-and-implement in one motion — the
   interview is the user's control point, and collapsing the two removes it.
3. **Read the Conformance section** (per the tiding repo's `CONTRIBUTING.md`):
   §1 capability removal, §2 interagent, §3 blast radius, §4 schema strength.
   An absent or blank answer halts, exactly like `/implement-magpie` Phase 0.5:
   name what is missing, offer once to draft it into the issue with
   `gh issue edit` for approval, and do not proceed on answers that live only
   in this conversation. `n/a` with a reason passes.
4. Read the parent epic and the architecture spec sections the issue cites
   (`~/code/magpie/docs/superpowers/specs/2026-09-02-tiding-architecture-design.md`).
   The spec's decisions are commitments; an implementation that violates one is
   a finding to raise, not a detail to absorb.

## Phase 1: Branch

Ask via **AskUserQuestion** whether to branch; default
`feat/<brief-description>` off the owning repo's main.

## Phase 2: Implementation constraints

**Everywhere:**
- The action space IS the API surface. Never add a terminal, filesystem,
  generic-HTTP, or arbitrary-callable capability to any agent-reachable
  component — if the task seems to need one, stop and raise it; that is an
  architecture change, not an implementation detail.
- The relay contract stays **runtime-identifier-free**. A contract change
  rides only in an issue whose spec declares contract impact, with a version
  bump and updated worked examples.
- No silent defaults: a missing required field is an error, everywhere.

**`tiding-server` (Rails):**
- Every table carries `household_id`; every controller resolves principal →
  household first. New models/controllers adopt the E1.2 shared enforcement
  test — inheriting the pattern is part of done.
- The three token shapes (user / agent-host / operator-none) never blur; a
  cross-shape access test accompanies any new surface.
- The `rails-*` subagents are available and appropriate here (rails-models,
  rails-controllers, rails-qa, rails-security-performance). The Conformance
  and safety-property tests stay in your own hands.
- Append-only stores stay append-only: adding a mutation verb to reports or
  vault pages is an architecture change, however convenient.

**`tiding-runtime` (Python):**
- No database client, no listening socket, no filesystem writes outside its
  own config — and the banned-call lint that asserts this stays green.
- Tools exist only through the typed registry; the registry's allowlist test
  changes visibly when a tool is added.
- The engines (week-check / family-agenda day model) are imported, never
  edited here. A needed engine change is a magpie-repo issue.

**`tiding-ios` (Swift):**
- Staleness states are first-class UI states: `generated_at` + last-sync
  stamps, "could not refresh since X", `could_not_check` distinct from both
  "clear" and "no data", "no report received for <period>" for absence.
- The client renders closed vocabularies; an unknown enum value is an error
  state, never silently skipped.

## Phase 3: Tests

Test-first for anything behavioural: watch the failing test fail for the
expected reason before making it pass. Every safety property in the spec gets
its own test. Run the owning repo's full suite; **report actual counts**, not
"tests pass".

## Phase 4: Verify like it ships

Unit tests are not the thing that ships:

- Exercise the real surface: a request through the real middleware stack, a
  runtime turn against a stub server, a device build against the live API —
  whichever the issue's layer means.
- Force the failure paths from the spec's safety properties at least once for
  real (revoked token, dead host, missing report) — green tests on the happy
  path are not evidence the distinction survives the wire. This is magpie's
  most expensive lesson, inherited deliberately.
- If the issue touches parity-relevant behaviour, note the E8 checklist line
  it affects.

## Phase 5: The standing requirement

Tiding inherits it: **a stranger with the repo must reach a good state from
the deploy/setup docs alone.** If this changes what that stranger must do, the
doc changes in the same commit. Then propose additions to the tiding repo's
`CONTRIBUTING.md` for anything that cost real time — proposed wording, not "we
should document this".

## Phase 6: Summary

Branch, key changes, actual test counts and the command that produced them,
what was verified against the real surface versus only unit-tested, doc
deltas or "onboarding unchanged", and next steps. Reference the issue number
in commits; PRs auto-close their issue.
