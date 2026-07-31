lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Refresh this class's copy of the shared Quarto extensions (lexis + fontawesome). The source of truth is class/_extensions/ — edit there, never the per-class copy.
unlink("_extensions", recursive = TRUE)
file.copy("../_extensions", ".", recursive = TRUE)

# Build the slides
renderthis::to_html("index.qmd", "index.html")
renderthis::to_pdf("index.html", paste0(lesson, ".pdf"))

# Compress the PDF to reduce size
tools::compactPDF(paste0(lesson, ".pdf"), gs_quality = 'ebook')

# Build the 1-2 page class summary (Quarto -> Typst -> PDF).
# Styling lives in class/_summary-styles.qmd
quarto::quarto_render("summary.qmd", output_format = "typst")
file.rename("summary.pdf", paste0(lesson, "-summary.pdf"))
