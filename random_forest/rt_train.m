function root = rt_train(X, Y, depth_limit, n_features)
assert(isequal(unique(Y), [0; 1]), 'Y must be ''s and 0''s.');

for i = 1:size(X, 2)
  Xrange{i} = unique(X(:,i));
end
root = split_node(X, Y, Xrange, n_features, 0, depth_limit);

function [node] = split_node(X, Y, Xrange, n_features, depth, depth_limit)
if depth == depth_limit || all(Y == 0) || all(Y == 1) || numel(Y) <= 1
  node.terminal = true;
  if numel(Y) == 0
    node.value = 0; 
  else
    node.value = mean(Y);
  end
  node.left = [];
  node.right = [];
  node.count = size(Y, 1);
  return;
end

node.terminal = false;
[N K] = size(X);

node.H = binary_entropy(mean(Y));

ig = zeros(n_features, 1);
feat_samp = randsample(K, n_features);

for j = 1:n_features
  i = feat_samp(j);
  if numel(Xrange{i}) == 1
    ig(i) = 0;
    split_vals(i) = 0;
    continue;
  end

  r = linspace(double(Xrange{i}(1)), double(Xrange{i}(end)), min(10, numel(Xrange{i})));
  split_f = bsxfun(@le, X(:,i), r(1:end-1));
  
  % Compute conditional entropy of all possible splits.
  px = mean(split_f);
  y_given_x = bsxfun(@and, Y, split_f);
  y_given_notx = bsxfun(@and, Y, ~split_f);
  cond_H = px.*binary_entropy(sum(y_given_x)./sum(split_f)) + ...
    (1-px).*binary_entropy(sum(y_given_notx)./sum(~split_f));
  
  % Choose split with best IG, and record the value split on.
  [ig(i) best_split] = max(node.H-cond_H);
  split_vals(i) = r(best_split);
end

[max_ig node.feature] = max(ig);
node.split_val = split_vals(node.feature);

leftidx = find(X(:, node.feature) <= node.split_val);
rightidx = find(X(:, node.feature) > node.split_val);
node.left = split_node(X(leftidx, :), Y(leftidx), Xrange, n_features, depth + 1, depth_limit);
node.right = split_node(X(rightidx, :), Y(rightidx), Xrange, n_features, depth + 1, depth_limit);
node.count = size(Y, 1);
