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
// Image annotation macro originally wrote by Nick McDougall
// 2018/08/30 Zhou Xu modified 
// @ Monash Centre for Electron Microscopy
//
// modified to support grey scale, 24bit RGB image formats
// font color auto-adjusted for the background color at the middle point of the line

fontSize = 24;
run("Measure");
label = getResult("Length", nResults-1);
getVoxelSize(width, height, depth, unit);
if (label>10)
label = d2s(label,1);
else
label = d2s(label,2);
label = label + " " + unit;
setJustification("left");
setFont("SansSerif", fontSize);
getLine(x1, y1, x2, y2, lineWidth);
v = getPixel((x1+x2)*0.5,(y1+y2)*0.5);

if (bitDepth==24) {
	red = (v>>16)&0xff;  // extract red byte (bits 23-17)
	green = (v>>8)&0xff; // extract green byte (bits 15-8)
	blue = v&0xff;       // extract blue byte (bits 7-0)
	Luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue;
} 
else {
	Luminance = v;
}

if (Luminance <90) {
	setColor("white");
}
else {
	setColor("black");
}
run("Draw", "slice");

if (label>10)
drawString(label, (x1+x2)*0.5+fontSize*0.5, (y1+y2)*0.5+fontSize*0.5);
else
drawString(label, (x1+x2)*0.5+fontSize*0.5, (y1+y2)*0.5+fontSize*0.5);
