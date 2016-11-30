function [p] = dt_value(t, x)
node = t;
depth = 0;
while ~node.terminal
  depth = depth + 1;
  if x(node.feature) == 0
    path(depth) = 0;
    node = node.left;
  else
    path(depth) = 1;
    node = node.right;
  end
end
path;
p = full(node.value);
