#Venkata Satya Nagendra Sai Krishna Mohan Kocherlakota 10/24/2023 ALY6000: -Project-5
cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) # clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) # clears packages
options(scipen = 100) # disables scientific notion for entire R session

#1
ball_data <- read_csv("ball-dataset.csv")
#2
freq_color <- count(ball_data, color, name = "counts")
freq_color

green <- freq_color %>% filter(color == "green") %>% pull(2)
green

blue <- freq_color %>% filter(color == "blue") %>% pull(2)
blue

yellow <- freq_color %>% filter(color == "yellow") %>% pull(2)
yellow

red <- freq_color %>% filter(color == "red") %>% pull(2)
red
#3
freq_label <- count(ball_data, label, name = "counts")
freq_label
#4
colors_plot <- c("blue" = "blue", "green" = "green", "red" = "red", "yellow" = "yellow")

#Bar Plot of color
bar_plot_color <-  ggplot(freq_color, aes(x = color, y = counts, fill = color)) + 
  geom_bar(stat = "Identity") +
  labs(x = "Color", y = "Count", title = "Color Counts of Balls") + 
  scale_fill_manual(values = colors_plot) +
  theme_clean()
bar_plot_color

#5
#Bar Plot of label
bar_plot_label <-  ggplot(freq_label, aes(x = label, y = counts, fill = label)) + 
  geom_bar(stat = "Identity") +
  labs(x = "Label", y = "Count", title = "Label Counts of Balls") + 
  theme_clean()
bar_plot_label
#6

# sample space for the frequency distribution for color

color_sample_count <- sum(freq_color$counts)
color_sample_count

# sample space for the frequency distribution for labels

label_sample_count <- sum(freq_label$counts)
label_sample_count

# Calculating the number of labels from the freq_lable tibble.

label_a <- freq_label %>% filter(label == "A") %>% pull(2)
label_a

label_b <- freq_label %>% filter(label == "B") %>% pull(2)
label_b

label_c <- freq_label %>% filter(label == "C") %>% pull(2)
label_c

label_d <- freq_label %>% filter(label == "D") %>% pull(2)
label_d

label_e <- freq_label %>% filter(label == "E") %>% pull(2)
label_e

prob6_result <- green/color_sample_count
prob6_result
#7
prob7_result <- (blue + red)/ color_sample_count
prob7_result
#8
prob8_result <- (label_a + label_c)/ label_sample_count
prob8_result
#9
yellow_d_ball <- ball_data %>% subset(color == "yellow" & label == "D")
n_yellow_d_ball <- nrow(yellow_d_ball)
n_total_balls <- nrow(ball_data)

prob9_result <- n_yellow_d_ball / n_total_balls
prob9_result

#10
prob10_result <- (freq_color$counts[freq_color$color == 'yellow'] + freq_label$counts[freq_label$label == 'D'] - nrow(subset(ball_data, label == 'D' & color == 'yellow')))/sum(freq_color$counts)
prob10_result
#11
prob11_result <- ((blue)/n_total_balls)*((red)/(n_total_balls-1))
prob11_result
#12
prob12_result <- ((green)/(n_total_balls))*((green-1)/(n_total_balls-1))*(green-2)/(n_total_balls-2)*((green-3)/(n_total_balls-3))
prob12_result
#13
prob13_result <- ((red)/n_total_balls)*(label_b/(n_total_balls-1))
prob13_result
#14
label_a_count <- freq_label %>% filter(label == "A") %>% pull(counts)
label_c_count <- freq_label %>% filter(label == "C") %>% pull(counts)
label_e_count <- freq_label %>% filter(label == "E") %>% pull(counts)

prob14_result <- label_a_count * label_c_count * label_e_count
prob14_result
#15
# Calculate the number of ways to choose 3 balls that spell "ACE" (order doesn't matter)
prob15_result <- (label_a_count * label_c_count * label_e_count) * 6
prob15_result
#16
# Probability that the three balls that spell "ACE" are all green
green_aec <- choose(sum(ball_data$label == "A" & ball_data$color == "green"), 1) *
  choose(sum(ball_data$label == "C" & ball_data$color == "green"), 1) *
  choose(sum(ball_data$label == "E" & ball_data$color == "green"), 1)

prob16_result <- green_aec / prob14_result
prob16_result
#17
# Function to evaluate the factorials. The 0! = 1 while the negative numbers return 
# -1 as their factorial.

factorial <- function(n){
  if (n==0){
    return(1)
  } else if (n < 0){
    return(-1)
  } else {
    return(n*factorial(n-1))
  }
}
factorial(0)
factorial(3)
factorial(5)
factorial(-10)
#18
coin_outcomes <- data.frame(
  first = rep(c("H", "T"), each = 8),
  second = rep(c("H", "T"), each = 4),
  third = rep(c("H", "T"), each = 2),
  fourth = rep(c("H", "T"), times = 2)
)
coin_outcomes
heads_prob <- 0.6
#19
calculate_probability <- function(row){
  probability <- 1
  for (i in 1:length(row)){
    if (row[i] == "H"){
      probability <- probability * heads_prob
    } else {
      probability <- probability * (1 - heads_prob)
    }
  }
  return(probability)
}

coin_outcomes$probability <- apply(coin_outcomes,1,calculate_probability)
coin_outcomes

num_heads_prob <- c(0.4*4, 0.6*0.4*0.4*0.4, 0.6*0.6*0.4*0.4, 0.6*0.6*0.6*0.4, 0.6*4)
num_heads_prob

prob21_result <- c(0.6**3*0.4*4)
prob21_result

prob22_result <- (0.6^2)*(0.4^2)*6 + (0.6^4)
prob22_result

prob23_result <- 1-(0.6**4)
prob23_result

# The below lines of code are used to plot the probability of number of heads
# for 4 flips.

summary_coins <- coin_outcomes %>%
  group_by(num_heads = rowSums(.=="H")) %>%
  summarise(total_probability = sum(probability))
summary_coins

plot_coins <- ggplot(summary_coins,aes(x = as.factor(num_heads),y=total_probability))+
  geom_bar(stat = "identity", fill = "cyan")+
  labs(x="Number of Heads", y="Probability", title = "Probability Distribution of Heads for 4 flips") +
  theme_clean()
plot_coins

prob25_result <- (0.75^5)*(0.5^5)
prob25_result

prob26_result <- 1 - ((0.25^5)*(0.5^5) + 0.75*(0.25^4)*(0.5^5) + (0.25^5)*(0.5^4)*0.5)
prob26_result

prob27_result <- choose(5,3)*choose(5,2)
prob27_result