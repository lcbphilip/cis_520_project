function [p] = tree_bag_value(bag, x)

ps = zeros(bag.num_trees, 1);
for i = 1:bag.num_trees
  ps(i) = dt_value(bag.trees{i}, x);
end
p = mean(ps);
