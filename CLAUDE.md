# CLAUDE.md

Project guidance for the EMSE 4572/6572 **Exploratory Data Analysis** course
website (Fall 2026), built with [Quarto](https://quarto.org/).

> **This course is mid-revision (as of June 2026).** It is being shifted from
> *hand-writing* tidyverse/ggplot code toward **directing agentic AI tools
> (Claude Code in Positron) to do the data work**, while still teaching the
> underlying concepts so students can supervise and verify the AI. The original
> revision brief lives outside the repo at `~/Downloads/eda-revision/prompt.md`.

## The revision in a nutshell

- **Concepts stay** (tidy/long-wide data, joins, distributions/variability/
  correlation, graphical-perception & chart-design principles, chart types,
  polishing, maps, interactivity, storytelling). **The toolchain changes** —
  students drive these with agents instead of hand-coding.
- **Weeks 1–3 front-load workflow:** W1 = light intro + abbreviated tidyverse/
  ggplot refresher (read the code, don't write it); W2 = **GitHub Desktop (no git
  CLI) + setting up Claude Code in Positron**; W3 = cleaning/reshaping/joining
  driven through agents. Proposals brew on the side; W4 = proposal reflection
  (no class, 1-on-1s).
- **Interactivity week (W12)** reshaped toward interactive *products* — plotly,
  D3-in-React, a brief Shiny mention — and **deploying a Quarto site to GitHub
  Pages**. The final report becomes a repo that renders on Pages.
- **Assignments:** weekly **Reading Reflections** (read forward + light practice
  + reflect) + **3 Mini Projects** (the higher-stakes individual work, reframed
  around *judgment and verification* — the things an agent can't do for you).
  Quizzes (5) retained. *(A "7 small labs" idea was explored and rejected in
  favor of keeping 3 ambitious mini projects.)*
- **Grade breakdown:** Participation 5 · Reflections 13 · Quizzes 10 · Mini
  Projects 27 (3×9) · Final Project 35 (proposal 6 + progress 6 + report 17 +
  presentation 6) · Final Interview 10 = 100.

## Current state (what's done vs. pending)

- ✅ `schedule.csv` + plumbing rewritten and verified (parses, links build,
  grades sum to 100, `quarto inspect` clean).
- ⏳ **Mini-project page content is still the old hand-coding-era version** —
  `mini/1-data-cleaning.qmd`, `2-exploring-data.qmd`, `3-redesign.qmd` need
  rewriting around judgment/verification. **MP1 (Clean & Verify) is the natural
  first rewrite** (most changed). MP2 = Explore & Interrogate; MP3 = Re-design
  (expand the existing strong task).
- ⏳ **New slide decks not built.** W2 (`class/2-agentic-workflows/`) is the
  first genuinely new deck. Most `class/*.qmd` landing pages show "Coming soon!".
- ⏳ Reading-reflection content (`hw/*.qmd`) not yet updated for the new toolchain.
- ⏳ **RStudio → Positron cleanup, sitewide.** The course used to teach in
  RStudio; it now teaches in Positron. Many pages still tell students to open
  a `.Rproj` file or reference "RStudio" — these are stale. As of July 2026
  this is fixed in `mini/1-data-cleaning.qmd` (done manually by John); still
  outstanding elsewhere, e.g. `mini/2-exploring-data.qmd`,
  `mini/3-redesign.qmd`, `project/*.qmd`, `hw/*-temp.qmd`, `software.qmd`,
  `syllabus.qmd`, `course-primer.qmd`, `faq.qmd`, `references.qmd`,
  `fragments/pep-talk.qmd`, and the assignment template zips/`.Rproj` files
  themselves. Fix incrementally as each file gets revised rather than as one
  sweep, since many of these pages are being rewritten anyway.

## Conventions

- **IDE is Positron, not RStudio.** Don't write or leave instructions telling
  students to open a `.Rproj` file or open/use "RStudio" — direct them to open
  the project folder in Positron instead. See the pending cleanup item above.

- **Data-driven schedule:** edit `schedule.csv`; `_common.R` (`get_schedule()`)
  builds the HTML columns and `schedule.lua` is a Pandoc table filter. Don't
  hand-edit the table in `schedule.qmd`. Tracks/columns: `*_class`, `*_assign`
  (reflections, link to `hw/`), `*_mini` (mini projects, link to `mini/`),
  `*_project` (final project), plus `quiz`.
- **`fragments/`** = reusable snippets included via `child = here::here(...)`.
  `placeholder.qmd` is the "Coming soon!" stub.
- **Class slides** live in `class/N-stub/` and are **excluded from render** in
  `_quarto.yml` until built; the landing page `class/N-stub.qmd` links to them.
- **Course-wide variables** in `_variables.yml` (`{{< var name >}}`).
- **`ROLLOVER.md`** = the separate checklist for rolling the site to a new
  semester.

## Raw material (render-excluded — don't delete)

The prior slide decks live in `class/N-stub/`, excluded from render in
`_quarto.yml` until each week's deck is rebuilt — keep them as raw material.
The pre-agentic orphan files (the old tidy / project-workshop / story-telling
`.qmd` + `-temp` drafts) were reconciled in the July 2026 schedule restructure —
renumbered into the active sequence or deleted.

## Building

```bash
quarto preview   # live preview
quarto render    # build to _site/
```

**Do not render `.qmd` files yourself** — the instructor renders and previews.
`quarto inspect` is fine for validating config without rendering.
