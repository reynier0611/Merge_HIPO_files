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
	fileList="$fileList $line"
done < "$1"
# ===========================================================================================
# Get the output file name
outfile=$2
echo "----------------------------------"
echo "Output file name: " $outfile
# ===========================================================================================
./bin/hipoutils.sh -filter -e 330:331:332:335 -l 330:331:332:335:22121:22111:22112 -o $outfile $fileList
