function secondDerivative(dataRootPath)
axis = ['fx'; 'fy'; 'fz'; 'mx'; 'my'; 'mz'];

cases = ls (dataRootPath);
   for i = 1:size(cases, 1)
        label = caseLabel(cases(i, :))
        approachSig = load(strcat(dataRootPath, '/', cases(i, :)));
        approachSig = approachSig.approachSig;
        firstDerivative = derivative (approachSig);
        secondDerivative = derivative (firstDerivative);
        filter = abs(secondDerivative(:, 2:end)) > (mean(secondDerivative + 1 * std(secondDerivative))(:, 2:end));
        [x, y] = find(filter);
        begin = secondDerivative(x(1), 1);
        features = extract_features(approachSig((approachSig(:,1) >= begin), :));
   end
end

function features = extract_features(contactSig)
    features = [max(contactSig) - min(contactSig), mean(contactSig)] % This gives [time_range, amplitude for six axes]
end

function derivativeMatrix = derivative(sigMatrix)
derivativeMatrix = sigMatrix(2:end-1, 1);
    for i = 2:size(sigMatrix, 2)
        tmpDerivative = [];
        for j = 1:size(sigMatrix, 1)
            if (j == 1)
                continue;
            end
            if (j == size(sigMatrix, 1))
                continue;
            end
            tmpDerivative = [tmpDerivative; ...
            (sigMatrix(j+1, i) - sigMatrix(j-1, i)) / (sigMatrix(j+1, 1) - sigMatrix(j-1, 1))];
        end
        derivativeMatrix = [derivativeMatrix, tmpDerivative];
    end
end

function label = caseLabel (caseName)

if strncmp(caseName, 'success', 7)
        label = 1;
    elseif strncmp(caseName, 'FC', 2)
        label = 2;
    elseif strncmp(caseName, 'prelim', 6)
        caseFlag = 0;
    elseif strncmp(caseName, 'exp', 3)
        caseFlag = 0;
    else
        caseFlag = 0;
    end
end

function caseFlag = ifCase (caseName)

global successPlot;
global failurePlot;
global prelimPlot;
global expPlot;

if strncmp(caseName, 'success', 7)
        caseFlag = 1;
    elseif strncmp(caseName, 'FC', 2)
        caseFlag = 1;
    elseif strncmp(caseName, 'prelim', 6)
        caseFlag = 1;
    elseif strncmp(caseName, 'exp', 3)
        caseFlag = 1;
    else
        caseFlag = 0;
    end
end
