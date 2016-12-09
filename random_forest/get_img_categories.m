function [categories] = get_img_categories(prob)

[N K] = size(prob);

categories = zeros(N, K);

for i = 1:N
  [a b] = max(prob(i, :));
  categories(i, b) = 1;
end
