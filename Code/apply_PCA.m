function [PCA_data,features_weights] = apply_PCA(whole_matrix)
% This function performs the PCA on our whole matrix
%
% INPUT: - whole_matrix = matrix containing all the features
% 
% OUTPUT: - PCA_data = projected data on the 3 first PCs
%         - features_weights = coefficients of the 3 first PCs


% The parameter 'Centered' of PCA is by default set to true, which means
% that the function pca() is already centering our data. No need for
% normalization. 
[coeff,~,~,~,~,~] = pca(whole_matrix);

% We are interested in only the first 3 Principal Components
features_weights = coeff(:,1:3);

% Finding the projected data on the 3 first PCs
PCA_data = whole_matrix * features_weights;


%% Plotting the weigths of the 3 first PCs
names_variables = {'LGM Duration','LGM Max',...
    'LGM Mean','RGM Duration','RGM Max',...
    'RGM Mean','LTA Duration',...
    'LTA Max','LTA Mean', ...
    'RTA Duration','RTA Max','RTA Mean',...
    'ROM FE RANK','ROM FE RKNE','ROM FE RHIP',...
    'ROM AA RKNE', 'ROM AA RHIP','Ang Vel FE RANK',...
    'Ang Vel FE RKNE','Ang Vel FE RHIP','Ang Vel AA RKNE',...
    'Ang Vel AA RHIP','ROM FE LANK','ROM FE LKNE',...
    'ROM FE LHIP','ROM AA LKNE', 'ROM AA LHIP',...
    'Ang Vel FE LANK','Ang Vel FE LKNE','Ang Vel FE LHIP',...
    'Ang Vel AA LKNE','Ang Vel AA LHIP','Gait Cycle Dur','Cadence',...
    'R Stance Dur','R Swing Dur','L Stance Dur','L Swing Dur','Double Stance Dur',...
    'Stride Length','R Swing Length','L Swing Length','R Step Length','L Step Length',...
    'Step Width','Max RANK Clearance','Max LANK Clearance','Max RKNE Clearance','Max LKNE Clearance',...
    'Max RTOE Clearance','Max LTOE Clearance','Speed'
    };

names_PCs = {'PC_1','PC_2','PC_3'};

h = figure();
imagesc(features_weights');
colorbar;
colormap('jet');
ax = gca;
ax.FontSize = 18; 
xticks(1:1:length(names_variables));
xticklabels(names_variables);
xtickangle(90);
yticks(1:1:3);
yticklabels(names_PCs);
title('Weights of features for the first 3 PCs','FontSize',35);
set(h,'Position',[0 0 1200 480]);

end

