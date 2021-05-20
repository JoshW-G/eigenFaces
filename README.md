# eigenFaces
MATLAB code for facial recognition using PCA/eigenfaces technique

pca_dimred is a function for inputing a dataset matrix, computing the zero mean, the covariance and returns the Eigenvectors (W) and the eigenvalues (D) sorted. 

eigenfaces is code to help you understand concepts behind eigenfaces and PCA, such as variation, reconstructing the images etc.

eigenface_recognition is the MATLAB code to perform facial recognition using eigenfaces via PCA. 
1) Process the data from the mat data set, vecotrise each image into a 3000by1 column vector in the images matrix. forming a 3000by86 matrix with this dataset
2) Perform PCA on the dataset using pca_dimred to get the eigenvectors and sorted in descending order of variation eigenvalues.
3) caluculate the minimum eigenvalues that represent 95% variation and use that number of of egienvectors to represent the dataset. (turning a 3000by3000 eigenvectors (w) to a 3000by40 matrix)
4) Caluclate the weights of the images of the dataset, W transpose * X (the images - mean images)
5) Process input image into a column vector of 3000by 1 and calcualte the weights for the input image
6) caluclate the euclidean distance between the two sets of weights and sort by the closest.
7) The index of the shortest distance is the closest "recognised" image
8) Reconstruct the image from the data set and compare the simularity if above 0.6 then it is a positive result and the face is recognised.
