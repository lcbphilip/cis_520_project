function [H] = binary_entropy(p)
p_times_logp = @(x) min(0, x.*log2(x));
H = - (p_times_logp(p) + p_times_logp(1-p));
