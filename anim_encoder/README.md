# Animation Encoder
## Overview
anim_encoder creates small JavaScript+HTML animations from a series on PNG images.
This is a modification of that original post, that adds some actual documentation
cleans up the code base a bit and attempts to make it slightly more reliable. So that
if anyone actually wants to use this is a project they can get up and running really
quickly.

Original details are at http://www.sublimetext.com/~jps/animated_gifs_the_hard_way.html

## Getting Started (Compiling the Example)
```
sudo apt-get install pngcrush python-opencv python-numpy python-scipy
python anim_encoder.py example
firefox example.html
```

## Capturing your own images
Images will be saved to capture, you simply need to run capture.py and then go about your task.
Note you can just delete frames you don't want as you initially set up, should save you some
time. Then to run the program just go

```
python capture.py
```

If you need to change any settings it should be pretty simple just jump over to config.py
and edit the configuration options.


## Animated GIFs the Hard Way
When doing the new website for the Sublime Text 2.0 launch, instead of just screenshots,
I wanted to have animations to demonstrate some of its features. One of the criteria
was that the animations should work everywhere, from IE6 to an iPad. This ruled out
two common video options, Flash and the <video> element. Animated GIF files would
have been a candidate, except for two issues: the 256 color limitation, which would
have made the animations ugly, and the encoders I tried spat out huge files, at almost
1MB per-animation.

Instead, I wrote a small Python script that takes a collection of PNG frames as
input, and emits a single packed PNG file as output, which contains all the
differences between the frames, and some JSON meta-data specifying which bits of
the packed PNG file correspond to each frame. JavaScript turns the PNG and JSON
into an animation, using either the canvas element, or emulating it using
overlaid div elements for older browsers.

The data size of the animation is 96KB for the packed image plus 725 bytes for
the gzipped meta-data. This compares to 71KB for a static PNG of a single frame.
Aside from the quality advantage over animated GIFS, doing the playback in
JavaScript gives more control over the animation. This control is used on the
Sublime Text website to synchronize text with the animation, and automatically
cycle through the different animations.

Each entry in the above timeline describes a frame of data. The delay attribute
gives the number of milliseconds to show the frame for, and the blit attribute
describes the image rectangles that have changed from the previous frame. This
description uses 6 numbers, the first two give the offset within the packed image,
then two numbers for the width and height of the rectangle, and then another pair
of numbers for the destination position.

The JavaScript code to play the animation is quite short: the canvas version calls
drawImage to draw each rectangle at the appropriate time, while the fallback version
creates an absolutely positioned div element to represent each rectangle.

The Python encoder program puts quite a lot of effort into reducing the file size.
For each frame, it first determines a set of rectangles that differ from the
previous frame. Each of these rectangles is placed into the packed image, but
first the packed image is exhaustively searched to see if the data already exists,
in which case only meta-data is needed for the frame.

## Get Encoder
You can download the encoder from http://github.com/sublimehq/anim_encoder,
under the permissive 3 clause BSD license. Keep in mind it was written as an
essentially once off script, so it's not the easiest thing to work with.

## Requirements
anim_encoder.py has only been used on a Ubuntu system. It requires NumPy,
SciPy and OpenCV, which are available via apt-get as python-numpy, python-scipy
and python-opencv. It also assumes pngcrush is installed, and in the system path.

## Usage
For input, you'll need to have a series of files named screen_([0-9]+).png.
The number in the the filename is a timestamp in milliseconds for the frame.
The absolute values of the timestamps aren't important, just the difference
between them. For example:

It'll emit two files example_packed.png, and example_anim.js, containing the timeline.

## TODO
Make the encoder more friendly. It currently doesn't have any command line help,
always spends lots of time trying to shrink the animation, and is very picky about
what data it accepts (e.g., it'll fall over if the input PNGs have an alpha channel).
Make the JavaScript use requestAnimationFrame, so it'll be a little better behaved.
Make the encoder faster. The runtime hasn't been an issue for the short animations
I've used it for, but it wouldn't be fun for anything long.
Progressive Loading. Currently nothing is displayed until the entire animation has
loaded, however as the first frame of the animation is always located at the top
of the packed image, it wouldn't be hard to have this display as the packed image
is loading.

## LINKS
https://github.com/sublimehq/anim_encoder
http://www.sublimetext.com/~jps/animated_gifs_the_hard_way.html
https://news.ycombinator.com/item?id=4532146
http://www.imagemagick.org/Usage/anim_opt/
