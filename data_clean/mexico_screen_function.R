#This function is designed to get the data from different mexico county
#Notice that the columns of subject and tags have been modified to more simple columns
#now you can easily use 'filter&select' to tackle the data

# you still need some steps to get the data: connect BU VPN; run the following code; wait for seconds
# source(file='data_clean/mexico_screen_function.R')
# data<-get_county_data()
# data %>% view()

library(tnum)
library(tidyverse)

tnum.authorize('mssp1.bu.edu')
tnum.setSpace('NCNM')

clean_tag<-function(input_tag){
  year<- input_tag %>% str_match_all("year:(\\d{4})") %>% map(`[`,2) %>% unlist %>% as.numeric()
  survey <- input_tag %>% str_match_all("survey:(\\d{4})") %>% map(`[`,2) %>% unlist %>% as.numeric()
  group <- input_tag %>% str_match_all("group:([\\w]+[\\d]+)") %>% map(`[`,2) %>% unlist
  df_return=data.frame(year=year,survey=survey,group=group)
  return(df_return)
}

get_county<-function(input_county){
  output_county<-input_county %>% str_match_all("county:([\\w]+)") %>% map(`[`,2) %>% unlist
  return(output_county)
}

get_county_data<-function(){
  df=tnum.query(query ="new_mexico/county# has *",max=50000) %>% tnum.objectsToDf() 
  #query all data in new_mexico county
  
  df<-df %>% separate(col=subject,
                      into = c("state", "county", "tract", "detail"),
                      sep = "/",
                      fill='warn')  
  df[grepl("tract",df$tract)==FALSE,]<-df %>%filter(grepl("tract",df$tract)==FALSE) %>% mutate(detail=tract,tract=NA) 
  #split the subject
  df$county<-get_county(df$county)
  #eliminate 'county:'
  df <- df %>% bind_cols(clean_tag(df$tags)) %>% relocate(c(year,survey,group),.before=tags) 
  #split tags
  return(df)
}
