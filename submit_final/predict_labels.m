function [Y_hat] = predict_labels(word_counts, cnn_feat, prob_feat, color_feat, raw_imgs, raw_tweets)

addpath ./predict/

Y_hat_gmm = gmm_predict(word_counts);
Y_hat_knn = knn_predict(word_counts);
Y_hat_svm = svm_predict(word_counts);

Y_hat = (Y_hat_gmm + Y_hat_knn + Y_hat_svm) > 1.5;
