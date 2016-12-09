function model = svm_train(X_train, Y_train)
model = fitcsvm(full(X_train), Y_train, 'BoxConstraint', 300, 'KernelScale', 50);
