function Y_hat = bag_predict(model, X_test, tweets_test)

addpath util

hashtags = count_hashtags(tweets_test);

Y_hat = str2num(cell2mat(predict(model, full([X_test hashtags]))));
