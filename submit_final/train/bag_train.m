function model = bag_train(X_train, Y_train, tweets_train)
addpath util

hashtags = count_hashtags(tweets_train);

model = TreeBagger(100, full([X_train hashtags]), full(Y_train));
