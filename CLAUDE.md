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
- ✅ **RStudio → Positron cleanup, sitewide** (August 2026). Every page that
  *instructed* students to use RStudio or open a `.Rproj` now says to open the
  folder in Positron: `faq.qmd`, `course-primer.qmd`, all 10 `hw/*-temp.qmd`,
  `project/{1-proposal,2-initial-report,3-final-report}.qmd`, plus
  `mini/1-data-cleaning.qmd` (done earlier by John). `software.qmd` and
  `syllabus.qmd` already named Positron and mention RStudio deliberately
  ("we will not be using RStudio") — leave them.
  - **Remaining RStudio strings are deliberate and must NOT be swapped:**
    external URLs and org names (`shiny.rstudio.com`, `rstudio.github.io/DT`,
    `rstudio-education.github.io`), image filenames
    (`images/rstudio-cheatsheet-*.png`), the RStudio cheatsheet listings in
    `references.qmd`, and "RStudio Package Manager" in
    `.github/workflows/main.yml`. Renaming any of these breaks links or images.
  - ⏳ Still stale: `templates/project-template.zip` ships a `report.Rproj`
    that nothing references anymore (plus `__MACOSX/` junk and a 1.3 MB stale
    `report.html`). Rebuild the zip when that assignment next gets revised.

## Conventions

- **IDE is Positron, not RStudio.** Don't write or leave instructions telling
  students to open a `.Rproj` file or open/use "RStudio" — direct them to open
  the project folder in Positron instead. See the pending cleanup item above.

- **Class practice files ship as a per-class zip.** Each `class/N-stub/` folder
  holds that week's practice files; `class/render.R` zips them into
  `class/N-stub/N-stub.zip`, and the class landing page offers it as a download.
  Students grab the zip for each class — no repo to clone, nothing to keep in
  sync. *(A shared `eda-f26/class-practice` clone-once repo was tried mid-2026
  and reverted in August 2026 back to per-class zips.)*
  - **The zip's file list lives in `render.R`, keyed by folder name, not week
    number** — `practice_base` (`data/`, `practice.qmd`,
    `practice-solutions.qmd`) plus a `practice_extras` entry for the few weeks
    with one-off scripts. Keying by name means renumbering the schedule can't
    silently hand out the wrong week's files. Listed files that don't exist are
    dropped, so a lecture-only week (14, 15) produces no zip and
    `fragments/class.qmd` hides the download button.
  - **Re-run `class/render.R` from inside a deck folder** after touching that
    week's practice files. It derives `lesson` from the working directory, so
    there is nothing to edit per class — set the folder, run the whole script.
  - **The folder's `.Rproj` stays out of the zip** — see the path convention
    below.

- **File paths: `here::here()` for the site, `file.path()` everywhere else.**
  Three zones, and they don't behave the same:
  - **The site itself** (`fragments/`, `_common.R`, the `child = here::here(...)`
    includes) — **keep `here()`.** These files live inside the site's Quarto
    project, so `here()` walks up to the repo root's `_quarto.yml`, which is the
    correct root. This is the case `here` is good at, and it lets fragments reach
    parent folders without counting `../`.
  - **Slide decks (`class/N-stub/`)** — **use `file.path()`, paths relative to
    the deck folder.** Deck folders are *nested inside* the project `here()`
    locks onto, so it roots at the repo, never the deck; the `.Rproj` files
    existed only to override that. knitr sets the working directory to the
    `.qmd`'s own folder on render, so relative paths resolve correctly no matter
    what's open in Positron. As each deck converts, delete its `.Rproj`.
  - **Student practice files** — **use `file.path()`, relative to the folder.**
    Once unzipped these sit anywhere on a student's disk, so whether `here()`
    resolves depends on what happens to be above them. A `.here` marker would
    work but is one more unexplained file in the folder.
  - `file.path('data', 'x.csv')` over `'data/x.csv'` is deliberate — it's the
    habit being taught, and it survives being shared across Mac and Windows.
  - **`class/render.R` uses `basename(getwd())`, not `here::here()`**, to derive
    `lesson` — with the deck `.Rproj` files gone, `here()` there returns the repo
    root and every output would be named `2026-Fall`.
  - **Fully converted as of August 2026** — all 14 decks (`index.qmd`, plus
    `plots.R` / `figs.R` / `setup.R` and the legacy xaringan `index.Rmd`
    sources), every `practice.qmd` / `practice-solutions.qmd`, and all 13 deck
    `.Rproj` files deleted. New decks should never need one.
  - Two exceptions worth remembering: `13-interactivity/apps/*.R` use
    `file.path('..', 'data', ...)` because Shiny sets the working directory to
    the app's own folder; and `class/_summary-styles.qmd` contains Typst
    `raw.where(` / `heading.where(` — never regex `here(` without a
    non-word-character lookbehind or you'll corrupt those.

- **Class landing pages are all built from `fragments/class.qmd`** — one child
  fragment feeds every `class/N-*.qmd`, so edit it, not the individual pages. It
  derives three per-class paths from `params$class`: slides (`index.html`), the
  slide PDF (`<class>.pdf`), and the summary PDF (`<class>-summary.pdf`, built by
  `class/render.R` from `summary.qmd`).

- **Data-driven schedule:** edit `schedule.csv`; `_common.R` (`get_schedule()`)
  builds the HTML columns and `schedule.lua` is a Pandoc table filter. Don't
  hand-edit the table in `schedule.qmd`. Tracks/columns: `*_class`, `*_assign`
  (reflections, link to `hw/`), `*_mini` (mini projects, link to `mini/`),
  `*_project` (final project), plus `quiz`.
- **`fragments/`** = reusable snippets included via `child = here::here(...)`.
  `placeholder.qmd` is the "Coming soon!" stub.
- **Class slides** live in `class/N-stub/` and are **excluded from render** in
  `_quarto.yml` until built; the landing page `class/N-stub.qmd` links to them.
- **Slide-deck Quarto extensions have ONE source of truth:**
  `class/_extensions/` (lexis + fontawesome). Each deck folder needs an
  `_extensions` entry of its own because the deck folders are render-excluded:
  Quarto treats an excluded file as standalone and only looks for
  `_extensions` in the file's own directory (no upward search), while a
  NON-excluded file would find a shared copy but render into `_site/` instead
  of in situ. So **every `class/N-*/_extensions` is a symlink to
  `../_extensions`** (committed to git as a symlink) — edit/update
  `class/_extensions/` and every deck picks it up with no copying step. New
  deck folders need the link created: `ln -s ../_extensions _extensions`.
- **Sizing in slide decks: `.fontNN` only — `.codeNN` no longer exists.** As
  of July 2026 the lexis theme has a single sizing system: wrap anything —
  paragraphs, lists, or code chunks — in `::: {.fontNN}` (5% steps,
  `font10`–`font200`, NN% of the slide's base size; a wrapped chunk and its
  printed output scale together). The old xaringan-era `.codeNN` classes were
  removed, so **when porting remaining xaringan decks to `.qmd`, convert any
  `.codeNN` to `.fontNN`** and re-tune the number by eye — the old classes
  sized source and output inconsistently, so there is no exact mapping.
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
