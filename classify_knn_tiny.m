function [confusion, accuracy] = classify_knn_tiny


% this must be specified based on the tiny image size
d = 256;

% To read the data and convert into arrays for processing
fileID = fopen('train.txt','r');
A = textscan(fileID,'%s %s');
label = A{1};
path = A{2};
feature_train = ones(size(label,1),d);
label_train = zeros(size(label,1),1);
count = 1 ;
lab = label{1};

for i = 1:size(label,1)
    im = imread(fullfile(pwd,path{i}));
    im_small = get_tiny_image(im,[16,16]);
    feature_train(i,:) = im_small;
    
    if strcmp(lab,label{i})
        label_train(i) = count;
    else
        count = count+1;
        label_train(i) = count;
    end
    
    lab = label{i};
    
end


fileID = fopen('test.txt','r');
A = textscan(fileID,'%s %s');
label = A{1};
path = A{2};
feature_test = ones(size(label,1),d);
label_test = zeros(size(label,1),1);
count = 1 ;
lab = label{1};
for i = 1:size(label,1)
    im = imread(fullfile(pwd,path{i}));
    im_small = get_tiny_image(im,[16,16]);
    feature_test(i,:) = im_small;
    
    if strcmp(lab,label{i})
        label_test(i) = count;
    else
        count = count+1;
        label_test(i) = count;
    end
    
    lab = label{i};
    
end

% To classify using KNN
[label_test_pred] = predict_knn(feature_train,label_train,feature_test,3);

% To make confusion matrix
confusion = ones(15,15);

for i = 1:size(label_test_pred,1)
    
    if label_test(i) ~= label_test_pred(i)
        
       confusion(label_test_pred(i),label_test(i)) = confusion(label_test_pred(i),label_test(i))+1;
    end
end

% caclulate accuracy
if isempty(label_test)==0
    accuracy=length(find(label_test_pred==label_test))/size(feature_test,1);
    accuracy = accuracy*100;
end
