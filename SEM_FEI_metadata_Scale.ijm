// Set FEI SEM(FIB) scale and display acquisition metadata using Tiff tags Metadata
// Written by Zhou XU
// at Monash Centre for Electron Microscopy
// Windows 10 Enterprise Ver. 1803
// ImageJ ver. 1.52g

// Copyright 2019 Zhou Xu
/* This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with this program; if not, If not, see <http://www.gnu.org/licenses/>. */

// Created on 2018 Aug 30
// Modified on 2018 Oct 01

// Pre-requisition of Bio-Formats library to import the chosen file's basic metadata to set the calibration.

run("Bio-Formats Macro Extensions");
path = getDirectory("image");
if (path=="") exit ("path not available");
name = getInfo("image.filename");
if (name=="") exit ("name not available");
id = path + name;

Ext.setId(id);
Ext.getSeriesCount(seriesCount);

// Determine which beam source is used, can be further expanded to accommondate ion beam images
Ext.getMetadataValue("[System] SystemType", SystemType);
Ext.getMetadataValue("[Beam] Beam", BeamType);
Ext.getMetadataValue("[Vacuum] ChPressure", ChPressure);

// if the image is acquired by electron beam, then
if (BeamType == "EBeam") {

Ext.getMetadataValue("[EScan] PixelWidth", value1);
Ext.getMetadataValue("[Beam] HV", HV);
Ext.getMetadataValue("[Beam] ImageMode", ImageMode);
Ext.getMetadataValue("[EBeam] EmissionCurrent", EmissionCurrent);

Ext.getMetadataValue("[EBeamDeceleration] ModeOn", EBeamDecelerationMode);
Ext.getMetadataValue("[EBeamDeceleration] LandingEnergy", LandingEnergy);
Ext.getMetadataValue("[EBeamDeceleration] StageBias", StageBias);

Ext.getMetadataValue("[EBeam] BeamMode", BeamMode);
Ext.getMetadataValue("[EBeam] BeamCurrent", BeamCurrent);
Ext.getMetadataValue("[EBeam] ApertureDiameter", AptDia);
Ext.getMetadataValue("[EBeam] LensMode", LensMode);
Ext.getMetadataValue("[EBeam] WD", WD);
Ext.getMetadataValue("[Scan] Dwelltime", Dwell);
Ext.getMetadataValue("[Scan] HorFieldsize", HFW);

Ext.getMetadataValue("[EScan] LineIntegration", LineIntegration);
Ext.getMetadataValue("[EScan] LineTime", LineTime);
Ext.getMetadataValue("[EScan] ScanInterlacing", ScanInterlacing);
Ext.getMetadataValue("[EScan] FrameTime", FrameTime);
Ext.getMetadataValue("[Image] Integrate", IntegrationNum);
Ext.getMetadataValue("[Image] DriftCorrected", DriftCorr);

Ext.getMetadataValue("[Stage] StageR", StageR);
Ext.getMetadataValue("[Stage] StageT", StageT);
Ext.getMetadataValue("[Stage] StageX", StageX);
Ext.getMetadataValue("[Stage] StageY", StageY);
Ext.getMetadataValue("[Stage] StageZ", StageZ);

print("Image File : " + id);
print("[System] SystemType : " + SystemType);
print("[Beam] HV : " + HV + " V");

ChPressure = d2s(parseFloat(ChPressure), -1);
print("[Vacuum] Chamber Pressure : " + ChPressure + " Pa");
print("[Beam] ImageMode : " + ImageMode);


BeamCurrent = parseFloat(BeamCurrent)*1E9; // in nA
AptDia = parseFloat(AptDia)*1E6; // in um
WD = parseFloat(WD)*1E3; // in mm
Dwell = parseFloat(Dwell)*1E6; // in us
EmissionCurrent = parseFloat(EmissionCurrent)*1E6; // in nA

StageR = parseFloat(StageR); // in deg
StageT = parseFloat(StageT); // in deg
StageX = parseFloat(StageX)*1E3; // in mm
StageY = parseFloat(StageY)*1E3; // in mm
StageZ = parseFloat(StageZ)*1E3; // in mm


print("[EBeam] Emission Current : " + EmissionCurrent + " nA");
print("[EBeam] UC Mode : " + BeamMode);
print("[EBeam] Beam Current : " + BeamCurrent + " uA");
print("[EBeam] Aperture Diameter : " + AptDia + " um");
print("[EBeam] Lens Mode : " + LensMode + " mode");
print("[EBeam] Working Distance : " + WD + " mm");
print("[EScan] Dwell Time : " + Dwell + " us");

print("[EScan] Line Integration : " + LineIntegration);
print("[EScan] Line Time : ", LineTime);
print("[EScan] Scan Interlacing : " + ScanInterlacing);
print("[EScan] Frame Time : " + FrameTime);
print("[Image] Frame Integration : " + IntegrationNum);
print("[Image] Drift Corrected : " + DriftCorr);

print("[EBeam Deceleration] Mode On : " + EBeamDecelerationMode);
print("[EBeam Deceleration] Landing Energy : " + LandingEnergy + " V");
print("[EBeam Deceleration] Stage Bias : " + StageBias + " V");

print("[Stage] Stage Rotation : " + StageR + " deg");
print("[Stage] Stage Tilt : " + StageT + " deg");
print("[Stage] Stage X : " + StageX + " mm");
print("[Stage] Stage Y : " + StageY + " mm");
print("[Stage] Stage Z : " + StageZ + " mm");

print("\n");

if(parseFloat(HFW) > 0.00001) {
	var ScaleUnit = "um";
	setVoxelSize(1E6*value1, 1E6*value1, 1, ScaleUnit);
}

else {
	var ScaleUnit = "nm";
	setVoxelSize(1E9*value1, 1E9*value1, 1, ScaleUnit);
}

}

// if the image is acquired by ion beam, then...
if (BeamType == "IBeam") {

Ext.getMetadataValue("[IScan] PixelWidth", value1);
Ext.getMetadataValue("[IBeam] HV", HV);
Ext.getMetadataValue("[Beam] ImageMode", ImageMode); // have not use this parameter
Ext.getMetadataValue("[IBeam] EmissionCurrent", EmissionCurrent);

Ext.getMetadataValue("[IBeam] BeamCurrent", BeamCurrent);
Ext.getMetadataValue("[IBeam] ApertureDiameter", AptDia);
Ext.getMetadataValue("[IBeam] WD", WD);
Ext.getMetadataValue("[Scan] Dwelltime", Dwell);
Ext.getMetadataValue("[Scan] HorFieldsize", HFW);

print("Image File : " + id);
print("[System] SystemType : " + SystemType);
print("[Beam] HV : " + HV + " V");

ChPressure = d2s(parseFloat(ChPressure), -1);
print("[Vacuum] Chamber Pressure : " + ChPressure + " Pa");
print("[Beam] ImageMode : " + ImageMode);

BeamCurrent = parseFloat(BeamCurrent)*1E9; // in nA
AptDia = parseFloat(AptDia)*1E6; // in um
WD = parseFloat(WD)*1E3; // in mm
Dwell = parseFloat(Dwell)*1E6; // in us

print("[IBeam] Beam Current : " + BeamCurrent + " uA");
// print("[IBeam] Aperture Diameter : " + AptDia + " um");
print("[IBeam] Working Distance : " + WD + " mm");
print("[IScan] Dwell Time : " + Dwell + " us");
print("\n");

if(parseFloat(HFW) > 0.00001) {
	var ScaleUnit = "um";
	setVoxelSize(1E6*value1, 1E6*value1, 1, ScaleUnit);
}

else {
	var ScaleUnit = "nm";
	setVoxelSize(1E9*value1, 1E9*value1, 1, ScaleUnit);
}

Ext.close();