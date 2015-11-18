function [params]=bootstrap(Data1, Data2, n);

%% Compute Bootstrapping n times, subsample size = sample size

tic
a = 1;
b = length(Data1);
c = length(Data2);

index = randi([a b],b,n);
index2 = randi([a c],c,n);

boot1=zeros(n,1);
boot2=zeros(n,1);

for i=1:n;
    
    boot1(i)=mean(Data1(index(:,i)));
    boot2(i)=mean(Data2(index2(:,i)));
    
end

fprintf(' -- Bootstraping done after %f sec -- \n',toc)

%% Plot histogram, CDF and calculate p-value

[countsA, binsA] = hist(boot1);
[countsB, binsB] = hist(boot2);

dif=boot2-boot1;
[countsDif, binsDif] = hist(dif);
cdfA = cumsum(countsDif) / sum(countsDif);

figure('Position',[600 400 1200 300])

subplot(1,3,1)
ksdensity(Data1);hold on
ksdensity(Data2);
title('Kernel Density of Both Data Sets', 'FontSize', 12);
ylabel('kernel density', 'FontSize', 12);
xlabel('Mean Nbr of Mol','FontSize', 12);
legend('Data1','Data2');
grid on;

subplot(1,3,2)
bar(binsA, countsA/sum(countsA));hold on;
bar(binsB, countsB/sum(countsB),'red');
title('Histogram of Both Data Sets', 'FontSize', 12);
ylabel('Counts', 'FontSize', 12);
xlabel('Mean Nbr of Mol','FontSize', 12);
legend('Data1','Data2');
grid on;

subplot(1,3,3)
bar(binsDif, cdfA);hold on;
cdfplot(dif);
title('CDF of difference', 'FontSize', 12);
ylabel('Counts', 'FontSize', 12);
xlabel('Cluster Area','FontSize', 12);
legend('Computed CDF','Empirical CDF');
grid on;

pval=length(dif(dif<0))/length(dif);

fprintf('\n');
fprintf('  p-value = %f \n',pval)
fprintf('\n');
fprintf('-- After Bootstrapping -- \n');
fprintf('\n');
fprintf('  Mean Data1 = %f ± %d \n',mean(boot1),std(boot1))
fprintf('\n');
fprintf('  Median Data1 = %f ± %d \n',median(boot1),std(boot1))
fprintf('\n');
fprintf('  Mean Data2 = %f ± %d \n',mean(boot2),std(boot2))
fprintf('\n');
fprintf('  Median Data2 = %f ± %d \n',median(boot2),std(boot2))
fprintf('\n');
fprintf('-- Before Bootstrapping -- \n');
fprintf('\n');
fprintf('  Mean Data1 = %f ± %d \n',mean(Data1),std(Data1))
fprintf('\n');
fprintf('  Median Data1 = %f ± %d \n',median(Data1),std(Data1))
fprintf('\n');
fprintf('  Mean Data2 = %f ± %d \n',mean(Data2),std(Data2))
fprintf('\n');
fprintf('  Median Data2 = %f ± %d \n',median(Data2),std(Data2))

%% 
params=struct('Data1', [], 'Data2', [],'pvalue',[]);

params.Data1(1,1)=mean(boot1);
params.Data1(1,2)=std(boot1);
params.Data1(2,1)=median(boot1);
params.Data1(2,2)=std(boot1);

params.Data2(1,1)=mean(boot2);
params.Data2(1,2)=std(boot2);
params.Data2(2,1)=median(boot2);
params.Data2(2,2)=std(boot2);

params.pfigurevalue(1,1)=pval;

end

