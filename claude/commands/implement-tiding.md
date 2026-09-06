# Implement a Tiding Issue

You are implementing an issue for the Tiding platform (`WithMagpie/tiding`
epics/children; `tiding-server`, `tiding-runtime`, `tiding-ios` for code).

**Standing assumptions (2026-09-03 owner decisions):** Tiding is SaaS;
runtimes are operator-run inside the platform trust boundary (no BYO hosts);
capability access is per-delivery tokens, never standing (tiding#36); no
parity target exists — anything contradicting these is stale, and a finding.

## Phase 0: The gate

1. `gh issue view <N> --repo WithMagpie/tiding` — body, labels, comments.
2. **If the issue carries `needs-spec`: halt.** Tell the user to run
   `/feature-tiding <N>` first. Do not spec-and-implement in one motion — the
   interview is the user's control point, and collapsing the two removes it.
3. **Read the Conformance section** (per the tiding repo's `CONTRIBUTING.md`):
   §1 capability removal, §2 interagent, §3 blast radius, §4 schema strength.
   An absent or blank answer halts:
   name what is missing, offer once to draft it into the issue with
   `gh issue edit` for approval, and do not proceed on answers that live only
   in this conversation. `n/a` with a reason passes.
4. **For a `tiding-ios` issue, read the spec's Design section.** An iOS issue
   with a UI component must link its Claude Design element (owner rule
   2026-09-04, tiding `CONTRIBUTING.md`); `Design: no UI component` passes.
   A UI issue with no design link halts the same way a blank conformance
   answer does — send it back through `/feature-tiding`.
5. Read the parent epic — from the sub-issue link (`--json parent`), not a title
   prefix — and the architecture sections the issue cites
   (`docs/ARCHITECTURE.md` in the tiding repo — `~/code/tiding` on this
   machine). The doc's decisions are commitments; an implementation that violates one is
   a finding to raise, not a detail to absorb.

## Phase 1: Branch

Ask via **AskUserQuestion** whether to branch; default
`feat/<brief-description>` off the owning repo's main.

Once branched, move the board: `~/code/joshfiles/claude/bin/tiding-status <N>
"In Progress"`. The remaining moves
are automatic — the project's *Pull request linked* workflow sets `In Review`
when the PR opens and *Item closed* sets `Done` when the merge closes the issue,
so do not set those by hand. The board never gates anything; the `needs-spec`
label does. A failed status call is worth one line in your summary, not a halt.

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
- **Build the simplest thing that satisfies the spec, in the framework's own
  idiom** (tiding `CONTRIBUTING.md`, "Simple is the default"). Plain Active
  Record over a service object that wraps one call; a generator's output over
  hand-written boilerplate; SwiftUI's own state over a bespoke store. Nothing
  the spec did not ask for: no configuration knob with one value, no
  abstraction with one caller, no extension point for a hypothetical second
  case, no cache before a measurement asked for one. Scope beyond the spec is
  raised as a question, not implemented quietly.
- **Do not invent a guard the spec did not ask for.** A rescue around
  something that cannot raise, a validation on a field only our own code
  writes, a boot-time probe of a framework facility — these read as diligence
  and are how tiding#15 nearly broke its first production deploy. If a guard
  seems necessary and the spec is silent, raise it; if it is security, name
  the attacker, the reachable path, and what they get, or leave it out.
- **No home-rolling what a robust, well-supported library already does** —
  and no new dependency for what the framework or standard library already
  does. The spec's Dependencies section is the decision record. If
  mid-implementation you find yourself building machinery a mature library
  covers and the spec never decided it, stop and raise it as a spec question
  (the mid-implementation objection flow in the tiding repo's
  `CONTRIBUTING.md`) — hand-rolling by default is not an implementation
  detail, and neither is adding a gem.
- **Read the library's docs before using it, and cite the URL in the code
  comment.** Never assert a gem's or framework's behaviour from memory or from
  "the usual fix" — check the library's own documentation (context7 MCP, then
  its README and official guides), and put the URL beside the claim so a
  reviewer checks it instead of trusting it. Where the docs are silent, read
  the source and label the comment as source-not-docs. Prefer asserting the
  behaviour in a test over describing it in a paragraph. Measured on tiding#15:
  a Devise API-mode claim that was exactly backwards, and an invented cache
  probe that would have broken the first production deploy — see "Read the
  library's docs; do not infer its API" in the tiding repo's `CONTRIBUTING.md`.
- **Grep the repo for an existing guard before writing a new one.** A shared
  concern, a support module, a scope, a matcher. The E3.1 auth surface
  re-opened a NUL-byte 500 that `WirePayload` had already closed, by building a
  new controller base that did not include it. Reuse beats rediscovery, and a
  guard with two call sites is stronger than two guards with one.

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
- The engines (the day-model libraries vendored under `engines/`) change
  only via an issue that names the day-model behaviour being changed — never
  as a side effect of loop or tooling work.

**`tiding-ios` (Swift):**
- Staleness states are first-class UI states: `generated_at` + last-sync
  stamps, "could not refresh since X", `could_not_check` distinct from both
  "clear" and "no data", "no report received for <period>" for absence.
- The client renders closed vocabularies; an unknown enum value is an error
  state, never silently skipped.
- The implementation matches the spec's linked Claude Design element;
  divergence is raised as a spec question (the design amends with the spec),
  never absorbed silently.

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
  path are not evidence the distinction survives the wire.
- If the issue touches launch-critical behaviour, note the E8 verification
  checklist line it affects.

## Phase 5: The standing requirement

Tiding inherits it: **a stranger with the repo must reach a good state from
the deploy/setup docs alone.** If this changes what that stranger must do, the
doc changes in the same commit. Then propose additions to the tiding repo's
`CONTRIBUTING.md` for anything that cost real time — proposed wording, not "we
should document this".

## Phase 6: Summary

Branch, key changes, actual test counts and the command that produced them,
what was verified against the real surface versus only unit-tested, **which
library behaviours were verified against docs (name them, with URLs) versus
assumed**, doc deltas or "onboarding unchanged", and next steps. Reference the
issue number in commits; PRs auto-close their issue.
