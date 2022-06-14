# Tescan SEM metadata scale
# Set Tescan SEM scale based on pixel size and display acquisition metadata
# Written by Zhou XU
# at Monash Centre for Electron Microscopy
# 2022/06/13
# Note: part of the tag unpacking code is adopted from the python tifffile library. 
#       Check out https://github.com/cgohlke/tifffile.git for more information

#  Copyright 2022 Zhou Xu
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, If not, see <http://www.gnu.org/licenses/>. 

import struct
from ij import IJ
from ij import macro
from ij.ImagePlus import getFileInfo
from ij.measure import Calibration

def stripnull(string,null=None,first=True):
    if null is None:
        if isinstance(string, bytes):
            null = b'\x00'
        else:
            null = '\0'
    if first:
        i = string.find(null)  # type: ignore
        return string if i < 0 else string[:i]
    null = null[0]  # type: ignore
    i = len(string)
    while i:
        i -= 1
        if string[i] != null:
            break
    else:
        i = -1
    return string[: i + 1]

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

DATA_FORMATS = {
    1: '1B',
    2: '1s',
    3: '1H',
    4: '1I',
    5: '2I',
    6: '1b',
    7: '1B',
    8: '1h',
    9: '1i',
    10: '2i',
    11: '1f',
    12: '1d',
    13: '1I',
    # 14: '',
    # 15: '',
    16: '1Q',
    17: '1q',
    18: '1Q',
    }

customtags = {}
maxifds = 2**32

unpack = struct.unpack

fh = open(id, 'rb')
fh.seek(0)

# try:
#     byteorder = {b'II': '<', b'MM': '>', b'EP': '<'}[header[:2]]
# #    print(byteorder)
# except KeyError:
#     print('not a TIFF file')
# version = struct.unpack(byteorder + 'H', header[2:4])[0]

version = 42
if version == 42:
    byteorder = '<'
    offsetsize = 4
    offsetformat = '<I'
    tagnosize = 2
    tagnoformat = '<H'
    tagsize = 12
    tagformat1 = '<HH'
    tagformat2 = '<I4s'
    tagoffsetthreshold = 4

header = fh.read(tagsize)
offset = fh.tell()

valueoffset = offset + tagsize - tagoffsetthreshold
code, dtype = struct.unpack(tagformat1, header[:4])
count, value = struct.unpack(tagformat2, header[4:])
tagno = unpack(tagnoformat, fh.read(tagnosize))[0]

data = fh.read(tagsize * tagno)
pos = fh.tell()
valueformat = DATA_FORMATS[2]
valuesize = count * struct.calcsize(valueformat)
valueoffset = struct.unpack(offsetformat, value)[0]
value = fh.read(valuesize)
value1 =stripnull(value, first=False).strip()
value1 = value1[value1.index(b"AccFrames"):].encode('utf-8')
stringlist = value1.split(u'\n')
metadata = [x.split(u'=') for x in stringlist]

#keys = ['AccFrames', 'AccType','Compnay', 'Date', 'Description', 'Device', 'FullUserName', 'ImageStripSize', 'Magnification', 'Note', 'PixelSizeX', 'PixelSizeY', 'SerialNumber', 'Sign', 'SoftwareVersion', 'TagRevision', 'Time', 'UserName', 'Version', 'ViewFieldsCountX', 'ViewFieldsCountY', 'AcceleratorVoltage', 'BeamCurrent', 'ChamberPressure', 'Detector', 'Detector0', 'Detector0Gain', 'Detector0Offset', 'DwellTime', 'EmissionCurrent', 'Gun', 'GunShiftX', 'GunShiftY', 'GunTiltX', 'GunTiltY', 'HV', 'IMLCenteringX', 'IMLCenteringY', 'ImageShiftX', 'ImageShiftY', 'LUTGamma', 'LUTMaximum', 'LUTMinimum', 'MTDScintillator', 'OBJCenteringX', 'OBJCenteringY', 'OBJPreCenteringX', 'OBJPreCenteringY', 'PotentialMode', 'PredictedBeamCurrent', 'PrimaryDetectorGain', 'PrimaryDetectorOffset', 'SampleVoltage', 'ScanMode', 'ScanRotation', 'ScanSpeed', 'SpecimenCurrent', 'SpotSize', 'StageRotation', 'StageTilt', 'StageX', 'StageY', 'StageZ', 'StigmatorX', 'StigmatorY', 'TiltCorrection', 'TubeVoltage', 'WD', '\x00m']
print(metadata)
keys = [None] *len(metadata)
values = [None] *len(metadata)
IJ.log(id)
for i in range(len(metadata)):
    try:
        keys[i] = metadata[i][0]
        values[i] = metadata[i][1]
        if "AcceleratorVoltage" in keys[i]:
            ind = keys[i].index("AcceleratorVoltage")
            keys[i] = keys[i][ind:]
        elif "3DBeamTiltX" in keys[i]:
            ind = keys[i].index("3DBeamTiltX")
            keys[i] = keys[i][ind:]
        elif (keys[i] == "PixelSizeX") or(keys[i] == "PixelSizeY") :
            values[i] = float(values[i])
        
        IJ.log(keys[i] + " = " + str(values[i]))
    except:
        values[i] = ''

metadata_dict = dict(zip(keys, values))

PixelSizeX = metadata_dict["PixelSizeX"]

PixelNumX = IJ.getImage().dimensions[0]
PixelNumY = IJ.getImage().dimensions[1]

HFW = PixelNumX * PixelSizeX
IJ.log("HFW" + " = " + str(HFW))
imp = IJ.getImage()
if HFW>0.000005:
    PixelSizeX = PixelSizeX*1e6
    kwargs = "unit=um pixel_width=" + str(PixelSizeX) +" pixel_height=" + str(PixelSizeX)+ " voxel_depth=1"
elif HFW>0.0005:
    PixelSizeX = PixelSizeX*1e3
    kwargs = "unit=mm pixel_width=" + str(PixelSizeX) +" pixel_height=" + str(PixelSizeX)+ " voxel_depth=1"
else:
    PixelSizeX = PixelSizeX*1e9
    kwargs = "unit=nm pixel_width=" + str(PixelSizeX) +" pixel_height=" + str(PixelSizeX)+ " voxel_depth=1"

IJ.run(imp, "Properties...", kwargs)
IJ.log("\n")
