function [Y_hat] = predict_labels(word_counts, cnn_feat, prob_feat, color_feat, raw_imgs, raw_tweets)
% Inputs:   word_counts     nx10000 word counts features
%           cnn_feat        nx4096 Penultimate layer of Convolutional
%                               Neural Network features
%           prob_feat       nx1365 Probabilities on 1000 objects and 365
%                               scene categories
%           color_feat      nx33 Color spectra of the images (33 dim)
%           raw_imgs        nx30000 raw images pixels
%           raw_tweets      nx1 cells containing all the raw tweets in text
% Outputs:  Y_hat           nx1 predicted labels (1 for joy, 0 for sad)

N = size(raw_tweets, 1);

word_counts = full(word_counts);

load('words_train.mat');
X = full(X);
Y = full(Y);
load('train_cnn_feat.mat');
load('train_color.mat');
load('train_img_prob.mat');

% load or train the SVM classifiers on the 4 datasets
words_train_SVM_Mdl_linear = load('words_train_SVM_Mdl_linear.mat');
words_train_SVM_Mdl_linear = words_train_SVM_Mdl_linear.words_train_SVM_Mdl_linear;

train_cnn_feat_SVM_Mdl_linear = fitcsvm(train_cnn_feat, Y, 'BoxConstraint', 0.72925, 'KernelScale', 69.85); 

train_img_prob_SVM_Mdl_linear = fitcsvm(train_img_prob, Y, 'BoxConstraint', 19.122, 'KernelScale', 1.2198); 

train_color_SVM_Mdl_linear = load('train_color_SVM_Mdl_linear.mat');
train_color_SVM_Mdl_linear = train_color_SVM_Mdl_linear.train_color_SVM_Mdl_linear;

% load or train the Random Forest classifiers on the 4 datasets
RF_Mdl_words_train = load('RF_Mdl_words_train.mat');
RF_Mdl_words_train = RF_Mdl_words_train.RF_Mdl_words_train;

RF_Mdl_train_cnn_feat = TreeBagger(50, train_cnn_feat, Y, 'MinLeafSize', 10);

RF_Mdl_train_img_prob = TreeBagger(100, train_img_prob, Y, 'MinLeafSize', 1);

RF_Mdl_train_color = TreeBagger(200, train_color, Y, 'MinLeafSize', 5);

% Load the RF used to ensemble the predictions from the 8 models above
RF_inter_results = load('RF_inter_results.mat');
RF_inter_results = RF_inter_results.RF_inter_results;

% Predict intermediate results on the test set
SVM_results = [];
SVM_results = [SVM_results, predict(words_train_SVM_Mdl_linear, word_counts)];
SVM_results = [SVM_results, predict(train_cnn_feat_SVM_Mdl_linear, cnn_feat)];
SVM_results = [SVM_results, predict(train_img_prob_SVM_Mdl_linear, prob_feat)];
SVM_results = [SVM_results, predict(train_color_SVM_Mdl_linear, color_feat)];

RF_results = [];
RF_results = [RF_results, str2num(cell2mat(predict(RF_Mdl_words_train, word_counts)))];
RF_results = [RF_results, str2num(cell2mat(predict(RF_Mdl_train_cnn_feat, cnn_feat)))];
RF_results = [RF_results, str2num(cell2mat(predict(RF_Mdl_train_img_prob, prob_feat)))];
RF_results = [RF_results, str2num(cell2mat(predict(RF_Mdl_train_color, color_feat)))];

inter_results = [SVM_results, RF_results];

Y_hat = str2num(cell2mat(predict(RF_inter_results, inter_results)))

end
