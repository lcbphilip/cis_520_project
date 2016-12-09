function test_labels = gmm_predict(GMMmodels, priors, X_test)

test_sample_size = size(X_test, 1);
posteriors = zeros(test_sample_size, 2);

for l=1:2
    posteriors(:,l) = pdf(GMMmodels{l}, X_test) .* priors(l,1);
end
       
[~, test_labels] = max(posteriors, [], 2);
test_labels = test_labels - 1;

end