#!/bin/bash

# Image Compressor v1.3
# Author: c64-dev (nikosl@protonmail.com)
# A simple BASH utility for image optimization utilizing JPEG-RECOMPRESS, OPTIPNG and PNGQUANT.
# These programs use complex algorithms to reduce image size for jpg and png files, while keeping the perceive IQ as close to the original as possible.


# Installers for image processors
command_exists () {
    type "$1" &> /dev/null ;
}

install_jpegarchive () {
    echo -e '\033[0;32m** Info:\033[0m Build mozjpeg.' >&2
    mkdir tmp >/dev/null 2>&1
    cd tmp
    sudo apt-get install build-essential autoconf pkg-config nasm libtool
    git clone https://github.com/mozilla/mozjpeg.git
    cd mozjpeg
    cmake -G"Unix Makefiles" -DWITH_JPEG8=1
    make
    sudo make install
    cd ..
    sleep 1s
    echo -e '\033[0;32m** Info:\033[0m Build jpeg_archive.' >&2
    git clone https://github.com/danielgtaylor/jpeg-archive
    cd jpeg-archive
    make
    sudo make install
    cd ../..
    sudo rm -r tmp >/dev/null 2>&1
}

install_pngquant () {
    mkdir tmp >/dev/null 2>&1
    cd tmp
    git clone --recursive https://github.com/kornelski/pngquant.git
    cd pngquant
    sudo apt install -y libpng-dev
    make
    sudo make install
    cd ../..
    sudo rm -r tmp >/dev/null 2>&1
}

install_optipng () {
    sudo apt-get install -y optipng ;
}


# Main routine
    echo -e '\033[1;37m                **** Image Compressor v1.3 ****\n\033[0m** An automated utility for high quality image compression **\n' >&2
    
    echo -e '\033[0;32m** Info:\033[0m Copying files to new folder. Please wait...' >&2    
    mkdir optimized >/dev/null 2>&1
    cp *.jpg optimized >/dev/null 2>&1
    cp *.jpeg optimized >/dev/null 2>&1
    cp *.png optimized >/dev/null 2>&1
    cd optimized
    echo -e '\033[0;32m** Info:\033[0m Done.\n' >&2
    sleep 1s
   
    if command_exists jpeg-recompress; then
        echo -e '\033[1;36m** PART 1/3.\033[0;36m OPTIMIZING JPGs (JPEG-RECOMPRESS) **' >&2
        sleep 1s
        echo -e '\033[0;32m** Info:\033[0m Checking for dependencies.' >&2
        echo -e '\033[0;32m** Info:\033[0m jpeg-recompress is installed.' >&2
        echo -e '\033[0;32m** Info:\033[0m Proceeding with optimization of images...\n' >&2
        find -maxdepth 1 -type f -iname '*.jpg' -exec jpeg-recompress --quality veryhigh --method smallfry --accurate -s \{} \{} \;
        find -maxdepth 1 -type f -iname '*.jpeg' -exec jpeg-recompress --quality veryhigh --method smallfry --accurate -s \{} \{} \;
        echo -e '\033[1;32m** Info:\033[0m Done.\n' >&2
        sleep 1s
    else
        echo -e '\033[1;36m** PART 1/3.\033[0;36m OPTIMIZING JPGs (JPEG-RECOMPRESS) **' >&2
        sleep 1s
        echo -e '\033[0;32m** Info:\033[0m Checking for dependencies.' >&2
        echo -e '\033[0;31m** Warning:\\033[0m jpeg-recompress not found. Installing application...\n' >&2
        install_jpegarchive
        echo -e '\033[0;32m** Info:\033[0m Proceeding with optimization of images...\n' >&2        
        find -maxdepth 1 -type f -iname '*.jpg' -exec jpeg-recompress --quality veryhigh --method smallfry --accurate -s \{} \{} \;
        find -maxdepth 1 -type f -iname '*.jpeg' -exec jpeg-recompress --quality veryhigh --method smallfry --accurate -s \{} \{} \;
        echo -e '\033[1;32m** Info:\033[0m Done.\n' >&2
        sleep 1s
    fi

    if command_exists optipng; then
        echo -e '\033[1;36m** PART 2/3.\033[0;36m OPTIMIZING PNGs (OPTIPNG) **' >&2
        sleep 1s
        echo -e '\033[0;32m** Info:\033[0m Checking for dependencies.' >&2
        echo -e '\033[0;32m** Info:\033[0m optipng is installed.' >&2
        echo -e '\033[0;32m** Info:\033[0m Proceeding with optimization of images...\n' >&2
        find -maxdepth 1 -type f -iname '*.png' -exec optipng \{} \;
        echo -e '\033[1;32m** Info:\033[0m Done.\n' >&2
        sleep 1s
    else
        echo -e '\033[1;36m** PART 2/3.\033[0;36m OPTIMIZING PNGs (OPTIPNG) **' >&2
        sleep 1s
        echo -e '\033[0;32m** Info:\033[0m Checking for dependencies.' >&2
        echo -e '\033[0;31m** Warning:\\033[0m optipng not found. Installing application...\n' >&2
        install_optipng
        echo -e '\033[0;32m** Info:\033[0m Proceeding with optimization of images...\n' >&2        
        find -maxdepth 1 -type f -iname '*.png' -exec optipng \{} \;
        echo -e '\033[1;32m** Info:\033[0m Done.\n' >&2
        sleep 1s
    fi

    if command_exists pngquant; then
        echo -e '\033[1;36m** PART 3/3.\033[0;36m OPTIMIZING PNGs (PNGQUANT) **' >&2
        sleep 1s
        echo -e '\033[0;32m** Info:\033[0m Checking for dependencies.' >&2
        echo -e '\033[0;32m** Info:\033[0m pngquant is installed.' >&2
        echo -e '\033[0;32m** Info:\033[0m Proceeding with optimization of images...\n' >&2
        pngquant *.png --force --ext .png --verbose
        cd ..
        echo -e '\033[1;32m** Info:\033[0m Cleaning up. All done. \n\033[1;32m** Info:\033[0m Images optimized. \n\033[1;32m** Info:\033[0m You can find all processed images in subfolder "optimized."' >&2
    else
        echo -e '\033[1;36m** PART 3/3.\033[0;36m OPTIMIZING PNGs (PNGQUANT) **' >&2
        sleep 1s
        echo -e '\033[0;32m** Info:\033[0m Checking for dependencies.' >&2
        echo -e '\033[0;31m** Warning:\\033[0m pngquant not found. Installing application...\n' >&2
        install_pngquant
        echo -e '\033[0;32m** Info:\033[0m Proceeding with optimization of images...\n' >&2        
        pngquant *.png --force --ext .png --verbose
        cd ..
        echo -e '\033[1;32m** Info:\033[0m Cleaning up. All done. \n\033[1;32m** Info:\033[0m Images optimized. \n\033[1;32m** Info:\033[0m You can find all processed images in subfolder "optimized."' >&2
    fi
