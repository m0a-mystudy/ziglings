#!/bin/bash
#
#     "I will be a shieldmaiden no longer,
#      nor vie with the great Riders, nor
#      take joy only in the songs of slaying.
#      I will be a healer, and love all things
#      that grow and are not barren."
#             Éowyn, The Return of the King
#
#
# このスクリプトは、このディレクトリにあるパッチを用いて、 小さな壊れたプログラムを修復するものである。
# このディレクトリにあるパッチを使用して、それらを癒し
# 回復させたディレクトリで療養させる。
#

# We check ourselves before we wreck ourselves.
if [ ! -f 'lang_patches/translates.sh' ]
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
        # Apply the bandages to the wounds, grow new limbs, let
        # new life spring into the broken bodies of the fallen.
        echo traslateing $true_name...
        patch $target < $patch_name
    else
        echo Cannot heal $true_name. No patch found.
    fi
done

# Test the healed exercises. May the compiler have mercy upon us.
# zig build -Dhealed
