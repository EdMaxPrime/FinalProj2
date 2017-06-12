# FinalProj2
<h1>CYNneMAX</h1>
Cynthia Cheng and Max Zlontinsky Period 10

APCS FINAL PROJECT

Instructions:
Run the processing file Main.pde 
Use the up/down/right/left arrow keys to naigate yourself through maze
Enjoy! 

Working Features:
Can walk through maze using projecting vectors to create 3D images 
Solid objects have images printed on them
World takes input from a file

BUGS:
player can go through walls/cannot get doors to open 

To Be Implemented:
player stopped by walls, and movable doors
moving sprites you have interact with 

May 29, 2017: 
  created repo in class, decided on final project topic (approved) - ray castor  
  wrote basic ray class with instance variables, constructor, toString (started using Pvector- Processing class)

June 1st, 2017:
  Wrote camera class which interacts with Ray to create the projection of images. 
  Methods to create an "interative" ray and created mathods to "rotate" the camera
 
June 2nd, 2017:
  Camera updated can accept the angles in the construction
  Ray class calculates the distances of vectors and returns values and notes which side hit to better which direction tot conitue the ray growing (the ray continually grows until it hits an object then projects it) 
  
June 3rd, 2017:
  Ray Class: finished grow method can continually grow 
  Created a fake "World Class" (which will keep track of all the objects) to experiment with
  Can loop through all the Rays (like an iterator) continually goes around so it can create a view from the person's POV
  Debugger tool: graph to outline the vectors shot out from the point
  Labeled points on the visual depiction

June 4th, 2017:
  can rotate with the Ray class and camera responds to the turning
  World and Solid class created (solids are the walls/doors)
  Textures created for the soilds
  Renderer class created and used in the main file to run through rays
  3D WORKS!! OBJECT APPEAR

June 5th, 2017:
  Texture class updated to use Pimages 
  Shading on objects (like light hitting)
  Shades on the 3D object appear

June 6th, 2017:
  Created player class with its own perception and starting methods to control movement 
  Controlled with keyactions/key listener
  
June 8th, 2017:
  Image textures work, can be darkened

June 10th, 2017
  transparent textures work- for going through solids like doors
  fixed crash when you get too close to object 
  player movement and turning kind of works
  Floor and Sky added with horizon
  
June 11, 2017:
  added doors, press space to open/close
  world can now be instantiated from a string using Scanner

June 12, 2017:
  fixing last minute bugs
  tried to stop player from moving through solids (not finished)
  
  
