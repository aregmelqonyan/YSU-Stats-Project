```markdown
# Synthetic Mouse Obesity Dataset Analysis

This project generates a synthetic mouse obesity dataset, fits Machine Learning (ML) models to it, and visualizes the performance of these models using ROC Curves. The project is implemented in both R and Python.

## Table of Contents
1. [Installation](#installation)
2. [Usage](#usage)
3. [Description](#description)
    - [Data Generation](#data-generation)
    - [Model Fitting](#model-fitting)
    - [Plotting and Evaluation](#plotting-and-evaluation)
4. [Output](#output)

## Installation

### R
To run the R script, you need to have the following libraries installed:

```R
install.packages("pROC")
install.packages("randomForest")
```

### Python
To run the Python script, you need to have the following libraries installed:

```bash
pip install numpy pandas plotly scikit-learn
```

## Usage

### R Script
1. Save the R script to a file, for example, `mouse_obesity_analysis.R`.
2. Run the script in R or RStudio:

```R
source('mouse_obesity_analysis.R')
```

### Python Script
1. Save the Python script to a file, for example, `mouse_obesity_analysis.py`.
2. Run the script:

```bash
python mouse_obesity_analysis.py
```

## Description

### Data Generation
The dataset consists of 100 samples of mouse weights, generated from a normal distribution with a mean of 172 and a standard deviation of 29. The `obese` label is determined based on a probability derived from the rank of the weight.

### Model Fitting
Two models are fitted to the dataset:
1. **Logistic Regression**: A logistic regression model is fitted to predict obesity based on weight.
2. **Random Forest**: A random forest model is also fitted for the same purpose.

### Plotting and Evaluation
The models are evaluated using ROC curves. The R script plots the ROC curves and confusion matrix, while the Python script uses Plotly for interactive visualizations.

## Output

### R Output
1. **Weight vs Obese Classification Plot**: Displays correct and incorrect predictions along with the logistic regression fit.
2. **Confusion Matrix**: Shows the confusion matrix for logistic regression.
3. **ROC Curves**: Plots ROC curves for both logistic regression and random forest models.

### Python Output
1. **Weight vs Obese Classification Plot**: Interactive plot showing correct and incorrect predictions with logistic fit.
2. **Confusion Matrix**: Interactive confusion matrix for logistic regression.
3. **ROC Curves**: Interactive ROC curves comparing logistic regression and random forest models.
