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

N = size(raw_tweets, 1)

word_counts = full(word_counts);

% Generate hashtag column
hashtags = zeros(N, 1);

for i = 1:N
  words = strsplit(cell2mat(raw_tweets(i)));
  L = size(words, 2);
  for j = 1:L
    word = cell2mat(words(j));
    if word(1) == '#'
      hashtags(i) = hashtags(i) + 1;
    end
  end
end



% Random forest
fprintf('Random forest\n');
bag = load('bag_mixed.mat');
bag = bag.bag;
Yh = str2num(cell2mat(predict(bag, [word_counts hashtags])));
% SVM
fprintf('SVM\n');
svm = load('svm_mixed.mat');
svm = svm.svm;
Yh2 = predict(svm, word_counts);
% GentleBoost ensemble
fprintf('ensemble\n');
ens = load('ens_mixed.mat');
ens = ens.ens;
Yh3 = predict(ens, [word_counts hashtags]);


% Take majority vote
Y_hat = (Yh + Yh2 + Yh3) > 1.5;

end
