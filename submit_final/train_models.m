function train_models(X_train, Y_train, tweets_train, X_unlabeled)
addpath ./train/

[gmm_models, gmm_priors, X_full_PCA_coeff, X_full_mean]  = gmm_train(X_train, Y_train, X_unlabeled);

X_full_PCA_coeff = single(X_full_PCA_coeff);
save('models/gmm_models.mat', 'gmm_models');
save('models/gmm_priors.mat', 'gmm_priors');
save('models/X_full_PCA_coeff.mat', 'X_full_PCA_coeff');
save('models/X_full_mean.mat', 'X_full_mean');

svm = svm_train(X_train, Y_train);
save('models/svm.mat', 'svm');

knn = knn_train(X_train, Y_train);
save('models/knn.mat', 'knn');

ens = ens_train(X_train, Y_train, tweets_train);
save('models/ens.mat', 'ens');

bag = bag_train(X_train, Y_train, tweets_train);
save('models/bag.mat', 'bag');
