clear all
close all

load breastcancerdata.mat
data = dataset(:,:);

features   = (size(data ,2))
casiTotale = size(data,1)

% CORRELAZIONE FRA PAZIENTE E FEATURES

x  = data(:,1); 
xm = mean(x);
xs = sqrt(sum((x-xm).^2)/(casiTotale-1))

for k=2:features

    y  = data(:,k);
    ym = mean(y);
    ys = sqrt(sum((y-ym).^2)/(casiTotale-1));
    r  = sum((x-xm).*(y-ym))/((casiTotale-1)*xs*ys); % al variare delle features , ovvero di y ricavo la correlazione. Da qui devo osservare quale tra tutti i dati e' possibile prendere quello piu' correlto(exel)
    disp([k,r])

end