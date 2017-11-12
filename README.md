# Raytastic

## What?
  This is a Raycastor made with Processing. It projects rays across a 2D map, which then come to represent vertical stripes
  on the screen. Basically, a limited 3D projection. No spheres, no prisms. But it's cool and doesn't lag.

## Who?
  Cynthia Cheng and Max Zlotskiy.

## How?
  Vectors, image manipulation, and an unecessary amount of levels of abstraction (as is typical of Java programs).
  
## Can has try?
  1. clone the Repo
  2. open Processing
  3. point it to the `.pde` files in `Main/`
  4. run it
  5. Use *left* and *right* arrow keys to move your head(camera)
  6. Use *up* key to move forward and *down* key to move backwards
  7. Press the spacebar to open/close/toggle doors. Doors look like bookshelves.
  8. You may enter the room through the door, or roam into the infinite brown expanse
  9. Press the number keys to open a different world
  10. Press . to increase render distance, and the comma (,) to decrease it

## Bugs
  You can pass through walls. If any `worldX.dat` files have improper formatting, or if any of the images are missing,
  the program will crash. Placing Solids at x=0 or y=0 produces mind-blowing
  visual glitches, and although the program protects those coordinates there is still no fix for the visual glitches.

## Plans
  We plan to implement a functional collision detection system. We also plan to add a main menu screen to provide
  keyboard instructions. The main menu screen should also lead to a map editor and/or a world selection screen.
  As of now, the only way to customize the World is to edit the data files. See the Save Format section below for instructions (do not blindly edit it).
  
  We plan to add a menu or keyboard shortcut to change render distance (currently 10) and resolution. Render distance
  affects how far the RayCastor will check for objects. The resolution affects how many rays the Camera projects,
  and therefor how smooth the rendering looks.

## Devlog

- May 29, 2017: 
  created repo in class, decided on final project topic (approved) - ray castor  
  wrote basic ray class with instance variables, constructor, toString (started using Pvector- Processing class)

- June 1st, 2017:
  Wrote camera class which interacts with Ray to create the projection of images. 
  Methods to create an "interative" ray and created mathods to "rotate" the camera.
  The camera also has a customizable resolution now.
  
- June 4th, 2017:
  The terrain is now stored inside of a World class. The World stores Solids by their coordinates, with
  a very fast cordinate lookup system. This also induced a refactoring of the Raycasting and Texture classes.
  Textures no longer draw themselves to the screen, but rather return an image buffer for Renderer to use.

- June 7th, 2017:
  Got Image Textures to work. Got HD textures to work too.

- June 9th, 2017:
  The background has a sky and ground, replacing the black void. Added some rudimentary movement.
  
- June 10th, 2017:
  Added doors and beacons.

- June 11th, 2017:
  Fixed all the bugs involved with movement. Also added the ability to load a World from a file using version 1 of the save format.

- November 11th, 2017:
  Released version 3 of the save format

## Save Format
  <u>Use a program that lets you edit the bytes of a file, such as Hex Fiend.</u>

  The first three characters must be = signs. After that, you may write whatever you want (like your name). End that section with a Group Separator (U+001D) symbol. The next byte will be the width of the world, followed by a byte for the height of the world. Then one byte each for the X and Y start coordinates of the Player. Then one byte for the Player's direction. This should be a number that, when multiplied by 15 degrees, will give the angle the player will be facing. Note that solids only exist in the first quadrant of the grid.

  Next comes another space for comments. To start specifying the actual contents of the world, put two Group Separator symbols. Every subsequent byte with a value greater than or equal to 32 (U+0020) will be interpreted as a solid. 