unlabeled = load('train_set_unlabeled/words_train_unlabeled.mat');

X_unlabeled = unlabeled.X;

load train_set/words_train.mat

X_train = X(1:4000,:);
Y_train = Y(1:4000);
X_test = X(4001:end,:);
Y_test = Y(4001:end);

load train_set/raw_tweets_train.mat
tweets_train = raw_tweets_train{2}(1:4000);
tweets_test = raw_tweets_train{2}(4001:end);

train_models(X_train, Y_train, tweets_train, X_unlabeled);

% We don't use cnn, prob, color, or raw_img, so we're just going to leave them empty for now
predict_labels(X_test, [], [], [], [], tweets_test);
