# Run this from inside the deck folder -- everything below keys off `lesson`.
lesson <- basename(getwd())

# Note: each deck's _extensions is a symlink to class/_extensions

# Build the slides
renderthis::to_html("index.qmd", "index.html")
renderthis::to_pdf("index.html", paste0(lesson, ".pdf"))

# Compress the PDF to reduce size
tools::compactPDF(paste0(lesson, ".pdf"), gs_quality = 'ebook')

# Build the 1-2 page class summary
quarto::quarto_render("summary.qmd", output_format = "typst")
file.rename("summary.pdf", paste0(lesson, "-summary.pdf"))

# Zip up the class practice files students download from the class page.

practice_base <- c(
  'data',
  'practice.qmd',
  'practice-solutions.qmd'
)

practice_extras <- list(
  '1-getting-started' = 'quarto_demo.qmd',
  '2-agentic-workflows' = 'my-chart-style',
  '13-interactivity' = c(
    'caseConverter.R',
    'caseConverter_solution.R',
    'internetUsers.R',
    'internetUsers_solution.R',
    'mpg.R',
    'shinyWidgets.R',
    'widgets.R'
  )
)

extras <- if (lesson %in% names(practice_extras)) {
  practice_extras[[lesson]]
} else {
  character(0)
}

practice_files <- c(practice_base, extras)
practice_files <- practice_files[file.exists(practice_files)]

zipfile <- paste0(lesson, ".zip")
unlink(zipfile)

# Lecture-only weeks have nothing to hand out
if (length(practice_files)) {
  zip::zip(zipfile = zipfile, files = practice_files)
}
