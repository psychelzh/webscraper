#' Get counts from web
#'
#' @title
#' @param words
#' @return
#' @author Liang Zhang
#' @export
get_count <- function(words) {
  sprintf("http://bcc.blcu.edu.cn/zh/search/0/%s", words) |>
    URLencode() |>
    read_html() |>
    html_node("p+ p") |>
    html_text2() |>
    stringr::str_extract("(?<=共\\s)\\d+(?=\\s个)") |>
    as.integer()
}
