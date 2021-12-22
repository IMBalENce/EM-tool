// Set Zeis SEM(FIB) scale and display acquisition metadata using Tiff tags Metadata
// Written by Zhou XU
// at Monash Centre for Electron Microscopy
// Windows 10 Enterprise Ver. 1803
// ImageJ ver. 1.52g

// Copyright 2020 Zhou Xu
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
Ext.getMetadataValue("Sem", SystemType);
Ext.getMetadataValue("Serial No.", SystemDetail);
Ext.getMetadataValue("FIB Imaging", BeamType);
Ext.getMetadataValue("Chamber", ChPressure);

// if the image is acquired by electron beam, then
if (BeamType == "SEM") {

Ext.getMetadataValue("Image Pixel Size", value1);
if(endsWith(value1, "nm")) {
	ScaleUnit = "nm";
	pixelSize1 = parseFloat(value1);
	setVoxelSize(pixelSize1, pixelSize1, 1, ScaleUnit);
}
else {
	ScaleUnit = "um";
	pixelSize1 = parseFloat(value1);
	setVoxelSize(pixelSize1, pixelSize1, 1, ScaleUnit);
}



print("Image File : " + id);
print("[System] Microscope system : " + SystemType);
print("[System] System Detail : " + SystemDetail);

print("[System] Imaging Mode : Electron Beam" );

Ext.getMetadataValue("Gun Vacuum", GunPressure);
print("[Vacuum] Gun Pressure : " + GunPressure);

Ext.getMetadataValue("System Vacuum", EColPressure);
print("[Vacuum] Column Pressure : " + EColPressure );
// ChPressure = d2s(parseFloat(ChPressure), -1);
print("[Vacuum] Chamber Pressure : " + ChPressure);



// Ext.getMetadataValue("", ImageMode);
// print("[Beam] ImageMode : " + ImageMode);

Ext.getMetadataValue("Column", EColumn);
print("[EBeam] Column Type : " + EColumn);

Ext.getMetadataValue("Beam Time", ESourceTime);
print("[EBeam] Source Lifetime : " + ESourceTime);

Ext.getMetadataValue("EHT", HV);
print("[EBeam] HV : " + HV );

Ext.getMetadataValue("Column Mode", EColMode);
print("[EBeam] Column Mode : " + EColMode);

Ext.getMetadataValue("Extractor V", EmissionCurrent);
// EmissionCurrent = parseFloat(EmissionCurrent); // Extractor V
print("[EBeam] Extractor Voltage : " + EmissionCurrent);

Ext.getMetadataValue("High Resolution Mode", BeamMode);
print("[EBeam] HR Mode : " + BeamMode);

Ext.getMetadataValue("Beam Current", BeamCurrent);
// BeamCurrent = parseFloat(BeamCurrent);
print("[EBeam] Beam Current : " + BeamCurrent);

Ext.getMetadataValue("Aperture Size", AptDia);
AptDia = parseFloat(AptDia); // in um
print("[EBeam] Aperture Diameter : " + AptDia + " um");

// Ext.getMetadataValue("[EBeam] LensMode", LensMode);
// print("[EBeam] Lens Mode : " + LensMode + " mode");

Ext.getMetadataValue("WD", WD);
WD = parseFloat(WD); // in mm
print("[EBeam] Working Distance : " + WD + " mm");

Ext.getMetadataValue("Dwell Time", Dwell);
// Dwell = parseFloat(Dwell); // in us
print("[EScan] Dwell Time : " + Dwell);

Ext.getMetadataValue("Width", HFW);


Ext.getMetadataValue("Line Avg.Count", LineIntegration);
Ext.getMetadataValue("LineTime", LineTime);
// Ext.getMetadataValue("Frames to average", FrameAverage);
Ext.getMetadataValue("Cycle Time", FrameTime);
// Ext.getMetadataValue("[Image] Integrate", IntegrationNum);
// Ext.getMetadataValue("[Image] DriftCorrected", DriftCorr);

print("[EScan] Line Integration : " + LineIntegration);
print("[EScan] Line Time : ", LineTime);
// print("[EScan] Scan Interlacing : " + ScanInterlacing);
print("[EScan] Frame Time : " + FrameTime);
// print("[Image] Frame Integration : " + IntegrationNum);
// print("[Image] Drift Corrected : " + DriftCorr);

Ext.getMetadataValue("Scan Rotation", EScanRot);
print("[EScan] Scan Rotation : " + EScanRot);

Ext.getMetadataValue("Beam deceleration", EBeamDecelerationMode);
Ext.getMetadataValue("Landing energy", LandingEnergy);
Ext.getMetadataValue("Beam deceleration Volts", StageBias);

print("[EBeam Deceleration] Mode On : " + EBeamDecelerationMode);
print("[EBeam Deceleration] Landing Energy : " + LandingEnergy);
print("[EBeam Deceleration] Stage Bias : " + StageBias);

Ext.getMetadataValue("Signal A", DetectorA);
print("[Detector] : " + DetectorA);

Ext.getMetadataValue("Stage at R", StageR);
Ext.getMetadataValue("Stage at T", StageT);
Ext.getMetadataValue("Stage at X", StageX);
Ext.getMetadataValue("Stage at Y", StageY);
Ext.getMetadataValue("Stage at Z", StageZ);
// StageR = parseFloat(StageR); // in deg
// StageT = parseFloat(StageT); // in deg
// StageX = parseFloat(StageX)*1E3; // in mm
// StageY = parseFloat(StageY)*1E3; // in mm
// StageZ = parseFloat(StageZ)*1E3; // in mm
print("[Stage] Stage Rotation : " + StageR + " deg");
print("[Stage] Stage Tilt : " + StageT + " deg");
print("[Stage] Stage X : " + StageX);
print("[Stage] Stage Y : " + StageY);
print("[Stage] Stage Z : " + StageZ);




print("\n");

}



// if the image is acquired by ion beam, then...
if (BeamType == "FIB") {



Ext.getMetadataValue("Image Pixel Size", value1);
if(endsWith(value1, "nm")) {
	ScaleUnit = "nm";
	pixelSize1 = parseFloat(value1);
	setVoxelSize(pixelSize1, pixelSize1, 1, ScaleUnit);
}
else {
	ScaleUnit = "um";
	pixelSize1 = parseFloat(value1);
	setVoxelSize(pixelSize1, pixelSize1, 1, ScaleUnit);
}

print("Image File : " + id);
print("[System] SystemType : " + SystemType);
print("[System] System Detail : " + SystemDetail);
// ChPressure = d2s(parseFloat(ChPressure), -1);

print("[System] Imaging Mode : Ion Beam");

Ext.getMetadataValue("FIB Gun Pressure", IGunPressure);
print("[Vacuum] FIB Gun Pressure : " + IGunPressure );
Ext.getMetadataValue("FIB Column Pressure", IColPressure);
print("[Vacuum] FIB Column Pressure : " + IColPressure );
print("[Vacuum] Chamber Pressure : " + ChPressure );

Ext.getMetadataValue("FIB Column", IColumn);
print("[IBeam] Column Type : " + IColumn);

Ext.getMetadataValue("FIB Source lifetime", ISourceTime);
print("[IBeam] Source Lifetime : " + ISourceTime);

Ext.getMetadataValue("FIB EHT", HV);
print("[IBeam] HV : " + HV);

// print("[Beam] ImageMode : " + ImageMode);

// Ext.getMetadataValue("[Beam] ImageMode", ImageMode); // have not use this parameter

Ext.getMetadataValue("FIB Emission I", EmissionCurrent);
print("[IBeam] Emission Current : " + EmissionCurrent);

Ext.getMetadataValue("FIB Image Probe", BeamCurrent);
print("[IBeam] Imaging parameter : " + BeamCurrent);

Ext.getMetadataValue("FIB Probe Current Actual", actProbeCurrent);
print("[IBeam] Actual Probe Current : " + actProbeCurrent);

// Ext.getMetadataValue("[IBeam] ApertureDiameter", AptDia);

// BeamCurrent = parseFloat(BeamCurrent)*1E9; // in nA
// AptDia = parseFloat(AptDia)*1E6; // in um
// WD = parseFloat(WD)*1E3; // in mm
// Dwell = parseFloat(Dwell)*1E6; // in us

// print("[IBeam] Aperture Diameter : " + AptDia + " um");
Ext.getMetadataValue("WD", WD);
print("[IBeam] Working Distance : " + WD);

Ext.getMetadataValue("Dwell Time", Dwell);
print("[IScan] Dwell Time : " + Dwell);

Ext.getMetadataValue("FIB Scan Size", IHFW);
print("[IScan] HFW : " + IHFW);

Ext.getMetadataValue("FIB Scan Rot", IScanRot);
print("[IScan] Scan Rotation : " + IScanRot);

Ext.getMetadataValue("Signal A", DetectorA);
print("[Detector] : " + DetectorA);

Ext.getMetadataValue("Stage at R", StageR);
Ext.getMetadataValue("Stage at T", StageT);
Ext.getMetadataValue("Stage at X", StageX);
Ext.getMetadataValue("Stage at Y", StageY);
Ext.getMetadataValue("Stage at Z", StageZ);
// StageR = parseFloat(StageR); // in deg
// StageT = parseFloat(StageT); // in deg
// StageX = parseFloat(StageX)*1E3; // in mm
// StageY = parseFloat(StageY)*1E3; // in mm
// StageZ = parseFloat(StageZ)*1E3; // in mm
print("[Stage] Stage Rotation : " + StageR + " deg");
print("[Stage] Stage Tilt : " + StageT + " deg");
print("[Stage] Stage X : " + StageX);
print("[Stage] Stage Y : " + StageY);
print("[Stage] Stage Z : " + StageZ);

print("\n");


Ext.close();