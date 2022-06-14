# EM-tool
an ImageJ toolset for EM image analysis

# **Overview**

This is a suite of ImageJ plugins that are used for processing images acquired from electron microscopes. Currently the main focus is on SEM images, but I will keep working on streamline the image processing of both SEM and TEM data.

2022-06-14 Update note: Add Python script plugin for Tescan SEM tiff metadata reading. Add instruction page for flat field correction. Correct FEI metadata display bug.

# **Components and Functions**

Click the links below to find more about each tool.

1.  \[ [SEM FEI metadata and scale](https://zxuminescence.wordpress.com/sem-fei-metadata-scale/) \] reads FEI SEM acquisition metadata from tiff tags and set image scale based on pixel size.
2.  \[ [SEM FEI databar cut](https://zxuminescence.wordpress.com/sem-fei-databar-cut/) \] cuts databar from FEI SEM images, then save image and databar as individual files. (Page in preparation)
3.  \[ [SEM JOEL Scale](https://zxuminescence.wordpress.com/?page_id=874) \] sets image scale based on pixel size store in the .txt file associated with SEM image.
4.  \[ [SEM ZEISS metadata scale](https://zxuminescence.wordpress.com/sem-zeiss-metadata-scale/) \] reads ZEISS SEM acquisition metadata from tiff tags and set image scale based on pixel size.
5.  \[ [SEM Hitachi metadata scale](https://zxuminescence.wordpress.com/sem-hitachi-metadata-scale/) \] Upcoming...
6.  \[ [Image feature measurement annotation](https://zxuminescence.wordpress.com/image-annotation/) \] measures and mark the size of features. It annotates the length of line tool in a calibrated image and export measurement results.
7.  \[ [Flat field correction](https://zxuminescence.wordpress.com/flat-field-correction/) \] Applies flat filed correction to a folder of images for large area mapping to mitigate chess pattern after stitching. (Page in preparation)
8.  \[ [ TEM .ser .dm3 folder export](https://zxuminescence.wordpress.com/tem-ser-dm3-folder-export/) \] This tool convert TIA EM image .ser files and Gatan .dm3 files in a folder to TIFF format.
9.  \[ [ SEM_tescan metadata]() \] Python script that reads Tescan SEM metadata and set scale based on pixel size.

# **Installation**

## Installation via Fiji updater

1\. [Fiji](https://fiji.sc) (Fiji Is Just ImageJ) should be installed on your computer.

2\. Click "Help | Update... to open the Fiji updater. If it's the first time updating your Fiji, it might take some time to download the update files and may also require to restart Fiji a few times. Once done, click {% include bc path="Help | Update..." %} again to bring up the ImageJ updater window.

<figure><img src="https://zxuminescence.files.wordpress.com/2020/09/emtool_01.jpg" width="350" alt="EMtool_01.jpg"> </figure>

3\. Click "Manage update sites".

<figure><img src="https://zxuminescence.files.wordpress.com/2020/09/emtool_02.jpg?w=768" width="500" alt="EMtool_02.jpg"></figure>

4\. Find and tick "EM tool", URL "https://sites.imagej.net/IMBalENce/".

5\. If the update site does not show, you can manually add the site by clicking "Add update site". Type in Name "EM tool", URL "https://sites.imagej.net/IMBalENce/"

<figure><img src="https://zxuminescence.files.wordpress.com/2020/09/emtool_03.jpg" title="EMtool_03.jpg" width="500" alt="EMtool_03.jpg" /></figure>

6 Close the "Manage Update Sites" window and click the "Apply Changes" button on the "ImageJ Updater Window".

7\. Once update is completed, restart Fiji. You should be able to see the plugins "EM tool" installed in the top toolbar.

## Manual Installation

If you only want to use one of the plugins you can follow these steps:

1\. The source code of these macro scripts can be viewed on [my github page](https://github.com/IMBalENce/EM-tool).

2\. Download the plugin you want.

3\. Save .ijm files in the desired location within your imageJ application

4\. Go to "Plugins|Macros|Install..." to add the macros, or drag-and-drop the .ijm file into ImageJ/Fiji
