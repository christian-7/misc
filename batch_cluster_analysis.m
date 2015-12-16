
base='A549_EGFR_Y38_1500mW_10ms_IAV_'; % select the base name of the folder

for i=[1,2,3,4,5,6,7];

path=['Z:\Christian-Sieben\data_HTP\2015-11-25_EGFR_A549\' base, num2str(i)];
% path=['Z:\Christian-Sieben\data_Olympus\151021_A549_aEGFR_SNA\TS Analysis\new grouped'];

filename_peaks=[base, num2str(i), '_MMStack_locResults'];
 
cd(path)

% [newCon,inCluster,MeanMol,ClusterDensity,MeanClusDis]=DBSCAN_analysis_TS(filename_peaks,0)

[newCon,inCluster,MeanMol,ClusterDensity,MeanClusDis,LocsPerArea,TotalLocs]=DBSCAN_analysis_HTP(filename_peaks,0);

cd('Z:\Christian-Sieben\data_HTP\2015-11-25_EGFR_A549\Cluster Analysis')

if  i==1;
    
    filename=['DBSCAN_delaunay_HK_' base '.txt'];
    dlmwrite(filename, newCon);

    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    ClusterParam(:,5)= LocsPerArea;
    ClusterParam(:,6)= TotalLocs;
    
    filename2=['ClusterParam_' base '.txt']
    dlmwrite(filename2, ClusterParam)
    
else
    
    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    ClusterParam(:,5)= LocsPerArea;
    ClusterParam(:,6)= TotalLocs;

    filename=['DBSCAN_delaunay_HK_' base '.txt']; 
    filename2=['ClusterParam_' base '.txt']
    
newConOld=dlmread(filename);
newConOld=cat(1,newConOld,newCon);
dlmwrite(filename, newConOld)

clusterParamOld=dlmread(filename2);
clusterParamOld=cat(1,clusterParamOld,ClusterParam);
dlmwrite(filename2, clusterParamOld)

end

end

fprintf('\n -- Finished Processing --\n')
