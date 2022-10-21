here::i_am(
  "code/02_make_figure.R"
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


coeff <- 1

total_trend <- dat %>%
  mutate(date = format_ISO8601(submission_date, precision = "ym"))%>%
  filter(year(submission_date)== 2022)%>%
  select(date, tot_cases, new_case)%>%
  arrange(date) %>%
  group_by(date) %>%
  summarise(total_case = sum(tot_cases),
            new_case = sum(new_case))

temperatureColor <- "#69b3a2"
priceColor <- rgb(0.2, 0.6, 0.9, 1)

figure <- total_trend %>%
  ggplot(aes(x=date))+
  geom_bar(aes(y=total_case/100000), stat="identity", size=.1, 
           fill=temperatureColor, color="black", alpha=.4, group = 1)+
  geom_line( aes(y=new_case/1000), size=1, color=priceColor, group = 2) +
  xlab ("") +
  scale_y_continuous(
    name = "Total cases / 100000",
    sec.axis = sec_axis(~.*coeff, name="New cases / 1000")
  ) +
  theme_ipsum() +
  theme(
    axis.title.y = element_text(color = temperatureColor, size=13),
    axis.title.y.right = element_text(color = priceColor, size=13),
    legend.text=element_text(size=10)
  ) +
  ggtitle("Monthly trends in Number of COVID-19 Cases US in 2022")


saveRDS(
  figure,
  file = here::here("output/figure.rds")
)
