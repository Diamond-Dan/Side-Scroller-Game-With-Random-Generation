# Side Scrolling flying game test

## Purpose: 
Test random/procedural generation of sprites and music  
Test integration of AI image generator in Godot game engine  
Test integration of microservices in Godot game engine  

## To run:  
Download Godot and import the project  
  
### Navigate to  
Godot\Music_Generator\CS361-MicroserviceA and start Music.exe or run the music.py script: This script will generate music based on several musical scores.

### Navigate to  
Godot\Python amd start:  
1. background_finder.exe this will run with out stable diffusion AI image generator started in server mode, but you can use it in server mode if you like.  This script will call to stablediffusion to generate an image. Currently the criteria is set. You must be running your instance of stable diffusion on port 7860
3. image_gen_api.exe  this will generate a sprite and animate it, currently it has several set basic patterns and a random mode. You can add more patters via the python program below.
4. sound_effects_api.exe this will generate a random sound effects for the space ship and collisions.

You may also run any of these as a python script  

## Example

See below the image being generated and a random sprite being animated with no sound

![gif_1](https://github.com/user-attachments/assets/35dbcfa5-04c3-4bfc-8a9b-637faaf8e4d7)


![gif_2](https://github.com/user-attachments/assets/12dc7f5c-1e62-442d-8182-3e981b1fb6e9)

***UPDATE***
You can make more animations for this game using another program I have created. 
https://github.com/Diamond-Dan/Sprite_Gen 


