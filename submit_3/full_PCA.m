%% load data
clear all;

cd('/Users/ThinkTank/OneDrive/ML/CIS_520/hw/project/final_project_kit');


%% load and rename unlabelled data


load('train_set_unlabeled/train_unlabeled_cnn_feat.mat');
load('train_set_unlabeled/train_unlabeled_img_prob.mat');
load('train_set_unlabeled/words_train_unlabeled.mat');
X_unlabeled = full(X);
load('train_set_unlabeled/train_unlabeled_color.mat');

%% load and un-sparse labelled data

load('train_set/train_cnn_feat.mat');
load('train_set/train_img_prob.mat');
load('train_set/words_train.mat');
X = full(X);
Y = full(Y);
load('train_set/train_color.mat');

%% PCA on labeled and unlabeled data (concat 4 different sets of variables)
% Part 1: PCA

X_big = [X; X_unlabeled];
train_color_big = [train_color; train_unlabeled_color];
train_cnn_feat_big = [train_cnn_feat; train_unlabeled_cnn_feat];
train_img_prob_big = [train_img_prob; train_unlabeled_img_prob];

%%
num_obs = size(X_big,1);

X_big_mean = mean(X_big);
X_big_sd = mean(std(X_big));
X_big_normalized = (X_big - repmat(X_big_mean, [num_obs, 1])) / X_big_sd;

train_color_big_mean = mean(train_color_big);
train_color_big_sd = mean(std(train_color_big));
train_color_big_normalized = (train_color_big - repmat(train_color_big_mean, [num_obs, 1])) / train_color_big_sd;

train_cnn_feat_big_mean = mean(train_cnn_feat_big);
train_cnn_feat_big_sd = mean(std(train_cnn_feat_big));
train_cnn_feat_big_normalized = (train_cnn_feat_big - repmat(train_cnn_feat_big_mean, [num_obs, 1])) / train_cnn_feat_big_sd;

train_img_prob_big_mean = mean(train_img_prob_big);
train_img_prob_big_sd = mean(std(train_img_prob_big));
train_img_prob_big_normalized = (train_img_prob_big - repmat(train_img_prob_big_mean, [num_obs, 1])) / train_img_prob_big_sd;

%%
cat_X_big = [X_big_normalized, train_color_big_normalized, ...
    train_cnn_feat_big_normalized, train_img_prob_big_normalized];

[cat_X_big_coeff, cat_X_big_score] = pca(cat_X_big, 'NumComponents', 5000);

%% Trian the SVM model parameters using CV


X_normalized = (X - X_big_mean) / X_big_sd;
train_color_normalized = (train_color - train_color_big_mean) / train_color_big_sd;
train_cnn_feat_normalized = (train_cnn_feat - train_cnn_feat_big_mean) / train_cnn_feat_big_sd;
train_img_prob_normalized = (train_img_prob - train_img_prob_big_mean) / train_img_prob_big_sd;

cat_X = [X_normalized, train_color_normalized, ...
    train_cnn_feat_normalized, train_img_prob_normalized];

cat_X_score = cat_X * cat_X_big_coeff;

%%
SVM_Mdl_cat_X_score_auto = fitcsvm(cat_X_score, Y, 'OptimizeHyperparameters', 'auto');
