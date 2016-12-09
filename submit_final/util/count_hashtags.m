function [hashtags] = count_hashtags(tweets);

N = size(tweets, 1);

hashtags = zeros(N, 1);

for i = 1:N
  words = strsplit(cell2mat(tweets(i)));
  L = size(words, 2);
  for j = 1:L
    word = cell2mat(words(j));
    if word(1) == '#'
      hashtags(i) = hashtags(i) + 1;
    end
  end
end
