function [gmm_model, priors] = gmm_train(X_train, Y_train)

options = statset('MaxIter',500);
num_clusters = 10;

GMMmodels = cell(2);

%%

for l=1:2
    priors(l,1) = size(Y_train(Y_train==l-1),1);
end
priors = priors / sum(priors);

for l=1:2
    GMMmodels{l} = fitgmdist(X_train(Y_train==l-1,:),num_clusters, ...
    'CovarianceType','diagonal','RegularizationValue',0.1^5,'Options',options);
end

gmm_model = GMMmodels;

end
