function bag = tree_bag_train(X_train, Y_train, X_test, Y_test, num_trees, samples_per_tree, n_features, depth_limit)

bag.trees = {};
[N K] = size(X_train);
bag.train_err = zeros(num_trees, 1);
bag.test_err = zeros(num_trees, 1);
for i = 1:num_trees
  samp = randsample(N, samples_per_tree, true);
  bag.trees{i} = rt_train(X_train(samp, :), Y_train(samp), depth_limit, n_features);
  bag.num_trees = i;
  fprintf('Tree: %d\n', i);
  %fprintf('Tree: %d, train_err: %f, test_err: %f\n', i, bag.train_err(i), bag.test_err(i));
end
