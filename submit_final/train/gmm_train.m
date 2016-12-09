function [gmm_models, gmm_priors, X_full_PCA_coeff, X_full_mean] = gmm_train(X_train, Y_train, X_unlabeled)

options = statset('MaxIter',500);
num_clusters = 100;
num_pc = 200;

X_full = [X_train; X_unlabeled];

X_full_mean = mean(X_full);
X_full_centered = X_full - repmat(X_full_mean, [size(X_full, 1), 1]);
X_train_centered = X_train - repmat(X_full_mean, [size(X_train, 1), 1]);

X_full_PCA_coeff = pca(X_full_centered, 'NumComponents', num_pc);

X_train_score = X_train_centered * X_full_PCA_coeff;

gmm_models = cell(2);

%%

gmm_priors = zeros(2,1);
for l=1:2
    gmm_priors(l,1) = size(Y_train(Y_train==l-1),1);
end
gmm_priors = gmm_priors / sum(gmm_priors);

for l=1:2
    gmm_models{l} = fitgmdist(X_train_score(Y_train==l-1,:),num_clusters, ...
    'CovarianceType','diagonal','RegularizationValue',0.1^5,'Options',options);
end

end
