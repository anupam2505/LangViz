library(dplyr)
library(stacksurveyr)
stack_survey
stack_schema

stack_survey %>% count(occupation, sort = TRUE)

salary_by_occupation <- stack_survey %>%
  filter(occupation != "other") %>%
  group_by(occupation) %>%
  summarize(average_salary = mean(salary_midpoint, na.rm = TRUE)) %>%
  arrange(desc(average_salary))

salary_by_occupation
write.csv(salary_by_occupation, "salary_by_occupation.csv")

library(ggplot2)
library(scales)

salary_by_occupation %>%
  mutate(occupation = reorder(occupation, average_salary)) %>%
  ggplot(aes(occupation, average_salary)) +
  geom_bar(stat = "identity") +
  ylab("Average salary (USD)") +
  scale_y_continuous(labels = dollar_format()) +
  coord_flip()


abc = stack_survey %>%
  inner_join(stack_multi("tech_do")) %>%
  group_by(answer) %>%
  summarize_each(funs(mean(., na.rm = TRUE)), age_midpoint, salary_midpoint) 
  
  
  ggplot(aes(age_midpoint, salary_midpoint)) +
  geom_point() +
  geom_text(aes(label = answer), vjust = 1, hjust = 1) +
  xlab("Average age of people using this technology") +
  ylab("Average salary (USD)") 
