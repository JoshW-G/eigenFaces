sunglass = imread(fullfile(pwd,'Sunglasses.png'));
celeb = imread(fullfile(pwd,'Celeb.png'));
%% 

recognised =facial_recognition(sunglass);
%% 

recognised1 = facial_recognition(celeb);
%% 

function [recognised] = facial_recognition(inputIm)
    %load data
    data = load(fullfile(pwd,'faces.mat'));
    faces = data.raw_images;
    %vectorise images
    [numRows,numCols] = size( cell2mat(faces(1)) );
    [dataRows,dataCols] = size(faces);
    images = zeros(numRows*numCols,dataCols);
     for i = 1:dataCols
          dat = cell2mat(faces(i)); 
          dat = reshape(dat,[],1); 
          images(:,i) = dat;
     end
% get eigenvectors,W and egien values D of the data set    
    [W,D] = pca_dimred(images);

    % evaluate the number of principal components needed to represent 95% Total variance.
    total_var = sum(D);
    csum = 0 ;
    for i = 1:(numRows*numCols)
        csum = csum + D(i);
        tv = csum/ total_var;
        if tv > 0.95
            min95= i;
            break
        end
    end
    W = W(:,1:min95);
    meanFace = mean(images);
    %calculate the weights of the principal components of 95% variance
     weights =  W'* (images - meanFace);
    

    %get input image and process/vectorise it
    inputIm = im2gray(inputIm);
    [row, col] = size(inputIm);
    inputIm= imresize(inputIm,'scale',[(numRows/row)  (numCols/col)]);
    inputIm = double(inputIm);
    inputIm = reshape(inputIm,[],1);

    %calculate weights for the input image
    testWeights = W'* (inputIm - meanFace) ;


    % Calculate the euclidean distances for input weights against the weights of the
    % original image set
    for b=1:dataCols
            d(b) = sqrt(sum((testWeights(:,b)-weights(:,b)).^2));
    end
       %Get closest eigenface index 
    [euclide_dist_min recognized_index] = min(d);

    %recover recognised image 
    inputIm = reshape(inputIm, numRows, numCols);
    detectedIm = reshape(images(:,recognized_index(1)), numRows, numCols);

    %calculate similiarity
    ssimval = ssim(inputIm,detectedIm);

    if ssimval> 0.6
        recognised = 'ACCESS GRANTED';
    else
        recognised = 'ACCESS DENIED';
    end

    figure('NumberTitle', 'off', 'Name', 'Q2.3');
    colormap gray

    subplot(1,2,1) , imagesc(inputIm), title('Input Image'), axis off
    subplot(1,2,2), imagesc(detectedIm), title(sprintf('Recognised Face: %s' , recognised))
    axis off 
    return;
end
