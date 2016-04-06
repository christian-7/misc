function Render_Image_HTP(filename,pxlsize) 

% filename='A549_EGF_A647_2000mW_10ms__1_MMStack_locResults_DC.dat';

% Load data set, plot 2D histogram and Gaussian Blur  

filename2=[filename '.csv'];
locs=dlmread(filename2,',',1,0);

file = fopen(filename2);
line = fgetl(file);
h = regexp( line, ',', 'split' );

% Form Thunderstorm

x = strmatch('"x [nm]"',h);
y = strmatch('"y [nm]"',h);
frame = strmatch('"frame"',h);

% Pxlsize correction

locs(:,y)=locs(:,y)*0.625;
locs(:,x)=locs(:,x)*0.625;

% Find width and heigth
heigth=round((max(locs(:,y))-min(locs(:,y)))/pxlsize);
width=round((max(locs(:,x))-min(locs(:,x)))/pxlsize);

% Calculate 2D histogram --> 10 nm/pxl

im=hist3([locs(:,x),locs(:,y)],[width heigth]); % heigth x width
imwrite(im,'rendered_10nm_pxl.tiff');


%% Show images

% Show 2D 
figure
set(gcf, 'name', '2D Histogram')
imshow(im)
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

