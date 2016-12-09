function train_models(X_train, Y_train, tweets_train, X_unlabeled)
addpath ./train/

pca = pca_train([X_train; X_unlabeled]);
save('models/pca.mat', 'pca');

[gmm, gmm_priors] = gmm_train(X_train, Y_train);
save('models/gmm.mat', 'gmm');
save('models/gmm_priors.mat', 'gmm_priors');

svm = svm_train(X_train, Y_train);
save('models/svm.mat', 'svm');

knn = knn_train(X_train, Y_train);
save('models/knn.mat', 'knn');

ens = ens_train(X_train, Y_train, tweets_train);
save('models/ens.mat', 'ens');

bag = bag_train(X_train, Y_train, tweets_train);
save('models/bag.mat', 'bag');
