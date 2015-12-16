function a_image_segmentation(WF_name,base,figures) 

%% Read Data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pxl=107.99;                         % Pixel size in nm
% WF_name='FOV_5_WF.tif';             % name of the WF image
% base='FOV_5_noPB_1500mW_10ms_1';    % filename base

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load image
im=imread(WF_name);

% Load data set
name2=[base,'_MMStack_locResults_DC_merged.dat'];
locs=dlmread(name2,',',1,0);

%filter dataset by Loglikelihood
thresh=500;
filter=find(locs(:,8)<thresh);
subsetLL=locs(filter,1:end);

fprintf('\n -- Data loaded --\n')


%% Find and Plot Center of mass for each object

% Make binary image
bin=im2bw(im,0.1);
[B,L,N,A] = bwboundaries(bin);

% Plot result

if figures==1;

figure('Position',[300 600 1000 400])
subplot(1,2,1)
imshow(im)
title('WF image');
subplot(1,2,2)
imshow(bin)
title('Binary image');

else end

%Find the center of each particle

Center=[];
for k=1:length(B)
        boundary = B{k};
        
            Center(k,1)=(((max(B{k,1}(:,1))-min(B{k,1}(:,1)))/2)+min(B{k,1}(:,1)))*pxl;
            Center(k,2)=(((max(B{k,1}(:,2))-min(B{k,1}(:,2)))/2)+min(B{k,1}(:,2)))*pxl;    
end

fprintf('\n -- Centrioles identified --\n')

%% Build box around each Center and copy locs into separate variable -> structure Cent


Cent={};

box_width = 2000;
box_height = 2000;

if figures==1;
figure
    
for i=1:length(Center);
    
    vx1=Center(i,2)+box_width/2;
    vx2=Center(i,2)-box_width/2;
    vy1=Center(i,1)+box_height/2;
    vy2=Center(i,1)-box_height/2;
    
    vx=find(subsetLL(:,1) < vx1 & subsetLL(:,1) > vx2);
    subset=subsetLL(vx,1:9);

    vy=find(subset(:,2) < vy1 & subset(:,2) > vy2);

    Cent{i,1}=subset(vy,1:end);
    
    scatter(Cent{i,1}(:,1),Cent{i,1}(:,2),1);hold on;
    
end 

scatter(Center(:,2),Center(:,1),'*b');hold on;
title('Selected Centrioles');

else
    
for i=1:length(Center);
    
    vx1=Center(i,2)+box_width/2;
    vx2=Center(i,2)-box_width/2;
    vy1=Center(i,1)+box_height/2;
    vy2=Center(i,1)-box_height/2;
    
    vx=find(subsetLL(:,1) < vx1 & subsetLL(:,1) > vx2);
    subset=subsetLL(vx,1:9);

    vy=find(subset(:,2) < vy1 & subset(:,2) > vy2);

    Cent{i,1}=subset(vy,1:end);
       
end 

end
    
fprintf('\n -- %f Centrioles selected from localitaion dataset --\n',length(Cent))

%% Render each centriole and make overview

for j=1:length(Cent);
    
    im=hist3([Cent{j,1}(:,2),Cent{j,1}(:,1)],[box_height/10 box_width/10]); % heigth x width
    
    G = fspecial('gaussian',[3 3],1); % lowpass filter of size and gaussian blur sigma, [lowpass filter] sigma
    imG = imfilter(im,G,'same');

    if figures==1;
        
        subplot(4,5,j); hold on;
        imshow(imG)
        colormap('hot');
        title(['Cent # ' num2str(j)]);
    
    else end
    
    clear im
    
end 

fprintf('\n -- Overview of extracted centrioles --\n',length(Cent))


%% Save Rendered Centrioles in new Folder

folder='Rendered_Centrioles';

mkdir(folder);
    
for j=1:length(Cent);

        im=hist3([Cent{j,1}(:,2),Cent{j,1}(:,1)],[box_height/5 box_width/5]); % heigth x width
    
        G = fspecial('gaussian',[3 3],1); % lowpass filter of size and gaussian blur sigma, [lowpass filter] sigma
        imG = imfilter(im,G,'same');

        imwrite(imG,[folder,'/',base,'_cent_',num2str(j),'.tiff'],'tiff');
    
end

fprintf('\n -- Renderd centrioles saved -- \n')


save([folder,'/',base,'_cent.mat'],'Cent');

end
