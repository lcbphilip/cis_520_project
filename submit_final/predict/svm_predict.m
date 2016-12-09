function Y_hat = svm_predict(model, X_test)
Y_hat = predict(model, full(X_test));
