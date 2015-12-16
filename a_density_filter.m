function a_density_filter(base,figures); 

% Take Output from image segmentation -> *_cent.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load segemented centrioles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

name2=[base,'_cent.mat'];
% name='BB_B512_800mW_10ms_FOV_1_cent.mat';
load(name2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DBSCAN parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=10;                                               % minimum number of neighbors within Eps
Eps=22;                                             % minimum distance between points, nm

fprintf('\n -- Segmented centrioles loaded --\n')

%% Cluster DBSCAN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create variable for DBSCAN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filtCent=[];
count=1;
filt=1500;

for i=1:length(Cent);
    
dataDBS=[];

dataDBS(:,1)=Cent{i,1}(:,1); % x
dataDBS(:,2)=Cent{i,1}(:,2); % y

tic
[class,type]=DBSCAN(dataDBS,k,Eps);     % uses parameters specified at input
class2=transpose(class);                % class - vector specifying assignment of the i-th object to certain cluster (m,1)
type2=transpose(type);                  % (core: 1, border: 0, outlier: -1)

fprintf(' -- DBSCAN computed in %f sec -- \n',toc)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find core points --> type = 1 or 0 and define them as subset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subset=[];

coreBorder=find(type2 >= 0);

subset(:,1)=dataDBS(coreBorder,1);
subset(:,2)=dataDBS(coreBorder,2);
subset(:,3)=class2(coreBorder);

if figures==1;

figure('Position',[700 600 900 400])
subplot(1,2,1)
scatter(dataDBS(:,1),dataDBS(:,2),1);
title('Raw Data')
axis on
axis([min(dataDBS(:,1)) max(dataDBS(:,1)) min(dataDBS(:,2)) max(dataDBS(:,2))])

subplot(1,2,2)
scatter(subset(:,1),subset(:,2),1,mod(subset(:,3),10))
title('identified Clusters')
axis on
axis([min(dataDBS(:,1)) max(dataDBS(:,1)) min(dataDBS(:,2)) max(dataDBS(:,2))]) 

fprintf(' -- DBSCAN results plotted -- \n',toc)

else end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter by length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:max(subset(:,3));
    
    target=find(subset(:,3)==j);
    
    if length(target)>filt;
        
        filtCent{count,1}=subset(target,1:2);
        count=count+1;
        
    else end
    
end

fprintf(' -- Filtered Centrioles saved in filtCent -- \n',toc)

end

fprintf(' -- DBSCAN Done -- \n',toc)

%% Plot density 

if figures==1;
    
    dim=round(sqrt(length(filtCent)));
    

for k=1:length(filtCent);
    
    idx=[];
    idx = rangesearch(filtCent{k,1},filtCent{k,1},5);
    
    plot=[];
    plot(:,1)=filtCent{k,1}(:,1);
    plot(:,2)=filtCent{k,1}(:,2);
    

            for j=1:length(idx)
            plot(j,3)=length(idx{j,1});
            end
            

        subplot(dim+1,dim+1,k); hold on;        
        scatter(plot(:,1),plot(:,2),3,mod(plot(:,3),10));
        colorbar
        title(['Cent # ' num2str(j)]);
    
end

else end

%% Save filtered centrioles

save([base,'_filt_cent.mat'],'filtCent');

fprintf('\n -- Renderd centrioles saved -- \n')
fprintf('\n -- Finished processing -- \n')

%% Render filtered centrioles

folder='Filtered_Centrioles';

mkdir(folder);


    
for j=1:length(filtCent);

        width=round(max(filtCent{j,1}(:,2))/20);
        height=round(max(filtCent{j,1}(:,1))/20);
      
        im=hist3([filtCent{j,1}(:,2),filtCent{j,1}(:,1)],[400 400]); % heigth x width
    
        G = fspecial('gaussian',[3 3],1); % lowpass filter of size and gaussian blur sigma, [lowpass filter] sigma
        imG = imfilter(im,G,'same');

        imwrite(imG,[folder,'/',base,'_filt_cent_',num2str(j),'.tiff'],'tiff');
    
end

fprintf('\n -- Renderd centrioles saved -- \n')

end
