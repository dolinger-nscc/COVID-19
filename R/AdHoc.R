library(tidyverse)
options(scipen = 999)
library(readxl)
X20Mar <- read_excel("data/COVID-19-2020-03-21.xlsx")
cal <- read_excel("data/Population.xlsx")

cal <- cal %>%
  select(Country, Pop = `2019Population`)

df <- 
X20Mar %>%
  filter(Country %in% c('Canada', 'Italy', 'United_States_of_America', 
                        'United_Kingdom') & Date >= '2020-02-15') %>%
  left_join(cal, by="Country") %>%
  mutate(CasesPer100k = (Cases / Pop) * 100000,  
                        DeathsPer100k = (Deaths / Pop) * 100000) 
                        



#df <- 
#  X20Mar %>%
#  filter(Country %in% c('Canada', 'Italy') & Date >= '2020-02-20')


p1 <- ggplot(data = df, mapping = aes(x = Date, y = CasesPer100k, color = Country)) + 
     geom_point() +
     geom_smooth()

p2 <- ggplot(data = df, mapping = aes(x = Date, y = DeathsPer100k, color = Country)) + 
  geom_point() +
  geom_smooth() 

dfNoItaly <- df %>%
           filter(Country != 'Italy')

p3 <- ggplot(data = dfNoItaly, mapping = aes(x = Date, y = CasesPer100k, color = Country)) + 
  geom_point() +
  geom_smooth()


p4 <- ggplot(data = dfNoItaly, mapping = aes(x = Date, y = DeathsPer100k, color = Country)) + 
  geom_point() +
  geom_smooth()

library(plotly)
ggplotly(p1)
ggplotly(p2)
ggplotly(p3)
ggplotly(p4)







