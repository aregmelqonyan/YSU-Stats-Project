# 1. Generate synthetic mouse obesity dataset
# 2. Fit ML models to the dataset
# 3. Plot ROC Curves for the fitted models

# Load necessary libraries
library(pROC)         # For ROC analysis
library(randomForest) # For random forest (install with install.packages("randomForest"))


set.seed(420)


# Generate weight and obesity datasets
num.samples <- 100
weight <- sort(rnorm(n = num.samples, mean = 172, sd = 29))
obese <- ifelse(runif(n = num.samples) < (rank(weight) / num.samples), yes = 1, no = 0)


# Fit a logistic regression model to the data
glm.fit <- glm(obese ~ weight, family = binomial)


# Generate predicted probabilities and classes
predicted_probabilities <- predict(glm.fit, type = "response")
predicted_classes <- ifelse(predicted_probabilities > 0.5, 1, 0)


# Determine correct and incorrect predictions
correct_predictions <- predicted_classes == obese


# Plot the data points with different colors for correct and incorrect predictions
plot(x = weight, y = obese, xlab = "Weight", ylab = "Obese", main = "Weight vs Obese Classification", pch = 19,
     col = ifelse(correct_predictions, "black", "red"))
lines(weight, predicted_probabilities, col = "blue", lwd = 2)


# Add a legend
legend("topleft", legend = c("Correct Prediction", "Incorrect Prediction", "Logistic Fit"),
       col = c("black", "red", "blue"), pch = c(19, 19, NA), lty = c(NA, NA, 1),
       lwd = c(NA, NA, 2), cex = 0.8)


# Print the confusion matrix
confusion_matrix <- table(Predicted = predicted_classes, Actual = obese)
print(confusion_matrix)


# Plot ROC curve with square aspect ratio
par(pty = "s")
roc(obese, predicted_probabilities, plot = TRUE, main='ROC Curve for Logistic Regression')


# Reset aspect ratio to default
# par(pty = "m")


# Plot ROC curve with legacy axes
roc(obese, predicted_probabilities, plot = TRUE, legacy.axes = TRUE, percent = TRUE, 
    xlab = "False Positive Percentage", ylab = "True Positive Percentage", col = "#377eb8", 
    lwd = 4, print.auc = TRUE, main='ROC Curve for Logistic Regression')


# Calculate ROC information
roc_info <- roc(obese, predicted_probabilities, legacy.axes = TRUE)
roc_df <- data.frame(
  tpp = roc_info$sensitivities * 100,
  fpp = (1 - roc_info$specificities) * 100,
  thresholds = roc_info$thresholds
)

head(roc_df)
tail(roc_df)
roc_df[roc_df$tpp > 60 & roc_df$tpp < 80,]


# Now let's fit the data with a random forest
rf.model <- randomForest(factor(obese) ~ weight)


# ROC for random forest
roc(obese, rf.model$votes[, 1], plot = TRUE, legacy.axes = TRUE, 
    percent = TRUE, xlab = "False Positive Percentage", ylab = "True Positive Percentage", 
    col = "#4daf4a", lwd = 4, print.auc = TRUE,
    main='ROC Curve for Random Forest')


# Now layer logistic regression and random forest ROC graphs..
roc(obese, predicted_probabilities, plot = TRUE, legacy.axes = TRUE, percent = TRUE, 
    xlab = "False Positive Percentage", ylab = "True Positive Percentage", col = "#377eb8", 
    lwd = 4, print.auc = TRUE, main='Logistic Regression vs Random Forest')
plot.roc(obese, rf.model$votes[, 1], percent = TRUE, col = "#4daf4a", lwd = 4, print.auc = TRUE, add = TRUE, print.auc.y = 40)
legend("bottomright", legend = c("Logistic Regression", "Random Forest"), col = c("#377eb8", "#4daf4a"), lwd = 4)

