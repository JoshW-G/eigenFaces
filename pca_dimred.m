%function to calculate eigenvectors (W) and eigenvalues (D) from data (X)
function[W,D] = pca_dimred(X)
    %normalise the data set
    Xnorm = (X - mean(X)) ./ std(X,1);
    
    %compute covariance matrix
    covMat = cov(Xnorm');
    %D = vector of eignevalue (sort to largest to smallest)
    % W = matrix eigenvectors
    [W, D] = eig(covMat,'vector');
    %sort eigenvalues and eigenvectors
    D = sort(D, 'descend');
    W = fliplr(W);
    return;
end