# Description

This function is designed to get the data from different county \
Notice that the columns of subject and tags have been modified to more simple columns \
Now you can easily use 'filter&select' to tackle the data

You still need some steps to get the data: 
- Connect BU VPN: vpn.bu.edu
- Run the following code and wait for seconds:
  - source(file='data_clean/mexico_screen_function.R')
  - data<-get_county_data()
  - data %>% view()