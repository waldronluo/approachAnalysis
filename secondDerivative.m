function secondDerivative(dataRootPath)
    cases = ls (dataRootPath)
    for i = 1:size(cases, 1)
        approachSig = load(strcat(dataRootPath, '/', cases(i, :)));

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
