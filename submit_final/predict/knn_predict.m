function Y_hat = knn_predict(model, X_test)

Y_hat = predict(model, double(X_test > 0));
