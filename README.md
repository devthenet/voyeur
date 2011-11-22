# Voyeur

## Authors
Peter Garbers
    https://github.com/petergarbers
    www.twitter.com/petergarbers

Hendrik Louw
    https://github.com/HendrikLouw
    http://twitter.com/#!/hendrik_louw

## Description
Voyeur is a ruby library that will take your video files and convert
them into one of the 3 formats. MP4, OGV and Webm with what I hope is
an easy to use API

## Installation
The gem is easily installed by including the following line in your
Gemfile.
    gem 'voyeur'

## Setup
This gem requires ffmpeg to be installed. If you require assistance
there is a basic guide included in the wiki page. Feel free to add more!

## Usage
Simple conversions may be done by simply:
    Voyeur::Video.new( filename: path_to_file ).convert( to: :mp4 )
This will convert the video into Mp4 and save it in the same directory
as the original video.

Alternatively you can convert to all 3 types at once:
    Voyeur::Video.new( filename: path_to_file ).convert_to_html5
This will convert the video into 3 formats. Mp4, Ogv and Webm and place
them in the same folder as the parent.

I have allowed the user to specify an output filename. (Note: if no
output filename the file is just named after the original file):

    Voyeur::Video.new( filename: path_to_file ).convert( to: :mp4, output_filename: "my_cool_video" )

This will give you a converted video called "my_cool_video.mp4".

You can also convert to all with the following:
    Voyeur::Video.new( filename: path_to_file ).convert_to_html5( output_filename: "my_cool_video" )

It is also possible to place the formatted video in a custom folder:
    Voyeur::Video.new( filename: path_to_file ).convert( to: :mp4, output_path: "my/cool/file/path" )

or

    Voyeur::Video.new( filename: path_to_file ).convert_to_html5( output_path: "my/cool/file/path" )

## Extendibility

I've designed this in the hopes that others will be able to add
other formats / conversion options (haven't quite gone that far yet).
Right now it's as simple as creating a file similar to this:

    module Voyeur
      class Mp4 < Converter

        def file_extension
          "mp4"
        end

        def convert_options
          "-b 1500k -vcodec libx264 -g 30"
        end
      end
    end

The two methods file_extension and convert options are mandatory.

## Todo
1) Spawn processes simultaniously so more than one video can be converted
at once.

2) Add functionality so that users can use more specific convert
options


## Sources

### Links
http://stackoverflow.com/questions/5487085/ffmpeg-covert-html-5-video-not-working
http://johndyer.name/ffmpeg-settings-for-html5-codecs-h264mp4-theoraogg-vp8webm/
http://rodrigopolo.com/ffmpeg/cheats.html

### Conversion settings


    ffmpeg -i test.mpeg -b 1500k -vcodec libx264 -vpre slow -vpre baseline -g 30 test.mp4
    ffmpeg -i test.mpeg -b 1500k -vcodec libvpx -acodec libvorbis -ab 160000 -f webm -g 30 test.webm
    ffmpeg -i test.mpeg -b 1500k -vcodec libtheora -acodec libvorbis -ab 160000 -g 30 test.ogv


