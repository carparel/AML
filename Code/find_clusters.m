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
plot3(true_cluster_1(:,1),true_cluster_1(:,2),true_cluster_1(:,3),'kx');
hold on;
grid on;
plot3(centroid_1(1),centroid_1(2),centroid_1(3),'ko','MarkerSize',10,'MarkerFaceColor','k')

plot3(true_cluster_2(:,1),true_cluster_2(:,2),true_cluster_2(:,3),'gx');
plot3(centroid_2(1),centroid_2(2),centroid_2(3),'go','MarkerSize',10,'MarkerFaceColor','g')
plot3(true_cluster_3(:,1),true_cluster_3(:,2),true_cluster_3(:,3),'bx');
plot3(centroid_3(1),centroid_3(2),centroid_3(3),'bo','MarkerSize',10,'MarkerFaceColor','b')
plot3(true_cluster_4(:,1),true_cluster_4(:,2),true_cluster_4(:,3),'mx');
plot3(centroid_4(1),centroid_4(2),centroid_4(3),'mo','MarkerSize',10,'MarkerFaceColor','m')
legend('Healthy NO FLOAT','Centroid Healthy NO FLOAT','Healthy FLOAT','Centroid Healthy FLOAT','SCI NO FLOAT','Centroid SCI NO FLOAT','SCI FLOAT','Centroid SCI FLOAT','AutoUpdate','off');
xlabel('PC_1','FontSize',15);
ylabel('PC_2','FontSize',15);
zlabel('PC_3','FontSize',15);
title('Distribution of our data once projected on the first 3 PCs','FontSize',15);

%% K-MEANS and Miss-clustered points

% Here, we apply kmeans imposing a number of cluster equal to 4 
% --> SCI/Healthy and FLOAT/NO FLOAT in all combinations

% We try to compare the clusters coming from the algorithm k-means with the
% true ones and we plot the miss-clustered points (onto the plot already
% existing)

nbr_clusters = 4;
idx_clusters = kmeans(PCA_data,nbr_clusters);

idx_1 = (idx_clusters == 1);
idx_2 = (idx_clusters == 2);
idx_3 = (idx_clusters == 3);
idx_4 = (idx_clusters == 4);

idx_assigned_k_mean_1 = mode(idx_clusters(ground_truth_1));
missclustered_1 = find(idx_clusters(ground_truth_1) ~= idx_assigned_k_mean_1);
current_PCA_data = PCA_data(ground_truth_1,:,:);
for i = 1:length(missclustered_1)
    plot(current_PCA_data(missclustered_1(i),1),current_PCA_data(missclustered_1(i),2),current_PCA_data(missclustered_1(i)),3,'y^','MarkerSize',8,'MarkerFaceColor','y');
end

idx_assigned_k_mean_2 = mode(idx_clusters(ground_truth_2));
missclustered_2 = find(idx_clusters(ground_truth_2) ~= idx_assigned_k_mean_2);
current_PCA_data = PCA_data(ground_truth_2,:,:);
for i = 1:length(missclustered_2)
    plot3(current_PCA_data(missclustered_2(i),1),current_PCA_data(missclustered_2(i),2),current_PCA_data(missclustered_2(i),3),'y^','MarkerSize',8,'MarkerFaceColor','y');
end

idx_assigned_k_mean_3 = mode(idx_clusters(ground_truth_3));
missclustered_3 = find(idx_clusters(ground_truth_3) ~= idx_assigned_k_mean_3);
current_PCA_data = PCA_data(ground_truth_3,:,:);
for i = 1:length(missclustered_3)
    plot3(current_PCA_data(missclustered_3(i),1),current_PCA_data(missclustered_3(i),2),current_PCA_data(missclustered_3(i),3),'y^','MarkerSize',8,'MarkerFaceColor','y');
end

idx_assigned_k_mean_4 = mode(idx_clusters(ground_truth_4));
missclustered_4 = find(idx_clusters(ground_truth_4) ~= idx_assigned_k_mean_4);
current_PCA_data = PCA_data(ground_truth_4,:,:);
for i = 1:length(missclustered_4)
    plot3(current_PCA_data(missclustered_4(i),1),current_PCA_data(missclustered_4(i),2),current_PCA_data(missclustered_4(i),3),'y^','MarkerSize',8,'MarkerFaceColor','y');
end


set(h,'Position',[0 0 680 480]);
end

