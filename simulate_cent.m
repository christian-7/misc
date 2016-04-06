t = 0:pi/10:2*pi;
r=3;
figure
plot(t,3);
%% 

figure
[X,Y,Z] = cylinder(r);
surf(X,Y,Z)
axis square

%% 

clear;clc;
cmap = hsv(10);

for ii=1:10
    hold on
   [X,Y,Z]=cylinder(rand(1,1)*0.4);
   
   h=surf(X+(rand(1,1)-10)*2,Y+(rand(1,1)-10)*2,Z*rand(1,1)*10,'FaceColor',cmap(ii,:));
end

%% 
clear;clc;close all

list=zeros(30,2);
diam=25;

r=130;
center=[0,0];
t=-pi:(2*pi/9):pi;
x=r*cos(t)+center(1);
y=r*sin(t)+center(2);
scatter(x,y);hold on;

r=155+diam;
x2=r*cos(t)+center(1);
y2=r*sin(t)+center(2);
scatter(x2,y2);

r=205+diam;
x3=r*cos(t)+center(1);
y3=r*sin(t)+center(2);
scatter(x3,y3);

list(1:10,1)=x;
list(11:20,1)=x2;
list(21:30,1)=x3;
list(1:10,2)=y;
list(11:20,2)=y2;
list(21:30,2)=y3;

for i=1:30;
[X,Y,Z]=cylinder(diam);
surf(X+list(i,1),Y+list(i,2),Z*450);hold on;
end

%% 

  clear Data;
  Data.vertex.x = [0;0;0;0;1;1;1;1];
  Data.vertex.y = [0;0;1;1;0;0;1;1];
  Data.vertex.z = [0;1;1;0;0;1;1;0];
  Data.face.vertex_indices = {[0,1,2,3],[7,6,5,4], ...
        [0,4,5,1],[1,5,6,2],[2,6,7,3],[3,7,4,0]};
  ply_write(Data,'cube.ply','ascii');
  
  %% 
  clear;clc;close all
  [X,Y,Z]=cylinder(1);
  H=surf(X,Y,Z);
  
  clear Data;
  Data.vertex.x = [X];
  Data.vertex.y = [Y];
  Data.vertex.z = [Z];
  Data.face.vertex_indices = [H];
  
  
  
  
  