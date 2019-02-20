#!/bin/bash
echo "----------------------------------"
echo "Shell script to merge hipo files"
echo "By: F.Hauenstein  (fhauenst@odu.edu)"
echo "    E.Segarra     (segarrae@mit.edu)"
echo "    R.Cruz-Torres (reynier@mit.edu )"
echo "----------------------------------"
# ===========================================================================================
# Check that an input list and output file are provided
if [ $# -ne 2 ]
then
	echo "Wrong number of arguments provided."
	echo "Please, run this script the following way:"
	echo "./combine_files.sh path/to/input/list path/to/output/file"
	echo "where: path/to/input/list is a file with the list of all files to be merged."
	echo "       path/to/output/file will be the output merged hipo file."
	echo "Bailing out!"
	exit 1
fi
# ===========================================================================================
# Get the input file and check that it exists
infile=$1
if [ -e $infile ]
then
	echo "Will be getting input from: " $infile
else
	echo "Input file provided: " $infile " does not exist"
	echo "Bailing out!"
	exit 1
fi
# ===========================================================================================
# Output information to user
echo "Banks we will require for each"
echo "event to have:"
echo "  330 REC::Event"
echo "  331 REC::Particle"
echo "  332 REC::Calorimeter"
echo "  335 REC::Scintillator"
echo "----------------------------------"
echo "Banks we will be keeping in"
echo "the merged output hipo file:"
echo "  330 REC::Event"
echo "  331 REC::Particle"
echo "  332 REC::Calorimeter"
echo "  335 REC::Scintillator"
echo "22121 BAND::hits"
echo "22111 BAND::adc"
echo "22112 BAND::tdc"
echo "----------------------------------"

echo "Files that will be merged:"
while IFS='' read -r line || [[ -n "$line" ]]; do
	echo $line
	if [ -f $line ]
	then
		fileList="$fileList $line"
	else
		echo "*** WARNING *** File: " $line " cannot be found"
		echo "Bailing out!"
		exit 1
	fi
done < "$1"
# ===========================================================================================
# Get the output file name
outfile=$2
echo "----------------------------------"
echo "Output file name: " $outfile
# ===========================================================================================
./bin/hipoutils.sh -filter -e 330:331:332:335 -l 330:331:332:335:22121:22111:22112 -o $outfile $fileList

#./bin/hipoutils.sh -filter -e 331 -l 331:330 -o myFilteredFile.hipo /lustre/expphy/volatile/clas12/hauenst/6164_round3_hipos/out_clas_006164.evio.00009.hipo /lustre/expphy/volatile/clas12/hauenst/6164_round3_hipos/out_clas_006164.evio.00010.hipo /lustre/expphy/volatile/clas12/hauenst/6164_round3_hipos/out_clas_006164.evio.00011.hipo
#./bin/hipoutils.sh -filter -e 331 -l 331:330 -o myFilteredFile.hipo /lustre/expphy/volatile/clas12/hauenst/6164_round3_hipos/out_clas_006164.evio.0000*.hipo
