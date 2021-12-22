// Apply flat field correction to all images in a folder
// Written by Zhou XU
// Last updated on 2019 Apr 30


RawImgFolder = getDirectory("Select the Raw Image Folder");

RawImgList = getFileList(RawImgFolder);
NumberOfFiles = RawImgList.length;
// print("Raw Images: \n", FlatImgName);

count = 0;
folder = 0;
   
countFiles(RawImgFolder);
print("Total number of .tif files: ", count);
run("Image Sequence...", 
  "open=[&RawImgFolder]"+
  " number="+count+
  " starting=1"+
  " increment=1"+
  " scale=100 "+
  "file=[.tif] "+
  "sort");
RawName = getTitle(); 
tempName = newArray(nSlices);
ImgLabel = getSliceLabel(RawName,tempName);

autoHeight = getHeight();
autoWidth = getWidth();

msg = "Please select the resolution of your \nraw image. This will crop the dark \nimage and flat field image using \nthe numbers to remove databar:";

  Dialog.create("Image Processing");
  Dialog.addChoice("Type:", newArray("8-bit", "16-bit", "32-bit"));
  Dialog.addMessage(msg);

  Dialog.addCheckbox("Auto (Use raw image resolution)", true);
  Dialog.addNumber("Width:", autoWidth);
  Dialog.addNumber("Height:", autoHeight);
  Dialog.show();
  
  width = Dialog.getNumber();
  height = Dialog.getNumber();;
  type = Dialog.getChoice();
  auto = Dialog.getCheckbox();



DarkImgPath = File.openDialog("Select a Dark Image File");
  //open(path); // open the file
  DarkImgDir = File.getParent(DarkImgPath);
  DarkImgName = File.getName(DarkImgPath);
  print("DarkImgPath:", DarkImgPath);
  print("Dark Img Name:", DarkImgName);
  open(DarkImgPath);
  if (auto==true) 
  {
  width = autoWidth; 
  height = autoHeight;
  }
  makeRectangle(0, 0, width, height);
  run("Crop");
  
FlatImgPath = File.openDialog("Select a Flat Image File");
  //open(path); // open the file
  FlatImgDir = File.getParent(FlatImgPath);
  FlatImgName = File.getName(FlatImgPath);
  print("FlatImgPath:", FlatImgPath);
  print("Flat Img Name:", FlatImgName);
  open(FlatImgPath);
  if (auto==true) 
  {
  width = autoWidth; 
  height = autoHeight;
  }
  makeRectangle(0, 0, width, height);
  run("Crop");

selectWindow(FlatImgName);
selectWindow(DarkImgName);
run("Calculator Plus", "i1=[&FlatImgName] i2=[&DarkImgName] operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
selectWindow("Result");
rename("F-D");
getStatistics(area, mean, min, max, std);

selectWindow(RawName);
selectWindow(DarkImgName);
run("Calculator Plus", "i1=&RawName i2=[&DarkImgName] operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
selectWindow("Result");
rename("R-D");

selectWindow("R-D");
selectWindow("F-D");
run("Calculator Plus", "i1=R-D i2=F-D operation=[Divide: i2 = (i1/i2) x k1 + k2] k1=&mean k2=0 create");
selectWindow("Result");
rename("Corrected Image Stack");

setSliceLabel("Corrected Image Stack",ImgLabel);
print("\n");
close("\\Others");

File.makeDirectory(RawImgFolder + "Corrected") 
selectWindow("Corrected Image Stack");
for (i=1; i<=nSlices; i++)
{
	showProgress(i, nSlices);
	
	setSlice(i); 
	fileName = getMetadata("Label");
	newPath = RawImgFolder + "Corrected\\"+fileName;
	run("Copy"); 
	newImage("Untitled", type, width, height, 1); 
	run("Paste"); 
	
	saveAs("Tiff", newPath); 
	close(); 
}



function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], ".tif"))
              count++;  
          else
              folder++;
     }
}
 
 
function getSliceLabel(StackName,tempName) {
selectWindow(StackName);
for (i=0; i<nSlices; i++) {
	setSlice(i+1);
	tempName[i]=getMetadata("Label");
}
return tempName;
}


function setSliceLabel(StackName,sliceName) {
	selectWindow(StackName);
		for (i=0; i<nSlices; i++) {
		setSlice(i+1);
		setMetadata(sliceName[i]);
		}
}
