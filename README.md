# fMRI-Tools
Miscellaneous general scripts for fMRI stuff.

### renameDicomSeries
Takes as parameter the name of a directory containing sub-directories of DICOM files (each sub-directory representing the output of one series).
Reads the 'SeriesDescription' field from the metadata of the first file in each sub-directory, copies contents of each sub-directory into new directory with the name of the series, and outputs a master log file with information about each series found.

### mri_deface
Copy of FreeSurfer's [mri\_deface](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_deface) tool for scan anonymization.
Usage:
- `mri_deface <input-file> <brain-template> <face_template> <output-file>`
- Input file can be `.mgz`, `.nii`, or `.dcm` - if DICOM, only specify the first file in the series and the program will discover the rest.
- Works well with NIfTI as output format, brain and face templates (`talairach_mixed_with_skull.gca` and `face.gca`) from FreeSurfer wiki page (see link above)

