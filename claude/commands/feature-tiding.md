# Spec a Tiding Issue

You are turning a Tiding work-stub (or a new idea) into a full spec that
`/implement-tiding` can execute without re-litigating anything. Tiding is a
commercial SaaS household-agent platform; its issues live in
`WithMagpie/tiding` (platform epics E1–E8 and their children). Stubs are
labeled **`needs-spec`**;
removing that label is the *output* of this command, never a tidying action.

**Epics are sub-issue parents, not a title convention.** Every work issue is a
native GitHub sub-issue of its epic — that link is what puts it on the
[board](https://github.com/orgs/WithMagpie/projects/1). **New titles carry no
`E5.3:` prefix**; the parent says which epic it belongs to. If this command is
given a *new idea* rather than an existing issue, file it first per the filing
procedure in the tiding repo's `CONTRIBUTING.md` — `gh issue create` with
`--label needs-spec`, then `addSubIssue` under its epic — and confirm the number
with the user before interviewing.

The founding failure mode this exists to prevent: specs that say what a
component should *do* and nothing about what it must do when it **cannot look**.

**Standing assumptions (2026-09-03/04 owner decisions — an interview answer
or epic line contradicting them is stale, and that is a finding):** Tiding is
SaaS; every runtime is operator-run inside the platform trust boundary (no
BYO agent hosts, ever); capability access is per-delivery tokens, never a
standing credential (tiding#36); new capabilities land as `tiding-server`
APIs — the runtime never gains a third-party client, and a spec placing a
fetch in the runtime is an ARCHITECTURE amendment that must answer the three
tests from tiding#18 (credential custody without a database,
`could_not_check` as a wire state, audit via the request log); there is no
parity target or legacy comparator — the system is built against its own
spec.

## Hard rules

- **Never write real or invented household facts into an issue.** Placeholders
  only: `<person-a>`, `<activity>`, `15:15`.
- **Do the work inline** for the interview and the spec writing. The `rails-*`
  subagents may be consulted for `tiding-server` domain questions
  (rails-architect for design trade-offs especially), but the spec is yours to
  write and the safety sections are never delegated.
- The spec lands **in the issue body** via `gh issue edit`, replacing the stub.
  A spec that lives only in conversation does not exist.
- **Spec the simplest thing that satisfies the issue**, in the framework's own
  idiom (tiding `CONTRIBUTING.md`, "Simple is the default"). A spec is not
  improved by adding scope: no configuration knob with one value, no
  abstraction with one caller, no extension point for a case nobody has asked
  for. If the interview surfaces a genuinely larger want, that is a separate
  issue, named as such — not a section quietly added to this one.
- **Security belongs in a spec when it is real** — an attacker, a reachable
  path, and what they get. Say that plainly and at length when it applies.
  Do not pad a spec with hardening that no reachable path calls for; it buries
  the finding that matters.

## Step 1: Orient

Read, in order:

1. `docs/ARCHITECTURE.md` in the tiding repo (`~/code/tiding` on this
   machine) — the source of truth. §3 (doctrine and guard classes), §7
   (protocol; `tiding-server/contracts/v1/` is normative for shapes), §8
   (capability APIs), §9 (safety properties) are load-bearing for almost
   every issue.
2. The issue's **parent epic** — read it from the sub-issue link, not the title
   (`gh issue view <N> --repo WithMagpie/tiding --json parent`). It carries
   capability statements the child must re-answer in detail. An issue with **no
   parent** is a finding: say so and ask which epic it belongs under before
   interviewing, rather than speccing an orphan.
3. `CONTRIBUTING.md` in the tiding repo — the lifecycle and standing invariants.
4. The current state of the owning repo (`tiding-server` / `tiding-runtime` /
   `tiding-ios`), if it exists yet — a spec against imagined code is stale on
   arrival, which is why stubs are specced just-in-time.

Summarize in a few lines what exists that this issue touches, naming real files
or, pre-repo, the epic decisions that constrain it.

## Step 2: Interview, in rounds, until nothing is ambiguous

Use **AskUserQuestion**, 2–4 questions per round, as many rounds as it takes.
Adapt to the issue; the categories that are never skipped:

**The safety axis — every time:**
- What does this return when it **cannot look**? `could_not_check` and
  `nothing_to_report` must never collapse — and for an endpoint: what shape
  does each state have? An empty list for both is the founding failure mode.
- What does it return when it can look but **cannot tell**? `cannot_tell` is
  not a negative verdict.
- What is the failure this must never have? Name it concretely.

**Doctrine (the action-space rule):**
- Does this add a tool, verb, endpoint, or field? Then its blast-radius
  statement is written in the spec, *before* it exists (ARCHITECTURE §3).
- Could this reintroduce a generic capability (an open-ended fetch, an
  arbitrary callable, a path argument)? Name what structurally prevents it.

**Tenancy:**
- Which principal(s) reach this, with which token shape? What enforces
  household scoping — and is it the inherited enforcement pattern (E1.2) or
  something bespoke that needs its own test?

**Contracts:**
- Does this touch an E2 schema? Contract changes are versioned, keep
  vocabularies closed, and stay runtime-identifier-free. A contract change made
  casually inside an unrelated issue is a finding.

**Build vs. buy — only when the issue would build real machinery:**
- First ask whether the framework already does it: Rails, the standard
  library, or a gem the app already carries. If it does, that is the answer,
  the spec names it in one line, and there is nothing to put to the user.
- Only when the framework has no answer and the machinery is substantial
  (scheduling/RRULE parsing, state machines, webauthn, push delivery, …) find
  the leading candidates — check real health: maintenance activity, adoption,
  recent releases — and present them **as AskUserQuestion choices** alongside
  the home-roll option, with concrete trade-offs. A new dependency for a
  problem twenty lines of ordinary code solves is its own kind of complexity;
  so is hand-rolling auth.
- A dependency is also surface: the chosen library answers the same doctrine
  questions as our own code — what capabilities it drags in, its blast radius
  inside the trust boundary, whether its behaviour on failure preserves the
  `could_not_check` distinctions. A library that collapses them is a reason
  to reject it, and that reasoning goes in the spec.
- **Verify the candidate before the spec names it, and record where you
  looked.** Three checks, none skippable: the gem *exists* at the version the
  spec will cite (RubyGems, its releases); its **documented** usage fits this
  app's actual shape — `api_only`, no session middleware, our own token auth,
  whatever the owning repo already is; and its docs are read, not recalled.
  Put the doc URL in the issue's Dependencies section beside the pick, and name
  any documented incompatibility as an edge case rather than leaving it to be
  discovered mid-implementation. Measured on tiding#15: `devise-webauthn` was
  real, current, and correctly chosen, but its README documents no API-only
  usage and its controllers call `skip_forgery_protection`, which
  `ActionController::API` does not have — so they cannot load in that app at
  all. The Dependencies section had the gem right and its *fit* unchecked, and
  the incompatibility surfaced as a broken CI boot during implementation.

**Design — every time the issue works on the iOS app:**
- Does this issue have a UI component — does it change anything a user sees?
  If yes, a **corresponding Claude Design element is required** before the
  spec gate closes (owner rule 2026-09-04; see the tiding repo's
  `CONTRIBUTING.md`): create or update the design element via Claude Design
  MCP for the screens/states this issue touches — composed from the existing
  **Plume Design System** (components and tokens; extending the system is a
  deliberate, recorded decision, never an ad-hoc restyle) — and link it in
  the spec's Design section. The system is the Claude Design design-system
  project "Plume Design System" (id `e8a1a95f-eac8-404a-872c-50da1d023756`;
  it superseded the Magpie Design System `4c6d4589-…` on 2026-09-04 — same
  component inventory and prop contracts, a warm playful brand, and the
  category colour + icon system), read via the `DesignSync` tool /
  `/design-sync` skill; auth is `/design-login` (a plain `/login` token has no
  Design access). Its `components/intelligence` group, `components/surfaces`
  (`AgendaItem`, `DayHeader`) and `ui_kits/mobile-app` kit are the starting
  palette for iOS work; page designs live in the "Magpie iOS" project
  (`22feed73-…`, rebuilt on Plume). The staleness states render there as
  visually distinct artboards (`could_not_check` / `nothing_to_report` /
  no-report-received) — the design is where "visually distinct" is checked
  before code exists. A DS push must patch `_ds_manifest.json` and
  `_ds_fallbacks.jsx` in the same motion (tiding `CONTRIBUTING.md`, "Design
  System pushes go through two compiled artifacts").
- If no, the spec states `Design: no UI component` explicitly — a missing
  section is a blank, and a blank is not an answer.

**Staleness and delivery**, where user-visible:
- What stamps does the client get (`generated_at`, last-sync)? What renders on
  a boring day, and on a failed-to-look day?

## Step 3: Write the spec into the issue

Structure (drop sections that genuinely do not apply; never pad). Length is
proportional to the change: most sections are a few lines, and a section whose
honest answer is one line stays one line.

```markdown
## Problem statement
## Owning repo and parent epic
## Requirements (must-have / non-goals)
## Technical approach
## Safety properties        — testable assertions in the closed vocabularies
## Tenancy                  — principals, token shapes, scoping enforcement
## Contract impact          — schemas touched + version note, or "none"
## Design                   — link to the Claude Design element (required for
                              any iOS issue with a UI component), or
                              "no UI component" stated explicitly
## Dependencies             — libraries chosen, each with the doc URL read and
                              any documented incompatibility with this app's
                              shape (and the home-roll or alternatives
                              rejected, with why), or "none new"
## Edge cases
## Testing plan             — per-repo conventions; safety properties each get a test
## Conformance              — §1–§4 per CONTRIBUTING.md; n/a with a reason is
                              valid, a blank is not; four honest n/a's is a
                              complete section for a change that adds no verb,
                              field, endpoint, or credential
## Acceptance criteria      — includes "counts reported, not 'tests pass'"
```

Then:

```bash
gh issue edit <N> --repo WithMagpie/tiding --body-file <spec> \
  && gh issue edit <N> --repo WithMagpie/tiding --remove-label needs-spec \
  && ~/code/joshfiles/claude/bin/tiding-status <N> Specced
```

**The label is the gate; the board is the view.** Removing `needs-spec` is what
`/implement-tiding` reads. The `tiding-status` call only keeps the board honest,
and it is chained after the label edit deliberately: if it fails, the gate has
still moved correctly and the board is merely stale. Never do the reverse — a
board move without the label change is a lie the commands cannot see.

Confirm to the user: issue number, what was decided, that `needs-spec` is off —
which is the signal `/implement-tiding` accepts it — and that the board reads
Specced.
