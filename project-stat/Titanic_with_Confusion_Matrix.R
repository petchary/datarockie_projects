## DROP NA (missing values)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

## Change Sex into Numeric
titanic_train$Sex <- as.factor(titanic_train$Sex) |>
                      as.numeric(titanic_train$Sex)

## SPLIT DATA
set.seed(23)
n <- nrow(titanic_train)
id <- sample(1:n, size = n*0.7) ## 70% train 30% test
train_data <- titanic_train[id, ]
test_data <- titanic_test[-id, ]

## Train Model
ttn_model <- glm(Survived ~ Pclass + Sex + Age, 
              data = train_data, family = "binomial")
train_data$prob <- predict(ttn_model, type="response")
train_data$pred <- ifelse(train_data$prob >= 0.5, 1, 0)

## Test Model
test_data$Sex <- as.factor(test_data$Sex) |>
                  as.numeric(test_data$Sex)
test_data$prob <- predict(ttn_model, newdata = test_data, type = "response")
test_data$pred <- if_else(test_data$prob >= 0.5, 1, 0)

## Confusion Matrix
conM <- table(train_data$pred, train_data$Survived,
              dnn = c("predicted", "Actual"))

## Accuracy
cat("Acccuracy:", (conM[1,1] + conM[2,2]) / sum(conM) )
cat("Precision:", conM[2,2] / (conM[2,1] + conM[2,2]) )
cat("Recall:", conM[2,2]/ (conM[1,2] + conM[2,2]) )

cat("F1:", 2 * ( (0.7526882 * 0.7035176) / 
                 (0.7526882 + 0.7035176)) )
