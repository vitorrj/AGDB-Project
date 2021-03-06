clear all
close all
%delete(findall(0));

load breastcancerdata_random.mat;

features = [9 22 24 29];                             % Scelgo features con correlazione alta all'inizio

numFeatures = length(features);                      % Quanti features abbiamo scelto? 
numClasses  = length(unique(datasetRandom(:,1)));    % Quanti classi? "B" o "M"
casiTotale  = size(datasetRandom, 1);                % Quanti soggeti? 569



% ========== DEEP LEARNING NETWORK ==========

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold', 1, ...
    'MaxEpochs', 1500, ...
    'MiniBatchSize', 400, ...
    'SequenceLength','longest', ...
    'Shuffle','every-epoch', ...
    'Verbose', 0, ...
    'Plots','training-progress');

layers = [ ...
    featureInputLayer(numFeatures)

    fullyConnectedLayer(100)
    reluLayer

    fullyConnectedLayer(numClasses)
    softmaxLayer

    classificationLayer];


Xtrain = datasetRandom(1:400,features);              % Fornisco alla rete i valori dei features dei primi 400 pazienti
Ytrain = double(datasetRandom(1:400,1));             % Fornisco i primi 400 pazienti alla rette con le malatie



% ========== TRAINING AND COMPARISON ==========

remPatientsData = logical(datasetRandom(401:end,1)).';
remPatientsNet  = zeros(1, casiTotale-400);

precisionMat = zeros(3,6);                             % Matrice che contiene accuratezza, sensibilit√† e sensibilit√† per ogni iterazione

for k=1:5

    net = trainNetwork(Xtrain,categorical(Ytrain),layers,options);
 
    for j=1:(casiTotale-400)
        remPatientsNet(j) = double(string(classify(net,datasetRandom(400+j,features))));
    end
          
    precisionMat(1,k) = 100*sum(~xor(remPatientsData,remPatientsNet))/(casiTotale-400);    % Accuracy
    precisionMat(2,k) = 100*sum(~remPatientsNet(~remPatientsData))/sum(~remPatientsData);  % Sensitivity
    precisionMat(3,k) = 100*sum(remPatientsNet(remPatientsData))/sum(remPatientsData);     % Sensibility

end  

for j=1:3
    precisionMat(j,6) = mean(precisionMat(j,1:k))
end

displayResults(precisionMat, k, 'num')
displayResults(precisionMat, k, 'bar')


