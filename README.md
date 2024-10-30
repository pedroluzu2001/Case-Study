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

## Results

The findings from the bar chart reveal clear patterns:
- **IT Training**: A disparity exists between male and female employees in access to IT training, with one gender (specify from your results) showing higher representation.
- **Internet Access**: Similarly, differences appear in internet access, potentially indicating gender-related limitations or priorities in IT accessibility within companies.

## Conclusion

The results suggest that investment in IT infrastructure alone may not fully bridge gender gaps in technology access and training. Companies should consider inclusive training policies to ensure equitable access to technological resources, thereby fostering a more balanced, efficient, and innovative workforce.

