% Create BIDS-compliant events file from PRT

% Austin Marcus, September 2018
% TarrLab @ Carnegie Mellon University

startdir = pwd;

% choose directory
basedir = uigetdir;
contents = dir(basedir);
cd(basedir)
prtFiles = dir('*.prt');
TR = input('Please enter TR length (in seconds): ');

% loop over PRT files, convert to TSV event files
for i = 1:length(prtFiles)
    prt = xff(prtFiles(i).name);
    fprintf('Got PRT: %s\n', prtFiles(i).name);
    [pt, fname, ext] = fileparts(fullfile(basedir, prtFiles(i).name));
    eventTable = [];
    for c = 1:length(prt.Cond)
        for oo = 1:length(prt.Cond(c).OnOffsets)
            eventTable = [eventTable; (prt.Cond(c).OnOffsets(oo,1)-1)*TR, prt.Cond(c).OnOffsets(oo,2)*TR, c];
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