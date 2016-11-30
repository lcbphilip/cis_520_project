function err = tree_bag_err(bag, X, Y)

[N K] = size(X);
pred = zeros(N, bag.num_trees);
cumpred = zeros(N, 1);
err = zeros(bag.num_trees, 1);
for i = 1:bag.num_trees
  pred(:,i) = arrayfun(@(j) dt_value(bag.trees{i}, X(j,:)), 1:N);
  fprintf('Tree: %d\n', i);
  cumpred = mean(pred(:, 1:i), 2) > 0.5;
  err(i) = mean(cumpred ~= Y);
end
