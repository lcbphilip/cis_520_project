function Y_hat = ens_predict(model, X_test, tweets_test)

addpath util

hashtags = count_hashtags(tweets_test);

Y_hat = predict(model, full([X_test hashtags]));
