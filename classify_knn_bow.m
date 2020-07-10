function [confusion, accuracy] = classify_knn_bow


fileID = fopen('train.txt','r');
A = textscan(fileID,'%s %s');
label = A{1};
path = A{2};
imageDB = {};
for i = 1:1:size(label,1)
    im = imread(fullfile(pwd,path{i}));
    imageDB{i}= im;  
end

fprintf('Creating vocabulary \n')
fprintf('............... \n')
vocab = build_visual_dictionary(imageDB,50);
fprintf('vocabulary created \n')

d = size(vocab,2);


fprintf('Extracting Sift Features \n')
fprintf('............... \n')

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
    [~,f] = vl_dsift(im2single(im),'step', 10, 'fast');
    b = compute_bow(f,vocab);
    feature_train(i,:) = b;
    
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
    [~,f] = vl_dsift(im2single(im),'step', 10, 'fast');
    b = compute_bow(f,vocab);
    feature_test(i,:) = b;
    
    if strcmp(lab,label{i})
        label_test(i) = count;
    else
        count = count+1;
        label_test(i) = count;
    end
    
    lab = label{i};
    
end

fprintf('Features extracted \n')

fprintf('Performing KNN \n')
[label_test_pred] = predict_knn(feature_train,label_train,feature_test,3);
    
accuracy=length(find(label_test_pred==label_test))/size(feature_test,1);
accuracy = accuracy*100;

confusion = ones(15,15);

for i = 1:size(label_test_pred,1)
    
    if label_test(i) ~= label_test_pred(i)
        
       confusion(label_test_pred(i),label_test(i)) = confusion(label_test_pred(i),label_test(i))+1;
    end
end

end
   