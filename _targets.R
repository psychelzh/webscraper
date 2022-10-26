library(targets)
future::plan(future.callr::callr)
tar_option_set(packages = "rvest")
purrr::walk(fs::dir_ls("R"), source, encoding = "UTF-8")
list(
  tarchetypes::tar_file_read(
    words,
    "words.txt",
    read = readLines(!!.x, encoding = "UTF-8")
  ),
  tar_target(
    counts,
    get_count(words),
    pattern = map(words)
  ),
  tar_target(
    file_counts,
    data.frame(word = words, count = counts) |>
      readr::write_excel_csv("results.csv")
  )
)
