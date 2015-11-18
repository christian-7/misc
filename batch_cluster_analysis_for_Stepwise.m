

base='MDCK_EGFR_Y38_NA_Co_800mW_10ms_'; % select the base name of the folder

for i=1:6; %[1 2 4 6 7 8 9]

path=['Z:\Christian-Sieben\data_HTP\2015-08-21_EGFR_Y38_NA_A549_MDCK\' base, num2str(i)];
filenameLoad=[base, num2str(i) '_MMStack_locResults']
 
cd(path)


% [newCon,inCluster,MeanMol,ClusterDensity,MeanClusDis]=DBSCAN_analysis_HTP(filenameLoad,0);

[structure, structure2, structure3,inCluster,MeanMol,ClusterDensity,MeanClusDis]=Stepwise_DBSCAN_for_HTP(0,filenameLoad) 

cd('Z:\Christian-Sieben\data_HTP\2015-08-21_EGFR_Y38_NA_A549_MDCK')

if  i==1;

    filename=['Step_DBSCAN_' base]
    
    save(filename,'structure')
    save(filename,'structure2','-append')
    save(filename,'structure3','-append')


    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    
    filename2=['ClusterParam_' base '.txt']
    dlmwrite(filename2, ClusterParam)
    
else
    
    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    
    oldStructure=load(['Step_DBSCAN_' base '.mat'])
   
    new1=[oldStructure.structure structure];
    new2=[oldStructure.structure2 structure2];
    new3=[oldStructure.structure3 structure3];
    
    structure=new1;
    structure2=new2;
    structure3=new3;
    
    
    filename=['Step_DBSCAN_' base]
    save(filename,'structure')
    save(filename,'structure2','-append')
    save(filename,'structure3','-append')
    
    
    filename2=['ClusterParam_' base '.txt']
    clusterParamOld=dlmread(filename2);
    clusterParamOld=cat(1,clusterParamOld,ClusterParam);
    dlmwrite(filename2, clusterParamOld)

end

end

base='MDCK_EGFR_Y38_NA_EGF_800mW_10ms_'; % select the base name of the folder

for i=1:7; %[1 2 4 6 7 8 9]

path=['Z:\Christian-Sieben\data_HTP\2015-08-21_EGFR_Y38_NA_A549_MDCK\' base, num2str(i)];
filenameLoad=[base, num2str(i) '_MMStack_locResults']
 
cd(path)


% [newCon,inCluster,MeanMol,ClusterDensity,MeanClusDis]=DBSCAN_analysis_HTP(filenameLoad,0);

[structure, structure2, structure3,inCluster,MeanMol,ClusterDensity,MeanClusDis]=Stepwise_DBSCAN_for_HTP(0,filenameLoad) 

cd('Z:\Christian-Sieben\data_HTP\2015-08-21_EGFR_Y38_NA_A549_MDCK')

if  i==1;

    filename=['Step_DBSCAN_' base]
    
    save(filename,'structure')
    save(filename,'structure2','-append')
    save(filename,'structure3','-append')


    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    
    filename2=['ClusterParam_' base '.txt']
    dlmwrite(filename2, ClusterParam)
    
else
    
    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    
    oldStructure=load(['Step_DBSCAN_' base '.mat'])
   
    new1=[oldStructure.structure structure];
    new2=[oldStructure.structure2 structure2];
    new3=[oldStructure.structure3 structure3];
    
    structure=new1;
    structure2=new2;
    structure3=new3;
    
    
    filename=['Step_DBSCAN_' base]
    save(filename,'structure')
    save(filename,'structure2','-append')
    save(filename,'structure3','-append')
    
    
    filename2=['ClusterParam_' base '.txt']
    clusterParamOld=dlmread(filename2);
    clusterParamOld=cat(1,clusterParamOld,ClusterParam);
    dlmwrite(filename2, clusterParamOld)

end

end

base='MDCK_EGFR_Y38_NA_IAV_800mW_10ms_'; % select the base name of the folder

for i=1:7; %[1 2 4 6 7 8 9]

path=['Z:\Christian-Sieben\data_HTP\2015-08-21_EGFR_Y38_NA_A549_MDCK\' base, num2str(i)];
filenameLoad=[base, num2str(i) '_MMStack_locResults']
 
cd(path)


% [newCon,inCluster,MeanMol,ClusterDensity,MeanClusDis]=DBSCAN_analysis_HTP(filenameLoad,0);

[structure, structure2, structure3,inCluster,MeanMol,ClusterDensity,MeanClusDis]=Stepwise_DBSCAN_for_HTP(0,filenameLoad) 

cd('Z:\Christian-Sieben\data_HTP\2015-08-21_EGFR_Y38_NA_A549_MDCK')

if  i==1;

    filename=['Step_DBSCAN_' base]
    
    save(filename,'structure')
    save(filename,'structure2','-append')
    save(filename,'structure3','-append')


    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    
    filename2=['ClusterParam_' base '.txt']
    dlmwrite(filename2, ClusterParam)
    
else
    
    ClusterParam=[];
    ClusterParam(:,1)=inCluster;
    ClusterParam(:,2)=MeanMol;
    ClusterParam(:,3)=ClusterDensity;
    ClusterParam(:,4)=MeanClusDis.mu;
    
    oldStructure=load(['Step_DBSCAN_' base '.mat'])
   
    new1=[oldStructure.structure structure];
    new2=[oldStructure.structure2 structure2];
    new3=[oldStructure.structure3 structure3];
    
    structure=new1;
    structure2=new2;
    structure3=new3;
    
    
    filename=['Step_DBSCAN_' base]
    save(filename,'structure')
    save(filename,'structure2','-append')
    save(filename,'structure3','-append')
    
    
    filename2=['ClusterParam_' base '.txt']
    clusterParamOld=dlmread(filename2);
    clusterParamOld=cat(1,clusterParamOld,ClusterParam);
    dlmwrite(filename2, clusterParamOld)

end

end


fprintf('\n --  Analysis finished  --\n')