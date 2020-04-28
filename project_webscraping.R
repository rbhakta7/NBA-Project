#BRING IN LIBRARIES
library(rvest)
library(plyr)
library(dplyr)

trim <- function( x ) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

team_sas<-c("SAS")
team_dal<-c("DAL")
team_hou<-c("HOU")

all_seasons<-data.frame()

for(i in 1:length(team_sas)){
  sas_website<-paste0("http://www.basketball-reference.com/teams/",team_sas[i],"/") 
  sas_html<-read_html(sas_website) 
  sas_get_table<-html_nodes(sas_html,"#SAS") 
  sas_table_team<-html_table(sas_get_table) 
  sas_seasons<-data.frame(sas_table_team) 
  sas_seasons$Team<-"San Antonio Spurs"
}

for(i in 1:length(team_dal)){
  dal_website<-paste0("http://www.basketball-reference.com/teams/",team_dal[i],"/") 
  dal_html<- read_html(dal_website)  
  dal_get_table<-html_nodes(dal_html,"#DAL") 
  dal_table_team<-html_table(dal_get_table) 
  dal_seasons<-data.frame(dal_table_team) 
  dal_seasons$Team<-"Dallas Mavericks"
}

for(i in 1:length(team_hou)){
  hou_website<-paste0("http://www.basketball-reference.com/teams/",team_hou[i],"/") 
  hou_html<- read_html(hou_website)  
  hou_get_table<-html_nodes(hou_html,"#HOU") 
  hou_table_team<-html_table(hou_get_table) 
  hou_seasons<-data.frame(hou_table_team) 
  hou_seasons$Team<-"Houston Rockets"
}

all_seasons<-rbind(all_seasons, sas_seasons, dal_seasons, hou_seasons)

all_seasons<-subset(all_seasons, Season <= "2018-19")
all_seasons<-subset(all_seasons, Season >= "1999-20")

all_seasons<-subset(all_seasons, select=-Var.9)
all_seasons<-subset(all_seasons, select=-Var.16)
all_seasons<-subset(all_seasons, select=-Lg)
all_seasons<-subset(all_seasons, select=-Coaches)
all_seasons<-subset(all_seasons, select=-Top.WS)
all_seasons<-subset(all_seasons, select=-SRS)
all_seasons<-subset(all_seasons, select=-Rel.Pace)
all_seasons<-subset(all_seasons, select=-Rel.ORtg)
all_seasons<-subset(all_seasons, select=-Rel.DRtg)
all_seasons<-subset(all_seasons, select=-Finish)

#EXPORTING DATASET INTO CSV FILE
write.csv(all_seasons, file="C:/Users/Rima/Documents/teams_data.csv")
