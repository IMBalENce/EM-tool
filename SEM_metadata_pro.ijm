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
// Shortcut to get full image metadata using Bio-Formats plugin
// Written by Zhou XU
// at Monash Centre for Electron Microscopy
//
// Pre-requisition of Bio-Formats library to import the chosen file's basic metadata to set the calibration.


path = getDirectory("image");
if (path=="") exit ("path not available");
name = getInfo("image.filename");
if (name=="") exit ("name not available");
id = path + name;

run("Bio-Formats Importer", "open=[id] autoscale color_mode=Default display_metadata rois_import=[ROI manager] view=[Metadata only] stack_order=Default");