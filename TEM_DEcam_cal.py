# Copyright 2018-2023 Zhou XU
#
# This file is part of ImageJ plugin EM-tool.
#
# EM-tool is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# EM-tool is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with EM-tool.  If not, see <http:#www.gnu.org/licenses/>.
#
#
# DEcam calibration scale
# Written by Zhou XU
# at Monash Centre for Electron Microscopy
# 2022/10/12

import struct
from ij import IJ
from ij import macro
from ij.ImagePlus import getFileInfo
from ij.measure import Calibration

path = IJ.getDirectory("image")
if path=="":
    IJ.exit ("path not available")
else:
    name = IJ.getImage().title
#    print(name)

if name=="":
    IJ.exit ("name not available")
else:
    id = path + name

fname_parts= name.split('_')
info_UID = fname_parts[0] + '_' + fname_parts[1] + '_info.txt'
print(info_UID)

info_id = path + info_UID

with open(info_id,'r') as f:
    contents = f.readlines()

clean = [item.replace('\n', '') for item in contents]
dict = {item.split('= ')[0].strip():item.split('= ')[1] for item in clean}
inst_metadata = dict['Instrument Metadata'].split(';')
inst_metadata_dict = {item.split('=')[0].strip():item.split('=')[1] for item in inst_metadata}

print(inst_metadata_dict)

magnification = inst_metadata_dict['PROJ_Magnification']

magcal = {
    '2550': '1.704',
    '4000': '1.107',
    '5000': '0.88',
    '7000': '0.631',
    '9900': '0.439',
    '15000': '0.297',
    '19500': '0.230',
    '29000': '0.154',
    '38000': '0.11',
    '43000': '0.097',
    '71000': '0.059',
    '97000': '0.043',
    '145000': '0.028',
    '195000': '0.021',
    '285000': '0.014',
    '400000': '0.011',
    '450000': '0.0094',
    '490000': '0.0084',
    '590000': '0.0072',
    '690000': '0.0063',
    '790000': '0.0055',
    '880000': '0.0048',
    '1050000': '0.0042'}

scalebar_length = {
    '2550': 1000,
    '4000': 1000,
    '5000': 500,
    '7000': 500,
    '9900': 500,
    '15000': 500,
    '19500': 200,
    '29000': 200,
    '38000': 100,
    '43000': 100,
    '71000': 50,
    '97000': 20,
    '145000': 20,
    '195000': 20,
    '285000': 10,
    '400000': 10,
    '450000': 10,
    '490000': 5,
    '590000': 5,
    '690000': 5,
    '790000': 5,
    '880000': 2,
    '1050000': 2}

PixelSizeX =  magcal[magnification]# in nm/pixel
print(PixelSizeX)

PixelNumX = IJ.getImage().dimensions[0]
PixelNumY = IJ.getImage().dimensions[1]

imp = IJ.getImage()

PixelSizeX = float(PixelSizeX)

kwargs = "unit=nm pixel_width=" + str(PixelSizeX) +" pixel_height=" + str(PixelSizeX)+ " voxel_depth=1"
IJ.run(imp, "Properties...", kwargs)

kwargs2 = "width=" + str(PixelNumX) +" height=" + str(PixelNumY+200) + " position=Top-Center"
IJ.run(imp, "Canvas Size...", kwargs2)

kwargs3 = "width=" + str(scalebar_length[magnification]) +" height=50 thickness_in_pixels=30 font=0 location=[Lower Right]"
IJ.run(imp, "Scale Bar...", kwargs3)

kwargs4 = name.replace('.tif', '_scalebar'+str(scalebar_length[magnification])+'nm.tif')
print(kwargs4)
IJ.run(imp, "Rename...", 'title='+kwargs4)

# IJ.log("\n")
