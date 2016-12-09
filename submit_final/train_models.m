function train_models(X_train, Y_train, tweets_train, X_unlabeled)
addpath ./train/

pca = pca_train(X_train);
save('models/pca.mat', 'pca');

gmm = gmm_train(X_train, Y_train);
save('models/gmm.mat', 'gmm');

svm = svm_train(X_train, Y_train);
save('models/svm.mat', 'svm');

knn = knn_train(X_train, Y_train);
save('models/knn.mat', 'knn');
