#!/bin/bash
#
# Translates the language files
#

# We check ourselves before we wreck ourselves.
if [ ! -f 'lang_patches/reverse.sh' ]
then
    echo "But I must be run from the project root directory."
    exit 1
fi

# Create directory of healing if it doesn't already exist.
mkdir -p lang_patches/$LANG/healed

# Cycle through all the little broken Zig applications.
for target in exercises/*.zig
do
    # Remove the dir and extension, rendering the True Name.
    true_name=$(basename $target .zig)
    patch_name="lang_patches/$LANG/patches/$true_name.patch"


    if [ -f $patch_name ]
    then
        echo reverse traslateing $true_name...
        patch -R -f $target < $patch_name
    else
        echo Cannot heal $true_name. No patch found.
    fi
done

# Test the healed exercises. May the compiler have mercy upon us.
# zig build -Dhealed
