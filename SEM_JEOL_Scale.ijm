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
// Set JEOL SEM scale from acquisition metadata .txt file
// Author: Zhou XU
// at Monash Centre for Electron Microscopy
// Windows 10 Enterprise Ver. 1803
// ImageJ ver. 1.52g

path = getDirectory("image");
if (path=="") exit ("path not available");
name = getInfo("image.filename");
if (name=="") exit ("name not available");
id = path + name;
txtID = replace(id, ".tif", ".txt");
txtID = replace(txtID, ".jpg", ".txt");

lineseparator = ",\n\t";
cellseparator = " ";

lines=split(File.openAsString(txtID), lineseparator);

for (i=0; i<lengthOf(lines); i++) 
{
	items=split(lines[i], cellseparator);
	for (j=1; j<lengthOf(items); j++)
if (items[0]=="$$SM_MICRON_BAR" || items[0]=="$SM_MICRON_BAR") idBarPixel = i;
if (items[0]=="$$SM_MICRON_MARKER" || items[0]=="$SM_MICRON_MARKER") idBarLength = i;
	}
	
scale_bar_pixel_number_array = split(lines[idBarPixel], cellseparator);
scale_bar_actual_length_array = split(lines[idBarLength], cellseparator); 

scale_bar_pixel_number_string = scale_bar_pixel_number_array[1];
scale_bar_actual_length_string = scale_bar_actual_length_array[1];

// for ECP mode, the bar length is in degree
if (endsWith(scale_bar_actual_length_string, "deg."))
{
barLengthNum = substring(scale_bar_actual_length_string, 0 ,lengthOf(scale_bar_actual_length_string)-4);
barLengthUnit= "deg";
mode = "ECP";
}
// The greek letter (mu) in the micron unit is a non-ASCII character, 
// which is tricky to read by the ImageJ macro language. "Î¼m" is the "um" symbol
// after read in ImageJ.
if (endsWith(scale_bar_actual_length_string, "Î¼m"))
{
barLengthNum = substring(scale_bar_actual_length_string, 0 ,lengthOf(scale_bar_actual_length_string)-3);
barLengthUnit= "μm";
mode = "Imaging";
}
else
{
barLengthNum = substring(scale_bar_actual_length_string, 0 ,lengthOf(scale_bar_actual_length_string)-2);
barLengthUnit= substring(scale_bar_actual_length_string, lengthOf(scale_bar_actual_length_string)-2);
mode = "Imaging";
}

pixelSize = parseFloat(barLengthNum)/parseFloat(scale_bar_pixel_number_string);

setVoxelSize(pixelSize, pixelSize, 1, barLengthUnit);