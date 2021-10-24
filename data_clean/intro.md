# Description

This function is designed to get the data from different mexico county \
Notice that the columns of subject and tags have been modified to more simple columns \
now you can easily use 'filter&select' to tackle the data \

you still need some steps to get the data: connect BU VPN; run the following code; wait for seconds \
- source(file='data_clean/mexico_screen_function.R')
- data<-get_county_data()
- data %>% view()