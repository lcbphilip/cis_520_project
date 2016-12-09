function model = ens_train(X_train, Y_train, tweets_train)
addpath util

hashtags = count_hashtags(tweets_train);

model = fitensemble(full([X_train hashtags]), full(Y_train), 'GentleBoost', 200, 'Tree', 'Type', 'classification');
