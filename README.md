# Element-Tiles

Element-Tiles is a unique and good looking flat theme for the rEFInd bootloader. It is inspired by the periodic table and metro design and the colors are mostly taken from material design, giving it a fresh new look. It even comes in two variants - dark and light.

## Getting started

You need rEFInd bootloader to be installed and running before you install this theme. To know more, click [here](https://www.rodsbooks.com/refind/installing.html).

### Installation from prebuilt packages

Installing Element-Tiles is easy - just grab a copy of the latest release (available as .zip files), extract it, cd into the extracted directory and run install.sh from there. It will automatically search for rEFInd bootloader and install the theme.

### Building from source

If you want a customized version, then you can build the theme from source. A system running Ubuntu 18.04 is recommended for building from source. Follow the instructions carefully to build the theme from source.

##### Getting the prerequisites

Install the prerequisites before building by running the following command

```
sudo apt-get install build-essential imagemagick inkscape sed git
```

##### Cloning the repository

Clone this repository to your preferred directory.

```
cd ~/your/preferred/directory
git clone https://github.com/satyamtg/element-tiles-refind-theme.git
```

##### Building the theme

Build the theme using make.

```
cd ~/your/preferred/directory/element-tiles-refind-theme
sudo make
```

If you want to install the theme, type

```
sudo make install
```

The Makefile also has the targets "build" and "clean". Target "build" will make a zip with a install.sh inside it and "clean" will clean up the working directory for a fresh build. You can customize the Makefile if you want a custom look - a theme.conf will be generated accordingly.

## Compatibility

This theme is compatible with rEFInd v0.11.0 and tested on 0.11.2 and a system running Ubuntu 18.04 LTS.

## Authors

* **Satyam Kumar** - *satyamtg* - [GitHub](https://github.com/satyamtg) [GitLab](https://gitlab.com/satyamtg)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
The font used is Roboto Mono licensed under the Apache License 2.0


