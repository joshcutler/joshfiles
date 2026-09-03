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

**Standing assumptions (2026-09-03 owner decisions — an interview answer or
epic line contradicting them is stale, and that is a finding):** Tiding is
SaaS; every runtime is operator-run inside the platform trust boundary (no
BYO agent hosts, ever); capability access is per-delivery tokens, never a
standing credential (tiding#36); there is no parity target or legacy
comparator — the system is built against its own spec.

## Hard rules

- **Never write real or invented household facts into an issue.** Placeholders
  only: `<person-a>`, `<activity>`, `15:15`.
- **Do the work inline** for the interview and the spec writing. The `rails-*`
  subagents may be consulted for `tiding-server` domain questions
  (rails-architect for design trade-offs especially), but the spec is yours to
  write and the safety sections are never delegated.
- The spec lands **in the issue body** via `gh issue edit`, replacing the stub.
  A spec that lives only in conversation does not exist.

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

**Staleness and delivery**, where user-visible:
- What stamps does the client get (`generated_at`, last-sync)? What renders on
  a boring day, and on a failed-to-look day?

## Step 3: Write the spec into the issue

Structure (drop sections that genuinely do not apply; never pad):

```markdown
## Problem statement
## Owning repo and parent epic
## Requirements (must-have / non-goals)
## Technical approach
## Safety properties        — testable assertions in the closed vocabularies
## Tenancy                  — principals, token shapes, scoping enforcement
## Contract impact          — schemas touched + version note, or "none"
## Edge cases
## Testing plan             — per-repo conventions; safety properties each get a test
## Conformance              — §1–§4 per CONTRIBUTING.md; n/a with a reason is
                              valid, a blank is not
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
