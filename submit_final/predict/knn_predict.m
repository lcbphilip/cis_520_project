function Y_hat = knn_predict(X_test)

model = load('models/knn.mat');
model = model.knn;

Y_hat = predict(model, double(X_test > 0));
