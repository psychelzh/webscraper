library(targets)
future::plan(future.callr::callr)
tar_option_set(packages = "rvest")
list(
  tarchetypes::tar_file_read(
    words,
    "words.txt",
    read = readLines(!!.x)
  ),
  tar_target(
    counts,
    sprintf("http://bcc.blcu.edu.cn/zh/search/0/%s", words) |>
      URLencode() |>
      read_html() |>
      html_node("p+ p") |>
      html_text2() |>
      stringr::str_extract("(?<=共\\s)\\d+(?=\\s个)") |>
      as.integer(),
    pattern = map(words)
  ),
  tar_target(
    file_counts,
    data.frame(word = words, count = counts) |>
      readr::write_excel_csv("results.csv")
  )
)
