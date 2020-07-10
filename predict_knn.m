function [label_test_pred] = predict_knn(feature_train,label_train,feature_test,k)

label_test_pred=zeros(size(feature_test,1),1);

sumVal=zeros(size(feature_test,1),size(feature_train,1)); 
index=zeros(size(feature_test,1),size(feature_train,1));


for i=1:size(feature_test,1)
    for j=1:size(feature_train,1)
        sumVal(i,j)= sum(abs(feature_test(i,:)-feature_train(j,:)));
    end
    [sumVal(i,:),index(i,:)]=sort(sumVal(i,:));
end

knn=zeros(size(feature_test,1),k); 
knn=index(:,1:k);
for i=1:size(knn,1)
    uni=unique(label_train(knn(i,:)'));
    max_count=0;
    max_label=0;
    for j=1:length(uni)
        val=length(find(label_train(knn(i,:)')==uni(j)));
        if val>max_count
            max_label=uni(j);
            max_count=val;
        end
    end
    label_test_pred(i)=max_label;
end

end