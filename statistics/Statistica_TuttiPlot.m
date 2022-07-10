clear all 
close all

load breastcancerdata.mat;
data = dataset(:,:);

casiTotale = size(data,1)                  
features   = size(data,2)                 
numMalati  = sum(data(:,1))                
numSani    = (casiTotale-numMalati)                    

soloSani = data(:,1) == 0;


for k=2:features
	figure 
	plot(0, data(soloSani,k) , 'ob'), grid, axis([-0.5 1.5 0 inf]), hold on
    plot(1, data(~soloSani,k), 'or'), hold off

    title("Plot between features and disease")
    xlabel('Disease stage')
    ylabel(strcat("Feature ", num2str(k)))
end




