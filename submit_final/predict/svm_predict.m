function Y_hat = svm_predict(X_test)

model = load('models/svm.mat');
model = model.svm;

Y_hat = predict(model, full(X_test));
