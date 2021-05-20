%% Load Data, vectorise images and store it as a matrix

data = load(fullfile(pwd,'faces.mat'));
faces = data.raw_images;
[numRows,numCols] = size( cell2mat(faces(1)) );
[dataRows,dataCols] = size(faces);
images = zeros(numRows*numCols,dataCols);
 for i = 1:dataCols
      dat = cell2mat(faces(i)); 
      dat = reshape(dat,[],1); % convert matrix to column vector
      images(:,i) = dat;
 end

 %% Run PCA on the images and get Eigenvectors, W and Eigenvalues, D.
 
[W,D] = pca_dimred(images);
%% Display the cummulative variance of all the eigenvalues

total_var = sum(D);
cummulative_variance = zeros(size(D)); 
cummulative_variance(1) = D(1) / total_var  * 100;
for i = 2:numel(D)
    cummulative_variance(i) =cummulative_variance(i-1) + ( D(i) / total_var  * 100 );
end



%r 5,10,20,50 and ALL p
x=[5;10;20;50;3000];
for i = 1:5
    figure('NumberTitle', 'off', 'Name', ' Cummulative Variance ');
    plot(cummulative_variance(1:x(i)))
    xlabel('Principal Component')
    ylabel('Cummulative Variance(%)')
    title( sprintf('Cummulative Variance for first %i PCs',x(i)) )
end

%% Reconstruct the first Ten eigenfaces from W
figure('NumberTitle', 'off', 'Name', 'Q2.2 B reconstructed eigenfaces'),
title('First 10 eigenfaces reconstructed');
colormap gray
for i= 1:10
    subplot(2 ,5 , i), 
    imagesc(reshape(W(:,i), numRows, numCols)), title(sprintf('Eigen Face = %i', i))
    axis off 
end

%% Reconstructing face 61 from the eigenfaces.
face61 = images(:,61);
IM = reshape(face61, numRows, numCols);
meanFace= mean(images,2);
face61 = face61 - meanFace;

figure;
x=[5;10;20;50;3000];
subplot(2,3,1)
imagesc(reshape(IM,numRows,numCols)), colormap gray, axis off, title('oringinal image')
for i = 1:numel(x)
   
    recon = meanFace + (W(:,1:x(i))*(W(:,1:x(i))'*face61) );
    subplot(2,3,i+1)
    imagesc(reshape(recon,numRows,numCols)), colormap gray, axis off, title(sprintf('Recovered face with %i number of eigenfaces',x(i)))
end



