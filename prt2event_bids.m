% Create BIDS-compliant events file from PRT

% Austin Marcus, September 2018
% TarrLab @ Carnegie Mellon University

startdir = pwd;

% choose directory
basedir = uigetdir;
contents = dir(basedir);
cd(basedir)
prtFiles = dir('*.prt');
fmt = 0;
TR = 0;
while fmt ~= 1 && fmt ~= 2
    fmt = input('Please enter PRT format - 1 (vol) or 2 (msec): ');
    if fmt == 1
        TR = input('Please enter TR (in seconds): ');
    else
        fprintf('PRT format is msec\n');
    end
end

% loop over PRT files, convert to TSV event files
for i = 1:length(prtFiles)
    prt = xff(prtFiles(i).name);
    fprintf('Got PRT: %s\n', prtFiles(i).name);
    [pt, fname, ext] = fileparts(fullfile(basedir, prtFiles(i).name));
    eventTable = [];
    for c = 1:length(prt.Cond)
        for oo = 1:length(prt.Cond(c).OnOffsets)
            if strcmp(prt.ResolutionOfTime, 'Volumes')
                if fmt == 2
                    fprintf('Incorrect format entered. Using Volume resolution.\n');
                end
                eventTable = [eventTable; (prt.Cond(c).OnOffsets(oo,1)-1)*TR, prt.Cond(c).OnOffsets(oo,2)*TR, c];
            else
                if fmt == 1
                    fprintf('Incorrect format entered. Using msec resolution.\n');
                end
                eventTable = [eventTable; (prt.Cond(c).OnOffsets(oo,1)-1)/1000, prt.Cond(c).OnOffsets(oo,2)/1000, c];
            end
        end
    end
    eventTable = sortrows(eventTable);
    % loop over table to replace end times with duration
    for r = 1:length(eventTable)
       eventTable(r,2) = eventTable(r,2) - eventTable(r,1); 
    end
    % initialize tsv
    outfile = [fname '_events.tsv'];
    fout = fopen(outfile, 'w');
    fprintf(fout, 'onset\tduration\tcondition\n');
    % print event times to tsv
    for r = 1:length(eventTable)
        fprintf(fout, '%.2f\t%.2f\t%d\n', eventTable(r,1), eventTable(r,2), eventTable(r,3));
    end
    fclose(fout);
end

cd(startdir);