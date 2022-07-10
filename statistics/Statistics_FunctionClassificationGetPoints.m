clear all 
close all

load breastcancerdata.mat;

data       = dataset(:,:);
soloSani   = dataset(:,1) == 0;            % Indice dei sani: in quale posizione si trova ogni sogetto?
casiTotale = size(data,1);

% ========== CLASSIFICATION ==========

[f1, f2] = plotFeatures(data, soloSani, 4, 9);


zoom on;
pause()          % you can zoom with your mouse and when your image is okay, you press any key
zoom off;        % to escape the zoom mode

[x1, y1] = ginput(1)
[x2, y2] = ginput(1)


 
m  = (y2-y1)/(x2-x1);
q  = (y1 - m*x1);   
x = 40:300;
y = m*x + q;
plot(x,y)
 
x = data(:,f1);
y = data(:,f2);
saniIpotesi = (y < m*x + q);                    % Tutti sogetti sotto la funzione sono sani
 
displayResults(soloSani, saniIpotesi, casiTotale)



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


function displayResults(S, SI, n)

    disp('===== INTERA POPOLAZIONE =====')
    disp([num2str(sum(~xor(S,SI))) , ' su ', num2str(n), ' con acuratezza di '])
    disp(100*sum(~xor(S,SI))/n)
    
    disp('=======    SOLO SANI    ======')
    disp([num2str(sum(SI(S))) , ' su ', num2str(sum(S(:,1))), ' con una sensitività di '])
    disp(100*sum(SI(S))/sum(S))

    disp('======= SOLO PATOLOGICI ======')
    disp([num2str(sum(~SI(~S))) , ' su ', num2str(n-sum(S(:,1))), ' con una sensibilità di '])
    disp(100*sum(~SI(~S))/sum(~S))

   
end







