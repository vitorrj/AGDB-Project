clear all
close all
% delete(findall(0));

load breastcancerdata_random.mat;

numTrainedSubjects = 450;
features = [9 22 24 29];                                  % Scelgo features con correlazione alta

numFeatures = length(features);                           % Quanti features abiamo scelto? 
numClasses  = length(unique(datasetRandom(:,1)));         % Quanti classi abiamo? "B" o "M"
casiTotale  = size(datasetRandom, 1);                     % Quanti soggeti?



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


Xtrain   = datasetRandom(1:numTrainedSubjects, features);       % Return features from the first 400 patients
Ytrain   = double(datasetRandom(1:numTrainedSubjects, 1));             % Return first 400 patients



% ========== TRAINING AND COMPARISON ==========

remPatientsData = logical(datasetRandom(numTrainedSubjects+1:end,1)).';
remPatientsNet  = zeros(1, casiTotale-numTrainedSubjects);

precisionMat    = zeros(3,6);                          % Contains accuracy, sensitivity and sensibility for each iteration


for k=1:5

    net = trainNetwork(Xtrain,categorical(Ytrain),layers,options);
 
    for j=1:(casiTotale-numTrainedSubjects)
        remPatientsNet(j) = double(string(classify(net,datasetRandom(numTrainedSubjects+j,features))));
    end
          
    precisionMat(1,k) = 100*sum(~xor(remPatientsData,remPatientsNet))/(casiTotale-numTrainedSubjects)  % Accuracy
    precisionMat(2,k) = 100*sum(~remPatientsNet(~remPatientsData))/sum(~remPatientsData)                       % Sensitivity
    precisionMat(3,k) = 100*sum(remPatientsNet(remPatientsData))/sum(remPatientsData)                          % Sensibility

end

for j=1:3
    precisionMat(j,6) = mean(precisionMat(j,1:k))
end

displayResults(precisionMat, k, 'num')
displayResults(precisionMat, k, 'bar')


