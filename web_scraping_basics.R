library(Lahman)
library(tidyverse)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)%>% select(playerID)    # take entries 1-10
top %>% as_tibble()
Master %>% as_tibble()
Salaries %>% as_tibble()
AwardsPlayers %>% as_tibble()

awards<-AwardsPlayers %>% 
  filter(yearID == 2016)%>% select(playerID)
intersect(top,awards)
setdiff(awards,top)


# import a webpage into R
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")
tab <- tab[[2]]

tab <- tab %>% html_table
class(tab)

tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)

h <- read_html("http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609")
recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()

guacamole <- list(recipe, prep_time, ingredients)
guacamole

get_recipe <- function(url){
    h <- read_html(url)
    recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
    prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
    ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
    return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
} 

library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
nodes <- html_nodes(h, "table")

tab1<-html_table(nodes[[1]])
tab2<-html_table(nodes[[2]])
tab3<-html_table(nodes[[3]])
tab4<-html_table(nodes[[4]])
tab19<-html_table(nodes[[19]])
tab20<-html_table(nodes[[20]])
tab21<-html_table(nodes[[21]])

nodes[[1]]

tab1%>%as_tibble()
tab2%>%as_tibble()
tab3%>%as_tibble()
tab4%>%as_tibble()
tab19%>%as_tibble()
tab20%>%as_tibble()
tab21%>%as_tibble()

tab_1<-html_table(nodes[[10]])%>%select(X2,X3,X4)%>%slice(2:31,)%>%setNames(c("Team", "Payroll", "Average"))
tab_2<-html_table(nodes[[19]])%>%slice(2:31,)%>%setNames(c("Team", "Payroll", "Average"))
tab_Complete<-full_join(tab_1,tab_2,by='Team')

url2 <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
h2<-read_html(url2)
tab<-html_nodes(h2,"table")
html_table(tab[[5]],fill = TRUE)%>%as_tibble()