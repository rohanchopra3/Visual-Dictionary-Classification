import get_tiny_image.*
import predict_knn.*

import classify_knn_tiny.*


[confusionM,accuracy]=classify_knn_tiny;
figure(3);
imagesc(confusionM);
colormap jet;
xticks(1:1:15)
xticklabels({'kit','sto','bed','liv','off','Ind','sub','cty','bid','st','HW','OC','Cst','Mnt','For'})
yticks(1:1:15)
yticklabels({'kitchen','store','bedroom','livingroom','office','Industrial','suburb','Insidecity','Tallbuilding','street','Highway','OpenCountry','Coast','Mountain','Forest'})
xlabel(['Accuracy(%) :',num2str(accuracy )])