here::i_am(
  "code/01_make_table.R"
)

# load packages
if(!("pacman" %in% installed.packages()[,"Package"])) {
  install.packages("pacman", dependencies = TRUE)
}

library(pacman)

pacman::p_load(
  knitr,
  kableExtra,
  dplyr,
  lubridate,
  ggplot2,
  hrbrthemes
)

# read data
dat <- read.csv(
  file = here::here("data/COVID_2022.csv")
)

# change date format
dat$submission_date <- mdy(dat$submission_date) 

total_trend <- dat %>%
  mutate(date = format_ISO8601(submission_date, precision = "ym"))%>%
  filter(year(submission_date)== 2022)%>%
  select(date, tot_cases, new_case)%>%
  arrange(date) %>%
  group_by(date) %>%
  summarise(total_case = sum(tot_cases),
            new_case = sum(new_case))


table_ga <- dat %>%
  mutate(date = format_ISO8601(submission_date, precision = "ym"))%>%
  filter(year(submission_date)== 2022)%>%
  select(date, tot_cases, new_case, state)%>%
  arrange(date) %>%
  group_by(date) %>%
  filter(state == "GA") %>%
  summarise(ga_total_case = sum(tot_cases),
            ga_new_case = sum(new_case)) %>%
  select(-date)

table_ny <- dat %>%
  mutate(date = format_ISO8601(submission_date, precision = "ym"))%>%
  filter(year(submission_date)== 2022)%>%
  select(date, tot_cases, new_case, state)%>%
  arrange(date) %>%
  group_by(date) %>%
  filter(state == "NY") %>%
  summarise(ga_total_case = sum(tot_cases),
            ga_new_case = sum(new_case))%>%
  select(-date)

table_ca <- dat %>%
  mutate(date = format_ISO8601(submission_date, precision = "ym"))%>%
  filter(year(submission_date)== 2022)%>%
  select(date, tot_cases, new_case, state)%>%
  arrange(date) %>%
  group_by(date) %>%
  filter(state == "CA") %>%
  summarise(ga_total_case = sum(tot_cases),
            ga_new_case = sum(new_case)) %>%
  select(-date)

# combine data
table_all <- cbind(total_trend, table_ga, table_ny, table_ca)

current_data_colnames <- c ("Date","Total cases", "New cases", 
                            "Total cases", "New cases",
                            "Total cases", "New cases",
                            "Total cases", "New cases"
)

table <- kbl(table_all, caption = "Summary of COVID cases in the US, Georgia(GA), New York(NY), and California(CA)",
    col.names = current_data_colnames,
    booktabs = T,
    centering = T,
    align = c("l", "c","c","c","c")) %>%
  row_spec(0, align = "c", bold = TRUE) %>%
  add_header_above(c(" ", "US" = 2, "GA" = 2, "NY" = 2, "CA" = 2), bold = T)%>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  kable_styling(latex_options=c("scale_down"))

table

saveRDS(
  table,
  file = here::here("output/table.rds")
)
