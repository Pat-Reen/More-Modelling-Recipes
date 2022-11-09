# create example data ----

eg_data <- as.data.table(readRDS("data.rds"))
eg_mappings <- data.frame(smoker=as.character(unique(eg_data[,smoker])), desc = NA_character_, stringsAsFactors = FALSE)
eg_types <- data.frame(val = 1:10, bool = TRUE, big = LETTERS[1:10],
                       small = letters[1:10],
                       dt = seq(from = Sys.Date(), by = "days", length.out = 10),
                       stringsAsFactors = FALSE)

choice_list <- c(ls()[sapply(ls(), function(x) class(get(x))) == 'data.frame'])
