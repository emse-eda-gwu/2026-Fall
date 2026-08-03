lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Note: each deck's _extensions is a symlink to class/_extensions (lexis +
# fontawesome), the single source of truth.

# Build the slides
renderthis::to_html("index.qmd", "index.html")
renderthis::to_pdf("index.html", paste0(lesson, ".pdf"))

# Compress the PDF to reduce size
tools::compactPDF(paste0(lesson, ".pdf"), gs_quality = 'ebook')

# Build the 1-2 page class summary (Quarto -> Typst -> PDF).
# Styling lives in class/_summary-styles.qmd
quarto::quarto_render("summary.qmd", output_format = "typst")
file.rename("summary.pdf", paste0(lesson, "-summary.pdf"))

# Zip the class practice folder up

files1 <- c(
  'data',
  'practice-solutions.qmd',
  'practice.qmd',
  'quarto_demo.qmd'
)
files2 <- c(
  'data',
  'practice-solutions.qmd',
  'practice.qmd'
)
files3 <- files2
files4 <- files2
files5 <- files2
files6 <- files2
files8 <- files2
files9 <- files2
files10 <- files2
files11 <- files2

files13 <- c(
  'caseConverter_solution.R',
  'caseConverter.R',
  'data',
  'internetUsers_solution.R',
  'internetUsers.R',
  'mpg.R',
  'practice-solutions.qmd',
  'practice.qmd',
  'shinyWidgets.R',
  'widgets.R'
)

# Create zip files of class notes
zip::zip(
  zipfile = paste0(lesson, ".zip"),
  files = c(files11, paste0(lesson, ".Rproj"))
)

