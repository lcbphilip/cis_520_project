function model = knn_train(X_train, Y_train)
model = fitcknn(double(X_train > 0), Y_train, 'Distance', 'cityblock', 'NSMethod', 'kdtree', 'NumNeighbors', 15);
