# Voyeur
Voyeur is a ruby library that will take your video files and convert
them to common HTML5 formats exposing an easy to use API. Seriously
it's like falling out of a tree then climbing back.

## Installation
The gem is easily installed by including the following line in your
Gemfile (if you role that way)

    gem 'voyeur'
    
 or on the command line 
 
    gem install voyeur
    require 'voyeur'
    
## Setup
This gem requires ffmpeg to be installed. If you require assistance
there is a basic guide included in the [wiki page](https://github.com/devthenet/Voyeur/wiki/Installing-ffmpeg-%28Ubuntu%29). Feel free to add more!  
You can also try out automated [setup scripts](https://github.com/devthenet/ffmpeg_setup) (at the moment we only have for ubuntu):




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
1. Spawn processes simultaniously so more than one video can be converted
at once.
2. Add functionality so that users can use more specific convert
options

## Authors
#### Peter Garbers  
* https://github.com/petergarbers      
* http://twitter.com/petergarbers

#### Hendrik Louw
* https://github.com/HendrikLouw  
* http://twitter.com/hendrik_louw

## Sources

### Links
* http://stackoverflow.com/questions/5487085/ffmpeg-covert-html-5-video-not-working
* http://johndyer.name/ffmpeg-settings-for-html5-codecs-h264mp4-theoraogg-vp8webm/
* http://rodrigopolo.com/ffmpeg/cheats.html
