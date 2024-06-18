// Set JEOL SEM scale from acquisition metadata .txt file
// Author: Zhou XU
// at Monash Centre for Electron Microscopy
// Windows 10 Enterprise Ver. 1803
// ImageJ ver. 1.52g

// Copyright 2019 Zhou Xu
/* This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program; if not, If not, see <http://www.gnu.org/licenses/>. */

// Created on 2018 Sep 07
// Modified on 2018 Oct 01

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
	

barPixel = split(lines[idBarPixel], cellseparator);
barLength = split(lines[idBarLength], cellseparator); 

barPixel = barPixel[1];
barLength = barLength[1];


if (endsWith(barLength, "deg."))
{
barLengthNum = substring(barLength, 0 ,lengthOf(barLength)-4);
barLengthUnit= "deg";
mode = "ECP";
}
else
{
barLengthNum = substring(barLength, 0 ,lengthOf(barLength)-2);
barLengthUnit= substring(barLength, lengthOf(barLength)-2);
mode = "Imaging";
}

pixelSize = parseFloat(barLengthNum)/parseFloat(barPixel);

setVoxelSize(pixelSize, pixelSize, 1, barLengthUnit);