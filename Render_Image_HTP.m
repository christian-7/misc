function Render_Image_HTP(filename,pxlsize) 

% filename='A549_EGF_A647_2000mW_10ms__1_MMStack_locResults_DC.dat';

% Load data set, plot 2D histogram and Gaussian Blur  

file = fopen(filename);
line = fgetl(file);
h = regexp( line, ',', 'split' );

x = strmatch('x [nm]',h);
y = strmatch('y [nm]',h);
LL = strmatch('loglikelihood',h);

% Load file
locs=dlmread(filename,',',1,0);

%filter by Loglikelihood
thresh=500;
filter=find(locs(:,LL)<thresh);
subsetLL=locs(filter,1:end);

% Find width and heigth
heigth=round((max(subsetLL(:,y))-min(subsetLL(:,y)))/pxlsize);
width=round((max(subsetLL(:,x))-min(subsetLL(:,x)))/pxlsize);

% Calculate 2D histogram --> 10 nm/pxl

im=hist3([subsetLL(:,x),subsetLL(:,y)],[width heigth]); % heigth x width
I16 = uint16(round(im*65535));

% Show 2D 
figure
set(gcf, 'name', '2D Histogram')
imshow(I16)
colormap('hot');

% Apply Gaussian Filter

G = fspecial('gaussian',[3 3],1); % lowpass filter of size and gaussian blur sigma, [lowpass filter] sigma
imG = imfilter(im,G,'same');

figure
set(gcf, 'name', 'Gaussian Filtered')
imshow(imG,[0 3]);
colormap('hot');
colorbar;

end

