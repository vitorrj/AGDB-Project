 clear all
close all

load breastcancerdata.mat
data=dataset(:,:);


features   = (size(data ,2));
casiTotale = size(data,1);
numMalati  = sum(data(:,1));
numSani    = (casiTotale-numMalati);


% CLASSIFICAZIONE A SOGLIA

featureScelta = 22;

soloSani   = data(:,1) == 0;
soloMalati = data(:,1) == 1;

ymin=round(min(data(soloMalati,featureScelta)));
ymax = round(max(data(soloSani,featureScelta)));              

figure
plot(0, data(soloSani,featureScelta)  ,'ob'), grid, hold on %ho disegnato tutti i sani blu
plot(1, data(~soloSani,featureScelta),'or'), grid, axis([-0.5 1.5 0 inf]) %malati rossi

yline([ymin ymax], 'm', {'Min', 'Max'})

title(['Rappresentazione sani e malati feature ' num2str(featureScelta)]),xlabel('malati             sani'), ylabel('valori assegnati dalla features'),grid

% DETECTION 
minSoglia = ymin;
maxSoglia = ymax;

M = zeros(maxSoglia-minSoglia, 5);
i = 1;


for soglia=minSoglia:maxSoglia
 
 soloSaniIpotesi   = data(:,featureScelta) < soglia;
 M(i,1) = soglia;
 M(i,2) = 100*(sum(~xor(soloSani,soloSaniIpotesi)/casiTotale));
 M(i,3) = 100*sum(soloSaniIpotesi(soloSani))/numSani;
 M(i,4) = 100*sum(~soloSaniIpotesi(soloMalati))/numMalati;
 M(i,5) = 100-100*sum(soloSaniIpotesi(soloSani))/numSani;

 i = i+1;

end


% DISPLAY RESULTS

M(:,:)

soglia = 17;

soloSaniIpotesi   = data(:,featureScelta) < soglia;
disp('Accuratezza')
disp(sum(~xor(soloSani,soloSaniIpotesi))) 
disp(100*(sum(~xor(soloSani,soloSaniIpotesi)/casiTotale)))
disp('Specificità')
disp(sum(soloSaniIpotesi(soloSani)))      
disp(100*sum(soloSaniIpotesi(soloSani))/numSani)

disp ('Sensibilità')
disp(sum(~soloSaniIpotesi(soloMalati)))
disp(100*sum(~soloSaniIpotesi(soloMalati))/numMalati)
disp('Errore')
disp(100-100*sum(soloSaniIpotesi(soloSani))/numSani)



















