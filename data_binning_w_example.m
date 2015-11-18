
a = 100;
b = 200;
c = 300;

data(:,1)=1:1:1000;
data(1:500,2)=(b-a).*rand(500,1) + a;
data(501:1000,2)=(c-a).*rand(500,1) + b;

figure
scatter(data(:,1),data(:,2),'b'); hold on;

bins=transpose(10:20:1000);

for i=1:length(bins)-1;
    
    target=find(bins(i+1,1)>data(:,1) & data(:,1)>bins(i,1));
    
    bins(i,2)=mean(data(target,2));
    
end
    
    scatter(bins(:,1),bins(:,2),'r'); 
    
    