# atlas-project-scripts

Shell scripts to convert textures to an atlas format.  For BSD, Linux, and macOS users left without a script since mod authors only include `.bat` files.

## Usage

Quickstart:

    # In this example I am atlasing some Hlaalu textures.
    # First, make a temp directory to work in:
    mkdir ~/tmp

    # Copy the textures that need atlasing to the temp directory:
    cp -r ~/path/to/some/mod/textures/*.dds ~/tmp

    # Copy the conversion scripts to the temp directory:
    cp ~/path/to/atlas-project-scripts/lowercase-all-files.sh ~/path/to/atlas-project-scripts/atlas-generator.sh ~/tmp

    # Run the script to lowercase all filenames.  You will be prompted to hit Enter, do so.
    ~/tmp/lowercase-all-files.sh

    # Run the script to generate the atlas.  You will be prompted to hit Enter, do so.
    ~/tmp/atlas-generator.sh hlaalu

    # Copy the atlased textures into the mod directory to be used:
    cp -r ~/tmp/ATL ~/path/to/some/mod/

    # See the complete script usage:
    ~/tmp/atlas-generator.sh

### File Names

If you need to use a shell script, chances are your OS is case-sensitive.  In that case, the first thing you want to do is ensure all the filenames are lowercase-only.  This repository includes a `lowercase-all-files.sh` script that will rename all files in the same directory as it to be all lowercase.

The atlas generator script expects all filenames to be totally lowercase, so running this is a prerequisite for conversion.
