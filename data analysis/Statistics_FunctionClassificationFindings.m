clear all 
close all

load breastcancerdata.mat;

data       = dataset(:,:);
soloSani   = dataset(:,1) == 0;            % Indice dei sani: in quale posizione si trova ogni sogetto?
casiTotale = size(data,1);


% ========== FEATURES 22 e 24 ==========
    
[f1,f2] = plotFeatures(data, soloSani, 22, 24);

x1 = 16.39;
y1 = 111.6;
x2 = 16.57;
y2 = 110.3;

m  = (y2-y1)/(x2-x1)
q  = (y1 - m*x1)
x = 1:25;
y = m*x + q;

plot(x,y), legend('benign','malign', 'y=mx+q'), axis([5 40 50 300])

x = data(:,f1);
y = data(:,f2);
soloSaniIpotesi = (y < m*x + q);                    % Tutti sogetti sotto la funzione sono sani

displayResults(soloSani, soloSaniIpotesi, casiTotale, f1, f2)



% ========== FEATURES 24 e 29 ==========

[f1,f2] = plotFeatures(data, soloSani, 24, 29);

x1 = 89.9026;
y1 = 0.1815;
x2 = 131.6812;
y2 = 0.0863;

m  = (y2-y1)/(x2-x1)
q  = (y1 - m*x1)
x = 45:250;
y = m*x + q;
plot(x,y), legend('benign','malign', 'y=mx+q'), axis([50 300 0 0.3])

x = data(:,f1);
y = data(:,f2);
soloSaniIpotesi = (y < m*x + q);                    % Tutti sogetti sotto la funzione sono sani

displayResults(soloSani, soloSaniIpotesi, casiTotale, f1, f2)



% ========== FUNCTIONS DEFINITION ===========

function [f1, f2] = plotFeatures(D, S, f1, f2)
    figure
    plot(D(S,f1),  D(S,f2), 'ob'), grid, hold on       % Mostramu tutti sani      357x1
    plot(D(~S,f1), D(~S,f2), 'or'), hold on            % Mostrami tutti malati    212x1
    title("Features plot")
    legend('benign','malign')
    xlabel(strcat("Feature ", num2str(f1)))
    ylabel(strcat("Feature ", num2str(f2)))
end


function displayResults(S, SI, n, f1, f2)

    disp(['====== FEATURES ', num2str(f1),' e ', num2str(f2), ' ======'])

    disp('INTERA POPOLAZIONE')
    disp([num2str(sum(~xor(S,SI))) , ' su ', num2str(n), ' con un acuratezza di '])
    disp(100*sum(~xor(S,SI))/n)
    
    disp('SOLO SANI')
    disp([num2str(sum(SI(S))) , ' su ', num2str(sum(S(:,1))), ' con un sensitività di '])
    disp(100*sum(SI(S))/sum(S))

    disp('SOLO PATOLOGICI')
    disp([num2str(sum(~SI(~S))) , ' su ', num2str(n-sum(S(:,1))), ' con un sensibilità di '])
    disp(100*sum(~SI(~S))/sum(~S))

end







