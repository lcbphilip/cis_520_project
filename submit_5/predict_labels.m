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

N = size(word_counts, 1)

word_counts = full(word_counts);

% Generate hashtag column
hashtags = zeros(N, 1);
retweets = zeros(N, 1);

for i = 1:N
  words = strsplit(cell2mat(raw_tweets(i)));
  L = size(words, 2);
  for j = 1:L
    word = cell2mat(words(j));
    if word(1) == '#'
      hashtags(i) = hashtags(i) + 1;
    end
    if word(1) == '@'
      retweets(i) = retweets(i) + 1;
    end
  end
end

ens = load('ens.mat');
ens = ens.ens;
Y_hat = predict(ens, [word_counts hashtags retweets]);

end
