#!/bin/sh
#
#   翻訳情報を生成します exercises_trans/$LANG/ 内に翻訳したコードが有ることを確認してください
#

if [ ! -f 'lang_patches/create_translate_patch.sh' ]
then
    echo "We must be run from the project root dir, precious!"; exit 1
fi

ex=$(printf "%03d" $1)
echo "searching exercise $ex..."

f=$(basename exercises/${ex}_*.zig .zig 2> /dev/null)
b=exercises/$f.zig
a=exercises_trans/$LANG/$f.zig
p=lang_patches/$LANG/patches/$f.patch

if [ ! -f $b ]; then echo "No $f! We hates it!"; exit 1; fi
if [ ! -f $a ]; then echo "No $a! Where is translate file?"; exit; fi

echo "Hissss!    before: '$b'"
echo "            after: '$a'"
echo "            patch: '$p'"

diff $b $a > $p

cat $p
