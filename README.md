# fMRI-Tools
Miscellaneous general scripts for fMRI stuff.

### renameDicomSeries
Takes as parameter the name of a directory containing sub-directories of DICOM files (each sub-directory representing the output of one series).
Reads the 'SeriesDescription' field from the metadata of the first file in each sub-directory, copies contents of each sub-directory into new directory with the name of the series, and outputs a master log file with information about each series found.

