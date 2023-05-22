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
// FEI SEM databar cut tool
// Written by Zhou XU
// at Monash Centre for Electron Microscopy
// Windows 10 Enterprise Ver. 1803
// ImageJ ver. 1.52g

// Created on 23/05/2019
// Modified on 24/05/2019

// get the directory and name of current image
path = getDirectory("image");
if (path=="") exit ("path not available");
name = getInfo("image.filename");
if (name=="") exit ("name not available");
id = path + name;
name_short = substring(name, 0, lastIndexOf(name, "."));

// get the dimension and image type of original image
width = getWidth();
height = getHeight();
type = bitDepth(); 

if (type <= 16) 
	baseVal = 0;
else 
	baseVal = 4;


// get the databar height of original image
makeRectangle(2, 0, 1, height);
run("Clear Results");
setKeyDown("alt");
profile = getProfile();
count = 0;
occurrance = 0;

for (i=1; i<(profile.length-1) && i <250; i++)
{
index = height-1-i;

// avoid counting other false events
if (profile[index] > profile[index-1])
{
	occurrance++;
}
// count the number of zero intensity pixels at the bottom of the image frame
if ( (profile[index] == baseVal ) && (profile[index] <=profile[index-1]) && (occurrance == 0))
{
intensity = profile[index];
count++;
}
}
databar_h = count + 2;

// defines the image crop area
width_crop = width;
height_crop = height - databar_h;

// make rectangle crop and save image
selectWindow(name);
getPixelSize(unit, pw, ph, pd);
makeRectangle(0, 0, width, height);
makeRectangle(0, 0, width_crop, height_crop);
run("Copy"); 
newImage("Untitled", type, width_crop, height_crop, 1); 
run("Paste"); 
rename(name_short + "_crop.tif");
setVoxelSize(pw, ph, pd, unit);
// save image
fileName = name_short + "_crop.tif";
newPath = path + fileName;
selectWindow(name_short + "_crop.tif");
saveAs("Tiff", newPath); 
close(); 

// make rectangle crop and save databar
selectWindow(name);
makeRectangle(0, height_crop, width, height);
run("Copy"); 
newImage("Untitled", type, width_crop, height-height_crop, 1); 
run("Paste"); 
rename(name_short + "_databar.tif");
// save databar
fileName2 = name_short + "_databar.tif";
newPath2 = path + fileName2;
selectWindow(name_short + "_databar.tif");
saveAs("Tiff", newPath2); 
close(); 

