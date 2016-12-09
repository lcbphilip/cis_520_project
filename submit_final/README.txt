Layout
======
The files in this submission are laid out in the following format:
predict_labels.m - Generates predictions on test set
run_everything.m - Example script that splits data into training and test set, and runs training + testing
train_models.m - Trains models on training set
models/ - Contains .mat files with models
predict/ - Contains prediction scripts
train/ - Contains training scripts
util/ - Contains utility functions

Examples for training and running our models can be found in train_models.m and predict_labels.m respectively.

Models
======
This submission implements the following models, mainly built from matlab in-built functions:
- Support vector machine (SVM)
- Gaussian mixture model (GMM)
  - Used PCA as semi-supervised dimensionality reduction for this
- K-nearest neighbors (KNN)
- Random forest
- Boosted ensemble

Note: We did not find any improvement from using the image or color data, so it did not feature in our models.

SVM (predict/svm_predict.m and train/svm_train.m)
=================================================
We found it best to run our SVM model only on the word counts. We performed a grid search on the KernelScale and BoxConstraint parameters to improve our cross-validation accuracy, which improved our model's performance from ~78% to ~80%.

GMM (predict/gmm_predict.m and train/gmm_train.m)
=================================================
The gmm_train function takes in 3 arguments with the call: gmm_train(X_train, Y_train, X_unlabeled).

It uses both the X_train and X_unlabeled to calculate the mean value of each variable and also the largest 200 principal component loadings.

It then project X_train on the the PC loadings to get X_train_score that is going to be used to train the GMM model.

The GMM model is trained by identifying 100 clusters within each class of Y_train (i.e. 0 and 1), and prior probability of classes are also calculated.

The gmm_predict function takes in only one argument: X_test.

It loads the predictor variable means, the Y prior probabilities, the GMM models, and also the PC loadings from storage. It then checks for each observation of X_test whether the posterior probability is higher under the GMM model for class 0 or under the GMM model for class 1, and assign the label accordingly.

KNN (predict/knn_predict.m and train/knn_train.m)
=================================================
We trained a KNN model using K = 15, with the L-1 norm for distance. We found it best to use presence/absence of word rather than word count data for this model. For compression and prediction speed, we used the k-d tree option to store the model's boundaries.

Random forest (predict/bag_predict.m and train/bag_train.m)
===========================================================
We trained a random forest model on the word count data, augmenting this with a "hashtag count" feature (i.e. counts the number of hashtags in the tweet). We used 100 decision trees, splitting them to leaf size 1, and restricting our choice to between sqrt(4501) features at every split.

Boosted ensemble (predict/ens_predict.m and train/ens_train.m)
==============================================================
We trained a boosted ensemble on the word count data, also augmenting this with a "hashtag count" feature. We used 200 decision stumps, using the "GentleBoost" boosting algorithm for determining ensemble weights.

Best model
==========
The best model we found was to take the SVM, random forest, and boosted ensemble methods, and take a majority vote between these 3 models. This achieved an 82% out-of-sample accuracy (as well as an 80.41% leaderboard test accuracy).
