clear all

load breastcancerdata_random.mat;

features = [9 22 24 29];                                % Features con correlazione alta

casiTotale  = size(datasetRandom,1);                    % Quanti soggeti?
numFeatures = length(features);                         % Quanti features abiamo? 
numClasses  = length(unique(datasetRandom(:,1)));       % Quanti classi abiamo?


% ========== DEEP LEARNING NETWORK ==========

options = trainingOptions('adam', ... 
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold', 1, ...
    'MaxEpochs', 1500, ...
    'MiniBatchSize', 400, ...
    'SequenceLength','longest', ...
    'Shuffle','every-epoch', ...
    'Verbose',0, ...
    'Plots','training-progress');

layers = [ ...
    featureInputLayer(numFeatures)

    fullyConnectedLayer(150)    
    reluLayer
    
    fullyConnectedLayer(numClasses)
    softmaxLayer

    classificationLayer];


Xtrain   = datasetRandom(1:400,features);       % Return features from the first 400 patients
Ytrain   = double(datasetRandom(1:400,1));      % Return first 400 patients

net = trainNetwork(Xtrain,categorical(Ytrain),layers,options);


% ========== DEEP LEARNING CLASSIFICATION ==========

remPatientsNet= zeros(1, casiTotale-400);

for k=1:(casiTotale-400)
    remPatientsNet(k) = double(string(classify(net,datasetRandom(400+k,features))));
end


% ===== CHECKING IF NETWORK ARCHITETURE IS WELL DONE =====

remPatientsData = logical(datasetRandom(401:end,1)).';

disp([newline '------------------------------'])
disp(['<strong>Accuracy</strong>'])
disp([ num2str(sum(~xor(remPatientsData,remPatientsNet))) ' su ' num2str((casiTotale-400)) '  |  ' num2str( 100*sum(~xor(remPatientsData,remPatientsNet))/(casiTotale-400)) '%'])

disp([newline '<strong>Specificity</strong>'])
disp([ num2str(sum(~remPatientsNet(~remPatientsData))) ' su ' num2str(sum(~remPatientsData)) '  |  ' num2str(100*sum(~remPatientsNet(~remPatientsData))/sum(~remPatientsData)) '%'])

disp([newline '<strong>Sensibility</strong>'])
disp([ num2str(sum(remPatientsNet(remPatientsData))) ' su ' num2str(sum(remPatientsData)) '    |  ' num2str(100*sum(remPatientsNet(remPatientsData))/sum(remPatientsData)) '%'])
disp(['------------------------------' newline])



