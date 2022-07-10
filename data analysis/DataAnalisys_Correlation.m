clear all 
close all

load breastcancerdata.mat;
data = dataset(:,:);

features   = size(data,2)                 % Quanti features? 30
casiTotale = size(data,1)                 % Quanti soggeti? 569


x  = data(:,1);                             
xm = mean(x);
xs = sqrt(sum((x-xm).^2)/(casiTotale-1));               % X Standard deviation

for k=2:features
    y = data(:,k);
    ym = mean(y);
    ys = sqrt(sum((y-ym).^2)/(casiTotale-1));           % Y standard deviation
    
    r = sum((x-xm).*(y-ym))/((casiTotale-1)*xs*ys);     % Coefficiente di correlazione
    disp([k r])
end

