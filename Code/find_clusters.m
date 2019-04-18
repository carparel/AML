function [] = find_clusters(PCA_data,whole_labels)
% This function plots the data after the projection with PCA has been
% performed. Since we kept the 3 first PCs, we can plot the points in a 3D
% space. In addition, we perform the k-means algorithm in order to see what
% are the clusters mathematically found. Then, we find the miss-clustered
% points and we highlight them.
%
% INPUT: - PCA_data = Data after projection on the 3 first PCs.
%        - whole_labels = Labels of all the gait cycles.
%
% OUTPUT: //


%% PLOTTING THE TRUE CLUSTERS
labels = table2array(whole_labels);

ground_truth_1 = ((labels(:,1) + labels(:,2)) == 2);
ground_truth_2 = ((labels(:,1) - labels(:,2)) == 1);
ground_truth_3 = ((labels(:,1) - labels(:,2)) == -1);
ground_truth_4 = ((labels(:,1) + labels(:,2)) == 0);

true_cluster_1 = PCA_data(ground_truth_1,:,:);
true_cluster_2 = PCA_data(ground_truth_2,:,:);
true_cluster_3 = PCA_data(ground_truth_3,:,:);
true_cluster_4 = PCA_data(ground_truth_4,:,:);

centroid_1 = nanmean(PCA_data(ground_truth_1,:,:));
centroid_2 = nanmean(PCA_data(ground_truth_2,:,:));
centroid_3 = nanmean(PCA_data(ground_truth_3,:,:));
centroid_4 = nanmean(PCA_data(ground_truth_4,:,:));

h = figure();
plot3(true_cluster_1(:,1),true_cluster_1(:,2),true_cluster_1(:,3),'kx','MarkerSize',30);
hold on;
grid on;
plot3(centroid_1(1),centroid_1(2),centroid_1(3),'ko','MarkerSize',35,'MarkerFaceColor','k')

plot3(true_cluster_2(:,1),true_cluster_2(:,2),true_cluster_2(:,3),'gx','MarkerSize',30);
plot3(centroid_2(1),centroid_2(2),centroid_2(3),'go','MarkerSize',35,'MarkerFaceColor','g')
plot3(true_cluster_3(:,1),true_cluster_3(:,2),true_cluster_3(:,3),'bx','MarkerSize',30);
plot3(centroid_3(1),centroid_3(2),centroid_3(3),'bo','MarkerSize',35,'MarkerFaceColor','b')
plot3(true_cluster_4(:,1),true_cluster_4(:,2),true_cluster_4(:,3),'mx','MarkerSize',30);
plot3(centroid_4(1),centroid_4(2),centroid_4(3),'mo','MarkerSize',35,'MarkerFaceColor','m')
%legend('Healthy NO FLOAT','Centroid Healthy NO FLOAT','Healthy FLOAT','Centroid Healthy FLOAT','SCI NO FLOAT','Centroid SCI NO FLOAT','SCI FLOAT','Centroid SCI FLOAT','AutoUpdate','off','Location','BestOutside');
xlabel('PC_1','FontSize',40);
ylabel('PC_2','FontSize',4);
zlabel('PC_3','FontSize',40);
ax = gca;
ax.FontSize = 40; 
title('Distribution of all our data projected on the first 3 PCs','FontSize',55);
%set(h,'Position',[0 0 680 480]);
end

