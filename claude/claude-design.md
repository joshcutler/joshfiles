# Claude Design — how it actually works (read before touching it)

Learned the hard way on 2026-09-04 (Plume design system: ~200 files landed in a
project that could never display them). Sources: Anthropic Help Center
"Set up your design system in Claude Design" and "Get started with Claude
Design" (support.claude.com/en/articles/14604397, /14604416); the DesignSync
tool description in Claude Code; measured behaviour in the tiding repo
(CONTRIBUTING.md, "Design System pushes").

## Two project types, and the type is immutable

- Claude Design has **regular projects** (a canvas of root-level `.html` pages;
  the Pages menu lists only root `.html` files) and **design-system projects**
  (`type: PROJECT_TYPE_DESIGN_SYSTEM`; a Design System pane that indexes
  `*.card.html` specimens, components, tokens, UI kits).
- **The type is set at creation and cannot be changed.** Pushing design-system
  files into a regular project never makes it a design system — the UI shows
  only the thumbnail and the work is invisible.
- In the web app a design system is created from org settings / onboarding
  (upload a codebase, DESIGN.md, slides, assets → Claude extracts it) or by the
  user picking "Design System" as the creation mode. Projects created on the
  home screen inherit the org's default design system.

## Two tool surfaces in Claude Code — use the right one

- **`DesignSync` (native tool, + `/design-sync` skill) is for design-system
  projects.** `DesignSync.create_project` creates a *design-system-type*
  project. `list_projects` lists only writable design-system projects.
  `get_project` returns `type` — check it before pushing. Writes go
  list/read → `finalize_plan` (writes/deletes globs + `localDir`) →
  `write_files` with `localPath` (contents never enter context; 256 files per
  call). Auth is `/design-login`.
- **`mcp__claude-design__*` (raw MCP server) is the general Claude Design
  API.** Its `create_project` makes a **regular** project (no type parameter).
  Its `write_files`/`copy_files` need `finalize_plan(scope:"project")` first and
  paste content inline. `copy_files` with `src_project_id` copies whole folders
  server-side between projects — the fast way to move a tree into a
  design-system project after a mistake.
- Rule: **to create or push a design system, use `DesignSync`, never the raw
  MCP `create_project`.** If a project id is handed to you, `get_project` and
  confirm `PROJECT_TYPE_DESIGN_SYSTEM` before writing anything.

## What a design-system project is made of

- `readme.md` (brand doc + index), `SKILL.md`, `styles.css` (imports
  `tokens/*.css`), `thumbnail.html`, `components/<group>/Name.jsx` +
  `Name.d.ts` + `Name.prompt.md`, `guidelines/*.card.html`,
  `ui_kits/<product>/index.html`.
- Cards are HTML whose **first line** is
  `<!-- @dsCard group="…" viewport="WxH" name="…" subtitle="…" -->`.
- The pane index is `_ds_manifest.json` and cards render against
  `_ds_bundle.js` (`window.<Name>DesignSystem_<id6>`, one IIFE per component
  registering into `__ds_scope`, React from the global). **Both are compiled
  by the app on its own schedule, not by your push** — a new card or component
  is unindexed / unrenderable until the app recompiles. Either build them
  locally in the same format (esbuild JSX transform) and push them, or ship
  `_ds_fallbacks.jsx` guards; then verify *both* that the card is listed and
  that it renders (they fail independently, silently).
- A blank card means the bundle threw or a component was `undefined`; there is
  no visible error. Check `window.<ns>.__errors` in a temporary `<pre>`.

## Consumer projects (regular projects that use a design system)

- A regular project binds a design system through the web app (the project's
  "Design system" button) — the MCP can set one only at `create_project`
  (`design_system_id`). The app then materialises the DS under
  `_ds/<slug>-<project-id>/` (tokens, styles.css, readme, and **its own
  compiled** `_ds_bundle.js` + `_ds_manifest.json`); pages load from those
  paths. Old bindings stay as sibling `_ds/` folders; leave them to the app.
- Pages are `.dc.html` (Design Components: `<x-dc>`, `<helmet>`, `support.js`,
  `data-props`, `sc-for`, `x-import`); load the format rules with
  `get_claude_design_prompt(design_system_id, project_id)` before writing.
  Keep file names stable — issue links point at `?file=<name>`.
- Traps measured 2026-09-04: a card inside a flex-column scroll area needs
  `flex: none` or it clips; never put `data-presets="react"` on an inline
  Babel script that shares a page with per-file Babel scripts (const/var
  redeclaration → blank page); don't nest an `x-import` inside a Card
  `x-import`.
- Writes from Claude Code to a regular project use the raw MCP
  (`finalize_plan(scope:"project")` → `write_files` with `if_match`);
  `DesignSync` refuses non-design-system projects.

## Verify without opening the user's browser

`mcp__claude-design__render_preview` returns a short-lived `serve_url`;
render it with headless Chrome
(`/Applications/Google Chrome.app/Contents/MacOS/Google Chrome --headless=new
--screenshot=out.png --window-size=W,H URL`) and Read the PNG. Never paste the
`serve_url` to the user; give `open_url`.

## Say it up front

If asked for "a design system on Claude Design", the first sentence of the plan
names the project type and which tool creates it. If the tool at hand cannot
create that type, say so before writing a single file and ask the user to
create the design-system project in the web app (then copy in).
