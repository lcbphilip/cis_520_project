function [Y_hat] = predict_labels(word_counts, cnn_feat, prob_feat, color_feat, raw_imgs, raw_tweets)

addpath predict

% gmm_mat = load('models/gmm.mat');
% Y_hat_gmm = gmm_predict(word_counts);

% knn_mat = load('models/knn.mat');
% Y_hat_knn = knn_predict(knn_mat.knn, word_counts);

svm_mat = load('models/svm.mat');
Y_hat_svm = svm_predict(svm_mat.svm, word_counts);

bag_mat = load('models/bag.mat');
Y_hat_bag = bag_predict(bag_mat.bag, word_counts, raw_tweets);

ens_mat = load('models/ens.mat');
Y_hat_ens = ens_predict(ens_mat.ens, word_counts, raw_tweets);

Y_hat = (Y_hat_bag + Y_hat_ens + Y_hat_svm) > 1.5;
