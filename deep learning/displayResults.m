function displayResults (precisionMat, k, option)

    switch option
        case 'num'
            disp([newline 'Su ' num2str(k) ' iterazioni abbiamo ottenuto una'])
            
            disp(['  <strong>Accuracy</strong> di ' num2str(precisionMat(1,6)) '%'])
            disp(['  <strong>Specificity</strong> di ' num2str(precisionMat(2,6)) '%']) 
            disp(['  <strong>Sensibility</strong> di ' num2str(precisionMat(3,6)) '%'])

        case 'bar'
            figure
            nexttile
            bar(precisionMat(1,1:k)), title('Accuracy'), xlabel('k iterations'), ylabel('(%)') 
            nexttile
            bar(precisionMat(2,1:k)), title('Sensitivity'), xlabel('k iterations'), ylabel('(%)') 
            nexttile
            bar(precisionMat(3,1:k)), title('Sensibility'), xlabel('k iterations'), ylabel('(%)') 
    end
    
end
