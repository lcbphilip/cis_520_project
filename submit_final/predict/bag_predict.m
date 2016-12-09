function Y_hat = bag_predict(X_test, tweets_test)

addpath util
model = load('models/bag.mat');
model = model.bag;

hashtags = count_hashtags(tweets_test);

Y_hat = str2num(cell2mat(predict(model, full([X_test hashtags]))));
