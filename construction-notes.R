# Processing notes

library(rvest)

deb <- read_html("abortion-debate-hansard.html")

mes <- html_nodes(deb, "div[class='hentry member_contribution']")
speakers <- html_attr(html_node(mes, "cite a"), "title")

voting <- list("abs"=c("Mr William Deedes", "Dr Horace King", "Sir John Hobson"),
               "no"=c("Mr Kevin McNamara", "Mr Norman St John-Stevas",
                      "Mr Peter Mahon", "Mr William Wells", "Mrs Jill Knight"))
# rest voted yes

# by speaker turn
turns <- html_text(mes)
turn_data <- data.frame(speaker=speakers, text=turns,
                        stringsAsFactors=FALSE)
turn_data$vote <- ifelse(turn_data$speaker %in% voting$abs, "abs",
                         ifelse(turn_data$speaker %in% voting$no, "no", "yes"))


# by paragraph
paras <- list()
make_block <- function(m){
  data.frame(speaker = html_attr(html_node(m, "cite a"), "title"),
             text = html_text(html_nodes(m, "p")),
             stringsAsFactors = FALSE)
}
para_data <- do.call(rbind, lapply(mes, make_block))
para_data$vote <- ifelse(para_data$speaker %in% voting$abs, "abs",
                         ifelse(para_data$speaker %in% voting$no, "no", "yes"))

# by speaker
by_speaker <- split(turn_data$text, turn_data$speaker)
speaker_contribs <- unlist(lapply(by_speaker, paste, collapse="\n"))
speaker_data <- data.frame(speaker=names(by_speaker),
                           text=speaker_contribs,
                           stringsAsFactors=FALSE)
speaker_data$vote <- ifelse(speaker_data$speaker %in% voting$abs, "abs",
                            ifelse(speaker_data$speaker %in% voting$no, "no", "yes"))

corpus_bara_speaker <- corpus(speaker_data)
corpus_bara_para <- corpus(para_data)
corpus_bara_turn <- corpus(turn_data)


