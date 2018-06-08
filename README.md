# fMRI-Tools
Miscellaneous general scripts for fMRI stuff.

### renameDicomSeries
Takes as parameter the name of a directory containing sub-directories of DICOM files (each sub-directory representing the output of one series).
Reads the 'SeriesDescription' field from the metadata of the first file in each sub-directory, copies contents of each sub-directory into new directory with the name of the series, and outputs a master log file with information about each series found.

### mri_deface

#### CAUTION: de-facing using mri_deface is not clean, and may result in loss of brain data while maintaining identifiable face features.
#### Recommended to use Poldrack Lab's pydeface instead:
- [pydeface](https://github.com/poldracklab/pydeface)
- Install [FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation/Linux)
- Run `pip install nibabel nipype`
- Clone above-linked git repo, run following:
    - `cd pydeface`
    - `python setup.py install`
- Takes NIfTI files as input, writes out NIfTI's with "_defaced" appended to filename

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### mri_deface usage, for reference

Copy of FreeSurfer's [mri\_deface](https://surfer.nmr.mgh.harvard.edu/fswiki/mri_deface) tool for scan anonymization.
Usage:
- `mri_deface <input-file> <brain-template> <face_template> <output-file>`
- Input file can be `.mgz`, `.nii`, or `.dcm` - if DICOM, only specify the first file in the series and the program will discover the rest.
- Works with NIfTI as output format, brain and face templates (`talairach_mixed_with_skull.gca` and `face.gca`) from FreeSurfer wiki page (see link above)

