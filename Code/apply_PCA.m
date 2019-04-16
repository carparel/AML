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
names_variables = {'Left Gastrocnemius Medialis - Duration','Left Gastrocnemius Medialis - Max',...
    'Left Gastrocnemius Medialis - Mean','Right Gastrocnemius Medialis - Duration','Right Gastrocnemius Medialis - Max',...
    'Right Gastrocnemius Medialis - Mean','Left Anterioris Tibialis - Duration',...
    'Left Anterioris Tibialis - Max','Left Anterioris Tibialis - Mean', ...
    'Right Anterioris Tibialis - Duration','Right Anterioris Tibialis - Max','Right Anterioris Tibialis - Mean',...
    'Right Ankle - FE - Range Of Motion','Right Knee - FE - Range Of Motion','Right Hip - FE - Range Of Motion',...
    'Right Knee - AA - Range Of Motion', 'Right Hip - AA - Range Of Motion','Right Ankle - FE - Angular Velocity',...
    'Right Knee - FE - Angular Velocity','Right Hip - FE - Angular Velocity','Right Knee - AA - Angular Velocity',...
    'Right Hip - AA - Angular Velocity','Left Ankle - FE - Range Of Motion','Left Knee - FE - Range Of Motion',...
    'Left Hip - FE - Range Of Motion','Left Knee - AA - Range Of Motion', 'Left Hip - AA - Range Of Motion',...
    'Left Ankle - FE - Angular Velocity','Left Knee - FE - Angular Velocity','Left Hip - FE - Angular Velocity',...
    'Left Knee - AA - Angular Velocity','Left Hip - AA - Angular Velocity','Gait Cycle Duration','Cadence',...
    'Right Stance Duration','Right Swing Duration','Left Stance Duration','Left Swing Duration','Double Stance Duration',...
    'Right Stride Length','Left Stride Length','Right Swing Length','Left Swing Length','Right Step Length','Left Step Length',...
    'Step Width','Right Max Heel Clearance','Left Max Heel Clearance','Right Max Knee Clearance','Left Max Knee Clearance',...
    'Right Max Toe Clearance','Left Max Toe Clearance'
    };

names_PCs = {'PC_1','PC_2','PC_3'};

h = figure();
imagesc(features_weights');
colorbar;
colormap('jet');
xticks(1:1:length(names_variables));
xticklabels(names_variables);
xtickangle(90);
yticks(1:1:3);
yticklabels(names_PCs);
title('Weights of all the features for the first 3 PCs','FontSize',15);
set(h,'Position',[0 0 1200 480]);

end

