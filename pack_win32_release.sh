#!/bin/bash
set -eu

# Create imagesegments-win32.zip with Windows binary of the program.
#
# Assumes that a lazbuild is installed on the current system
# (we pass --operating-system and --widgetset so the current system can
# still be Linux, just make sure to configure FPC and Lazarus to cross-compile
# to win32).
#
# And assumes that full "Castle Game Engine" repo is under
# ../castle-engine/trunk/ .

LAZBUILD_OPTIONS='--operating-system=win32 --widgetset=win32'
DLLS_DIR='../castle-engine/trunk/www/pack/win32_dlls/'

cd ../castle-engine/trunk/
./clean_everything.sh
# Packages below will be automatically rebuild anyway:
#lazbuild $LAZBUILD_OPTIONS /usr/local/share/lazarus/components/opengl/lazopenglcontext.lpk
#lazbuild $LAZBUILD_OPTIONS castle_game_engine/packages/castle_base.lpk
#lazbuild $LAZBUILD_OPTIONS castle_game_engine/packages/castle_components.lpk
cd ../../image-segments/
lazbuild $LAZBUILD_OPTIONS imagesegments.lpi

cp "$DLLS_DIR"libpng12.dll "$DLLS_DIR"zlib1.dll .
rm -f imagesegments-win32.zip
zip imagesegments-win32.zip libpng12.dll zlib1.dll imagesegments.exe
rm -f libpng12.dll zlib1.dll
