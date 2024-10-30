# Case Study: Information Technology Usage in Ecuadorian Companies (2015)

This case study examines data from Ecuador's National Institute of Statistics and Censuses (INEC) for the year 2015, focusing on how information technology investment impacts training and internet access among employees. This analysis is conducted with the aim to answer: **"How does gender correlate with technology training and internet access in the workplace?"** 

## Introduction

In recent years, the role of information technology (IT) in workplaces has gained prominence, often reflecting broader economic and social development trends. This study specifically addresses gender disparities in IT training and internet access within Ecuadorian companies, investigating how investment in technology correlates with these factors. We aim to understand whether differences exist between male and female employees in terms of access to training and internet.

## Methodology

1. **Data Loading and Preprocessing**:
    - We begin by loading the dataset, filtering out irrelevant columns, and handling any missing data by substituting `NA` values with `0`.

    ```r
    # Load data and replace missing values
    data <- read.csv("C:\\Users\\pedro\\OneDrive\\Escritorio\\Intro to Stats in R\\2015_TICEMPRESAS_BDD.csv", 
                     fileEncoding = "latin1", header = TRUE)
    data[is.na(data)] <- 0
    ```

2. **Selection of Relevant Variables**:
    - From the dataset, we isolate key variables: investment (`tic1_inversion`, `tic2_valor_inversion`), IT training by gender (`tic41_personal_comp_m`, `tic42_personal_comp_h`), and internet access by gender (`tic61_personal_int_m`, `tic62_personal_int_h`). 

3. **Aggregation**:
    - To compare gender differences, we aggregate total counts for each gender in both IT training and internet access.

    ```r
    # Aggregate totals for computer training and internet access by gender
    total_trained_women <- sum(data_filtrada$tic41_personal_comp_m, na.rm = TRUE)
    total_trained_men <- sum(data_filtrada$tic42_personal_comp_h, na.rm = TRUE)
    
    total_internet_access_women <- sum(data_filtrada$tic61_personal_int_m, na.rm = TRUE)
    total_internet_access_men <- sum(data_filtrada$tic62_personal_int_h, na.rm = TRUE)
    ```

4. **Data Visualization**:
    - Using `ggplot2`, we create bar charts to visualize the comparison between men and women in terms of IT training and internet access.

    ```r
    # Prepare data summary for visualization
    data_summary <- data.frame(
      Category = c("Computer Training", "Computer Training", "Internet Access", "Internet Access"),
      Gender = c("Women", "Men", "Women", "Men"),
      Total = c(total_trained_women, total_trained_men, total_internet_access_women, total_internet_access_men)
    )

    # Plot gender comparison in IT training and internet access
    ggplot(data_summary, aes(x = Category, y = Total, fill = Gender)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Comparison of Men and Women in IT Training and Internet Access",
           x = "Category", y = "Total") +
      scale_fill_manual(name = "Gender", values = c("Women" = "pink", "Men" = "blue"))
    ```
With this results, we can conseider in the insdruy of TCIs and the inversion in technologies could be a clear signal of inequality in the sector of IT. 
**Regression Model**:
    - To understand the influence of investment on IT training and internet access, we fit a linear regression model with `inversion_total` as the independent variable, and gender-based variables for IT training and internet access as dependent variables.

    ```
    # Linear regression model for IT training
    model_training <- lm((tic41_personal_comp_m + tic42_personal_comp_h) ~ inversion_total, data = data_filtrada)
    
    # Linear regression model for Internet access
    model_internet <- lm((tic61_personal_int_m + tic62_personal_int_h) ~ inversion_total, data = data_filtrada)
    
    # Model summaries
    summary(model_training)
    summary(model_internet)
    
    ```
 The models evaluate the degree to which investment influences IT training and internet access across genders, allowing us to quantify the effect of increased IT investment.
## Results

The findings from the bar chart reveal clear patterns:
- **IT Training**: A disparity exists between male and female employees in access to IT training, with one gender (specify from your results) showing higher representation.
- **Internet Access**: Similarly, differences appear in internet access, potentially indicating gender-related limitations or priorities in IT accessibility within companies.

![image](https://github.com/user-attachments/assets/a88593ea-bd4b-4db2-809d-3166a9e54e53)


## Model Interpretation

- **Intercept (155.814)**: This value suggests that, in the absence of any investment, the baseline number of employees trained would be approximately 156. This intercept establishes the starting point for the relationship but does not imply causation on its own.

- **Coefficient for IT Investment (-69.259)**: The negative coefficient indicates an inverse relationship between IT investment and the number of trained employees. Specifically, for every unit increase in `inversion_total`, the model predicts approximately 69 fewer trained employees. This result may be counterintuitive and could be influenced by unobserved factors, such as how investment is allocated or disparities in training access based on organizational priorities.

- **Significance (p-value: 2.36e-13)**: The p-value for the coefficient on `inversion_total` is highly significant (p < 0.001), indicating strong statistical evidence supporting the observed negative relationship between investment and training levels.

### Residuals and Model Fit

- **Residual Range**: The residuals show a range of values, with some large outliers (min = -86.6, max = 6647.4). This suggests that while the model captures a general trend, there are substantial variations not explained by this linear relationship.

- **R-squared (0.01642)**: With an R-squared of 0.016, this model explains only about 1.6% of the variability in the number of trained employees based on investment alone, indicating that other factors not included in the model likely play a more significant role in determining training rates.

## Conclusions

The analysis reveals a statistically significant yet weak and negative correlation between IT investment and the number of employees trained in computer skills. The low R-squared value suggests that investment levels do not strongly explain training numbers, and additional variables (e.g., industry type, company size, or specific training initiatives) may be needed for a more comprehensive model.

The inverse relationship may indicate that IT investment is not directly associated with workforce training. Instead, it could reflect that investments are directed toward other technological advancements, potentially at the expense of training. Further investigation could benefit from analyzing specific uses of the investment to better understand how resources are allocated between infrastructure, technology adoption, and employee development.
## Conclusion

The results suggest that investment in IT infrastructure alone may not fully bridge gender gaps in technology access and training. Companies should consider inclusive training policies to ensure equitable access to technological resources, thereby fostering a more balanced, efficient, and innovative workforce.

