function test_labels = gmm_predict(X_test)

gmm_models = load('models/gmm_models.mat');
gmm_models = gmm_models.gmm_models;
gmm_priors = load('models/gmm_priors.mat');
gmm_priors = gmm_priors.gmm_priors;

X_full_mean = load('models/X_full_mean.mat');
X_full_mean = X_full_mean.X_full_mean;
X_full_PCA_coeff = load('models/X_full_PCA_coeff.mat');
X_full_PCA_coeff = X_full_PCA_coeff.X_full_PCA_coeff;

test_sample_size = size(X_test, 1);
posteriors = zeros(test_sample_size, 2);

X_test_centered = X_test - repmat(X_full_mean, [test_sample_size, 1]);
X_test_score = X_test_centered * X_full_PCA_coeff;

for l=1:2
    posteriors(:,l) = pdf(gmm_models{l}, X_test_score) .* gmm_priors(l,1);
end
       
[~, test_labels] = max(posteriors, [], 2);
test_labels = test_labels - 1;

end