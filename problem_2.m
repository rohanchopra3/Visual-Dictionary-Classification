
import build_visual_dictionary.*
import compute_bow.*

import classify_knn_bow.*


[confusionM,accuracy]=classify_knn_bow;
figure(3);
imagesc(confusionM);
colormap jet;
xticks(1:1:15)
xticklabels({'kit','sto','bed','liv','off','Ind','sub','cty','bid','st','HW','OC','Cst','Mnt','For'})
yticks(1:1:15)
yticklabels({'kitchen','store','bedroom','livingroom','office','Industrial','suburb','Insidecity','Tallbuilding','street','Highway','OpenCountry','Coast','Mountain','Forest'})
xlabel(['Accuracy(%) :',num2str(accuracy )])