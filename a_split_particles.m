
function a__split_particles(base,figures); 

%% 

% Take Output from image segmentation -> *_cent.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load segemented and filtered centrioles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

name2=[base,'_filt_cent.mat'];
% name2='BB_B512_800mW_10ms_FOV_1_filt_cent.mat';
load(name2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DBSCAN parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=20;                                               % minimum number of neighbors within Eps
Eps=15;                                             % minimum distance between points, nm

fprintf('\n -- Segemented and filtered centrioles loaded --\n')

%% DBSCAN to identify individuals in the pair


k=20;                                               % minimum number of neighbors within Eps
Eps=6.3;                                             % minimum distance between points, nm


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create variable for DBSCAN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filtCent2=[];
count=1;
filt=100;

for i=1:length(filtCent);
    
dataDBS=[];

dataDBS(:,1)=filtCent{i,1}(:,1); % x
dataDBS(:,2)=filtCent{i,1}(:,2); % y

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

fprintf(' -- DBSCAN results plotted -- \n')

else end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter by length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:max(subset(:,3));
    
    target=find(subset(:,3)==j);
    
    if length(target)>filt;
        
        filtCent2{count,1}=subset(target,1:2);
        count=count+1;
        
    else end
    
end

fprintf(' -- Filtered Centrioles saved in filtCent -- \n')

end

fprintf(' -- DBSCAN Done -- \n')


if figures==1;
    
figure
set(gcf, 'name', 'Result from Splitting')

for k=1:length(filtCent2);
    
    idx=[];
    idx = rangesearch(filtCent2{k,1},filtCent2{k,1},5);
    
    plot=[];
    plot(:,1)=filtCent2{k,1}(:,1);
    plot(:,2)=filtCent2{k,1}(:,2);
    

            for j=1:length(idx)
            plot(j,3)=length(idx{j,1});
            end
            

        subplot(5,6,k); hold on;        
        scatter(plot(:,1),plot(:,2),1,mod(plot(:,3),10));
        colorbar
        title(['Cent # ' num2str(k)]);
    
end

else end

%% Find Center of Mass for each Particle and Select Locs around

Center=[];
radius=200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find Center of Mass of each individual Cent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:length(filtCent2);
             
            Center(k,1)=(((max(filtCent2{k,1}(:,1))-min(filtCent2{k,1}(:,1)))/2)+min(filtCent2{k,1}(:,1)));
            Center(k,2)=(((max(filtCent2{k,1}(:,2))-min(filtCent2{k,1}(:,2)))/2)+min(filtCent2{k,1}(:,2)));    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine all Locs ino single variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

allX=[];
allY=[];

for p=1:length(filtCent);
    
    allX=cat(1,allX,filtCent{p,1}(:,1));
    allY=cat(1,allY,filtCent{p,1}(:,2));
    
end

allCent(:,1)=allX;
allCent(:,2)=allY;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select all locs around each CoM %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

split_cent=[];
split_cent2=[];

for m=1:length(Center); % for all CoM
    
    for n=1:length(allCent); % for all points in dataset
        
        if  sqrt(((allCent(n,1)-Center(m,1))^2)+((allCent(n,2)-Center(m,2))^2)) <= radius;
            
            split_cent{m,1}(n,1)= allCent(n,1);
            split_cent{m,1}(n,2)= allCent(n,2);
            
        else end
  
    end
   
    split_cent2{m,1}(:,1)=nonzeros(split_cent{m,1}(:,1));
    split_cent2{m,1}(:,2)=nonzeros(split_cent{m,1}(:,2));
    
end


fprintf(' -- Locs around each CoM selected -- \n')

if figures==1;
    
   figure
   set(gcf, 'name', 'Result from splitting and locs from CoM')

for k=1:length(split_cent2);
    
    idx=[];
    idx = rangesearch(split_cent2{k,1},split_cent2{k,1},5);
    
    plot=[];
    plot(:,1)=split_cent2{k,1}(:,1);
    plot(:,2)=split_cent2{k,1}(:,2);
    

            for j=1:length(idx)
            plot(j,3)=length(idx{j,1});
            end
            

        subplot(5,6,k); hold on;        
        scatter(plot(:,1),plot(:,2),3,mod(plot(:,3),10));
        colorbar
        title(['Cent # ' num2str(k)]);
    
end

else end


%% Save filtered centrioles

save([base,'_split_filt_cent.mat'],'split_cent2');

fprintf('\n -- Saved Split centrioles -- \n')
fprintf('\n -- Finished processing -- \n')


        
end


