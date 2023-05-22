// Copyright 2018-2023 Zhou XU
//
// This file is part of ImageJ plugin EM-tool.
//
// EM-tool is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// EM-tool is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with EM-tool.  If not, see <http://www.gnu.org/licenses/>.
//
//
// Batch convert TIA or Gatan dm3 image file to tiff
// by Zhou XU
// 2020/05/05
// at Monash Centre for Electron Microscopy
// Windows 10 Enterprise Ver. 1803
// ImageJ ver. 1.52p

List.setCommands;
if (List.get("TIA Reader")!="") {
    // Check to make sure TIA reader plugin is installed
	//open directory of images
	input = getDirectory("location where images are stored");
	output = getDirectory("Location for results");

	// determine number of Files of given FileFormat
	list = getFileList(input);
	ImgNumber=0;
	for (i=0; i<list.length; i=i+1) {
		if (endsWith(list[i], ".ser")) {
			ImgNumber=ImgNumber+1;
			filename = input + list[i];
			print(filename);
			run("TIA Reader", ".ser-reader...=filename");
			
			// get the pixel size and unit of image, TIA reader should have set the scale when import in
			getPixelSize (unit, pixelWidth, pixelHeight);
			imageWidth = getWidth();
			HFW = imageWidth * pixelWidth;
			
			filename_short = substring(list[i], 0, lastIndexOf(list[i], "."));
			exportFile = output + filename_short +"_HFW"+ HFW + unit + ".tif";
			saveAs("Tiff", exportFile);
			run("Close All");
		}
		
		else if (endsWith(list[i], ".dm3")) {
			// for gatan dm3 files
			ImgNumber=ImgNumber+1;
			filename = input + list[i];
			print(filename);
			open(filename);
			
			// get the pixel size and unit of image, TIA reader should have set the scale when import in
			getPixelSize (unit, pixelWidth, pixelHeight);
			imageWidth = getWidth();
			HFW = imageWidth * pixelWidth;
			
			filename_short = substring(list[i], 0, lastIndexOf(list[i], "."));
			exportFile = output + filename_short +"_HFW"+ HFW + unit + ".tif";
			saveAs("Tiff", exportFile);
			run("Close All");
		}
	}
}

else {

	Dialog.create("Error");
	Dialog.addMessage("TIA Reader plugin is not intalled, \nplease download and install from \nhttps://imagej.nih.gov/ij/plugins/tia-reader.html \n ");
	//Dialog.addHelp("<html>https://imagej.nih.gov/ij/plugins/tia-reader.html"); 
	Dialog.show();

