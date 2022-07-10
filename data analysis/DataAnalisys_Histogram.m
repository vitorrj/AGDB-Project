clear all
close all


load breastcancerdata.mat;

n = size(dataset, 2);

for k=2:n
    
    figure
    histogram(dataset(:,k))
    title(strcat("Histogram of feature ", num2str(k)))

end