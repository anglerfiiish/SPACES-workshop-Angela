# My first script in this project
library(ggplot2)
library(ratdat)

ggplot(complete_old, aes(x = hindfoot_length, y = weight))+
  geom_point()

# make a comment
ggplot(complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type, shape = sex))+
  geom_point(alpha = 0.2)

#make another plot 
ggplot(complete_old, mapping = aes(x = plot_type, y = hindfoot_length, color = plot_type, shape = sex))+
  geom_violin()
