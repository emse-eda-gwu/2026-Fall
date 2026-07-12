# Semester Rollover Checklist

Manual steps for rolling the course site over to a new semester. The bulk copy
(file copy, year/URL updates, schedule.csv date shift, placeholder class pages,
temp HW versions) is done first; these are the remaining steps that can't be
scripted.

## Bulk copy (do this first)

1. Copy the entire prior year's site repo into the new year's empty repo
   (e.g. `EDA/2026-Fall` -> `EDA/2027-Fall`).
2. Rename `EMSE-EDA-<year>-Fall.Rproj` to the new year.
3. Update `_variables.yml`: `title` (year), `crn`, `semester`, `dates`,
   `slack`, `repo`, `site_url`.
4. Update `schedule.csv`: shift every date forward to the new year's actual
   calendar. Don't just add 365 days -- weekdays shift year to year, so
   check the official GW academic calendar for the real first/last class
   dates and holidays.
5. Reset each `class/N-*.qmd` to a "Coming soon!" placeholder by swapping
   its child include from `fragments/class.qmd` to
   `fragments/placeholder.qmd` -- except no-new-content weeks (workshops,
   interviews), which don't need this. The actual prior slide deck content
   stays untouched in `class/N-stub/` (already excluded from render in
   `_quarto.yml`) as raw material for rebuilding that week's deck.
6. For each `hw/N-*.qmd`: copy the live file to `hw/N-*-temp.qmd` (this
   becomes the working draft -- the prior year's real content, ready to be
   revised), then reset the live `hw/N-*.qmd` itself to a placeholder stub
   (keep the YAML `title`/`params`, replace the body with `Coming soon!`).
   Release each week during the semester by renaming `-temp` over the live
   file once it's been revised (see "Weekly" below).
7. Leave `templates/` zip files as-is for now; revise later if that
   assignment changes (see "Update HW template zip files" below).
8. Leave `mini/*.qmd` and their rubrics/templates as last year's content
   for now -- revising these for the current year's course is separate,
   larger work (see `CLAUDE.md` for the current revision's status), not
   part of the mechanical bulk copy.

## One-time setup (before semester starts)

- [x] Fill in the new CRNs in `_variables.yml` (4572: 55175, 6572: 55734)
- [ ] Create the new Slack workspace (links already point to
      `emse-eda-f26.slack.com` in `_variables.yml`, `_quarto.yml`, and the
      class 1 slides)
- [ ] Create a new Google Calendar booking page and update the signup link in
      `class/4-workshop-proposals.qmd` (the only remaining team-meeting week —
      the end-of-semester `workshop-final-analysis` week was dropped in F26)
- [ ] Update HW template zip files in `templates/` if needed
- [ ] Verify class dates against the official GW academic calendar
      (first class, Thanksgiving break, last class)
- [ ] Render the site locally and click through all pages
- [ ] Make a baseline git commit before editing content

## Weekly (as the semester progresses)

For each class week:

- [ ] Update the week's slides in `class/<week>/index.Rmd`, then re-render
      slides, PDF, and notes zip with `class/render.R` (the copied
      `index.html` / `.pdf` / `.zip` files are still last year's renders)
- [ ] Restore the class page: in `class/<week>.qmd`, swap the
      `fragments/placeholder.qmd` child back to `fragments/class.qmd`
- [ ] Release the HW: replace the "Coming soon!" version with the full
      assignment by renaming `hw/<assignment>-temp.qmd` over
      `hw/<assignment>.qmd` (review content/links before releasing)

## End of semester

- [ ] Confirm final interview dates in `class/interviews.qmd`
- [ ] Update the project showcase with the new semester's examples
