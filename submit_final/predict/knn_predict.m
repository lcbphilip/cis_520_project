function Y_hat = knn_predict(X_test)
knn = load('models/knn.mat');
knn = knn.knn;
Y_hat = predict(knn, double(X_test > 0));
