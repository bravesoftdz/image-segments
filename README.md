image-segments
==============

Convert any image into segments. Segments are rectangular areas
within the image, optionally with averaged colors,
optionally converted to 2 colors (light and dark).
See the images in demo/ subdirectory for examples how does it look like

As I understand, such segmented (simplified) image version is very helpful
when manully knitting the image pattern.

Simple fractals demo using
Castle Game Engine [http://castle-engine.sourceforge.net/]
utilities (TCastleWindow and other helpers).

Compilation
===========

The program is written in Object Pascal.
Use Lazarus [http://www.lazarus.freepascal.org/] to compile the GUI
version for any OS (Linux, Windows etc.).
Optionally, you can use pure FPC [http://www.freepascal.org/]
to compile a command-line version (less user-friendly,
but allows to use this in scripts --- in batch mode).

The code uses the Castle Game Engine
[http://castle-engine.sourceforge.net/engine.php] for image operations.

To compile:
* Get Castle Game Engine [http://castle-engine.sourceforge.net/engine.php],
* In Lazarys install Castle Game Engine packages
  (castle_game_engine/packages/castle_components.lpk),
* Then open imagesegments.lpi in Lazarus and compile it as usual.

License
=======

This is open-source software. You can use and redistribute this program
on terms of GNU GPL license, version 2 or later.

--
Copyright Michalis Kamburelis.
