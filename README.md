# Image Compressor
Compress JPEG and PNG files in a folder utilizing all CPU cores. This is a simple shell script that uses the utilities below. 

* [jpeg-recompress](https://github.com/danielgtaylor/jpeg-archive)
* [optipng](http://optipng.sourceforge.net/)
* [pngquant](https://github.com/kornelski/pngquant)

These utilities use complex algorithms to greatly reduce the size of image files, while keeping the perceived IQ as close to the original as possible. At the moment JPG and PNG image files are supported.

### Features
* Automatic parsing of all image files inside specified directory
* Non-destructive operation. All compressed images are saved in user specified folder.
* Works on jpg and png files. Further image types might be added in the future.

### Installation
Simply download or clone the repository and extract to any folder.
In order to be able to use the utility from any directory run: 

'''
sudo mv compressor.sh /usr/local/bin/compressor
'''

### Usage
Run the utility from a terminal window as follows:

'''
compressor <max quality> [input dir] [output dir] 
'''

where '<max quality>' an integer from 1 (lowest) to 100 (highest). This states the maximum quality for the compressor to use. Recommended setting between 80-90.


Utilities
---------
The following utilities are used in this project. 

### jpeg-compress
Compress JPEGs by re-encoding to the smallest JPEG quality while keeping perceived visual quality the same and by making sure huffman tables are optimized. This is a **lossy** operation, but the images are visually identical and it usually saves 30-70% of the size for JPEGs coming from a digital camera, particularly DSLRs.

Below are two 100% crops of Nikon's D3x Sample Image 2. The left shows the original image from the camera, while the others show the output of jpeg-recompress with the medium quality setting and various compression methods. 

![Sample](https://cloud.githubusercontent.com/assets/106826/3633843/5fde26b6-0eff-11e4-8c98-f18dbbf7b510.png)

#### Image Comparison Metrics
The following metrics are available when using `jpeg-recompress`. By default the SmallFry algorithm is used.

Name     | Option        | Description
-------- | ------------- | -----------
MPE      | `-m mpe`      | Mean pixel error (as used by [imgmin](https://github.com/rflynn/imgmin))
SSIM     | `-m ssim`     | [Structural similarity](http://en.wikipedia.org/wiki/Structural_similarity) 
MS-SSIM* | `- m ms-ssim`  | Multi-scale structural similarity (slow!) ([2008 paper](https://doi.org/10.1117/12.768060))
SmallFry | `-m smallfry` | Linear-weighted BBCQ-like ([original project](https://github.com/dwbuiten/smallfry), [2011 BBCQ paper](http://spie.org/Publications/Proceedings/Paper/10.1117/12.872231))

**Note**: The SmallFry algorithm may be [patented](http://www.jpegmini.com/main/technology) so use with caution.


## optipng
OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information. This program also converts external formats (BMP, GIF, PNM and TIFF) to optimized PNG, and performs PNG integrity checks and corrections. 


## pngquant 2
pngquant is a PNG compressor that significantly reduces file sizes by converting images to a more efficient 8-bit PNG format with alpha channel (often 60-80% smaller than 24/32-bit PNG files). Compressed images are fully standards-compliant and are supported by all web browsers and operating systems.


### Licence
* JPEG-Archive is copyright © 2015 Daniel G. Taylor
* Image Quality Assessment (IQA) is copyright 2011, Tom Distler (http://tdistler.com)
* SmallFry is copyright 2014, Derek Buitenhuis (https://github.com/dwbuiten)
* OptiPNG is copyright © 2001-2017 Cosmin Truta and the [Contributing Authors](http://optipng.sourceforge.net/authors.txt).
* pngquant © 2009-2018 by Kornel Lesiński.
