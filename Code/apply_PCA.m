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
names_variables = {'LMG duration','LMG max','LMG mean','RMG duration','RMG max',...
    'RMG mean','LTA duration','LTA max','LTA mean','RTA duration','RTA max','RTA mean',...
    'ROM ank FE R','ROM knee FE R','ROM hip FE R','ROM knee AA R', 'ROM hip AA R','w ank FE R',...
    'w knee FE R','w hip FE R','w knee AA R','w hip AA R','ROM ank FE L','ROM knee FE L','ROM hip FE_L',...
    'ROM knee AA L', 'ROM hip AA L','w ank FE L','w knee FE L','w hip FE L','w knee AA L','w hip AA L',...
    'gait cycle duration','cadence','stance duration right','swing duration right','stance duration left',...
    'swing duration left','double stance duration','stride length right m','stride length left m','swing length right cm',...
    'swing length left cm','step length right cm','step length left cm','step width cm','max heel clearance right',...
    'max heel clearance left','max knee clearance right','max knee clearance left','max toe clearance right','max toe clearance left'
    };

names_PCs = {'PC_1','PC_2','PC_3'};

h = figure();
imagesc(features_weights);
colorbar;
colormap('jet');
yticks(1:1:length(names_variables));
yticklabels(names_variables);
xticks(1:1:3);
xticklabels(names_PCs);
title('Weights of all the features for the first 3 PCs','FontSize',15);
set(h,'Position',[0 0 480 1920]);

end

