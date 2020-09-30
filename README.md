# GALEX-mosaic

Here is a code example to mosaic the GALEX deep survey images.

GALEX image datasets include quite a lot of data such as the intensity map (xxx-int.fits.gz), sky background map (xxx-skybg.fits.gz). xxx-int.fits.gz includes total flux from sky background and targets. So exptime X int.fits.gz would be the total counts, and exptime X skybg.fits.gz would be the background. Then I add all the counts and exposure time, and divide the total exposure time to get the mosaic image.

usage:

1, Download the image data from GALEX website, such as:

http://galex.stsci.edu/GR6/?page=tilelist&survey=dis

click the Show All Tiles button, got the full list. Then order the field by ra and find the data we need, and download them.

2, put the data somewhere, then change the data_path in stack-counts.pro, and run stack-counts.pro.
