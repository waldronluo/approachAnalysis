
function cutApproach(rootPath)
    global successPlot;
    global failurePlot;
    global prelimPlot;
    global expPlot;

    successPlot = 1;
    failurePlot = 1;
    prelimPlot = 1;
    expPlot = 1;

    MaxSize = 25;

%    addpath ('./svm');
%    addpath ('./load');
    
    axis = ['fx'; 'fy'; 'fz'; 'mx'; 'my'; 'mz'];
    cases = ls (rootPath);
    j = 0;
    for i = 1:size(cases, 1)
        if ( ifPlot(cases(i,:)) )
            ++ j;
        end
    end

    for i = 1:size(cases,1)
        if (ifPlot(cases(i,:)))
            h = figure(i);
            set (h, 'name', cases(i,:))
            forceSig = load (strcat (rootPath, '/', cases(i,:), '/', 'Torques.dat'));
            state = load (strcat (rootPath, '/', cases(i,:), '/', 'State.dat'));
            approachSig = forceSig (forceSig(:,1) < state(2), :);
            for j = 1:6
               subplot(3, 2, j);
               plot(approachSig(:, 1), approachSig(:, j+1))
               title(axis(j, :))
            end
            filename = strcat(cases(i, :), '.jpg')
            print (h, strcat('img/', cases(i,:), '.jpg'), '-djpg')
            save (strcat('data/', cases(i,:), '.dat'), 'approachSig')
            close all
        end
    end
end

function plotFlag = ifPlot (caseName)

    global successPlot;
    global failurePlot;
    global prelimPlot;
    global expPlot;

    if (strncmp(caseName, 'success', 7) && successPlot == 1)
        plotFlag = 1;
    elseif (strncmp(caseName, 'FC', 2) && failurePlot == 1)
        plotFlag = 1;
    elseif (strncmp(caseName, 'prelim', 6) && prelimPlot == 1)
        plotFlag = 1;
    elseif (strncmp(caseName, 'exp', 3) && expPlot == 1)
        plotFlag = 1;
    else
        plotFlag = 0;
    end
end
