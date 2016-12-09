function Y_hat = ens_predict(X_test, tweets_test)

addpath util
model = load('models/ens.mat');
model = model.ens;

hashtags = count_hashtags(tweets_test);

Y_hat = predict(model, full([X_test hashtags]));
