import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;

public class World {
  private Solid[][] world;
  private ArrayList<Solid> solids;

  //possible problems is cols and rols swich w x and y 
  public World(ArrayList<Solid> solidList, int dimensionX, int dimensionY) {
    solids = solidList;
    world = new Solid[dimensionY][dimensionX];
    for (int i =0; i < solids.size(); i++) {
      addSolid(solids.get(i));
    }
  }

  public World(int w, int h) {
    world = new Solid[h][w];
    solids = new ArrayList<Solid>();
  }

  public World(String str) {
    int w = str.indexOf("\n")+1, h = str.split("\n").length+1;
    world = new Solid[h][w];
    println(">>>", w, h);
    solids = new ArrayList<Solid>();
    Scanner s = new Scanner(str);
    Texture[] textures = {
      new OneColor(color(255, 0, 255)), 
      new OneColor(color(#746D0D)), 
      new ImageTexture(loadImage("data/bricks.png")), 
      new ImageTexture(loadImage("data/bookshelf.png")), 
      new ImageTexture(loadImage("data/stonebrick.png"))
    };
    int x = 0, y = 0;
    while (s.hasNextLine()) {
      char[] chars = s.nextLine().toCharArray();
      for (char c : chars) {
        if (c == '#') addSolid(new Solid(x, y, 3, textures[4]));
        else if (c == 'D') {addSolid(new Door(x, y, 3, textures[3]));}
        else if (c == 'B') addSolid(new Solid(x, y, 3, textures[2]));
        else if (c >= 'A' && c <= 'Z') addSolid(new Solid(x, y, 3, textures[0]));
        x++;
      }
      x = 0;
      y++;
    }
    s.close();
  }

  public Solid whatsThere(int x, int y) {
    if (y < 0 || y >= world.length) {
      return null;
    }
    if (x < 0 || x >= world[y].length) {
      return null;
    }
    return world[y][x];
  }

  public void addSolid(Solid current) {
    if (current.getX() < world[0].length && current.getY() < world.length) {
      world[current.getY()][current.getX()] = current;
    } else {
      throw new IllegalArgumentException("coordinates must be within the dimensions of the world");
    }
  }

  public String toString() {
    String ans = "[ \n";
    String identity = "";
    for (int row = 0; row < world.length; row++) {
      ans += "[";
      for (int col = 0; col < world[0].length; col++) {
        if (world[row][col] instanceof Solid) {
          identity = "solid";
        } else if (world[row][col]  == null) {
          identity = "null";
        }
        ans += " " + identity + ",";
      }
      ans += "] \n";
    }
    return ans + "]";
  }
}

public class SaveFile {
  int worldWidth, worldHeight;
  float playerX, playerY;
  color sky, ground;
  ArrayList<Solid> terrain;
  
  SaveFile(File file) {
    try {parse(new Scanner(file));}
    catch(Exception e) {parse(new Scanner(""));}
  }
  SaveFile(String file) {
    parse(new Scanner(file));
  }
  SaveFile(byte[] bytes) {
    if(bytes == null) bytes = new byte[0];
    int[] data = new int[bytes.length];
    for(int i = 0; i < bytes.length; i++) {
      data[i] = bytes[i] & 0xff; //convert from -128:127 to 0:255
      print(data[i] + " ");
    }
    println();
    terrain = new ArrayList<Solid>();
    if(data.length > 3 && data[0] == '=' && data[1] == '=' && data[2] == '=') {
      println("Version 3 Save File");
      parse3(data);
    }
  }
  
  private void parse(Scanner in) {
    int state = 0;
    loop: while(in.hasNext()) {
      String line = in.nextLine();
      switch(state) {
        case 0: //expecting version number
          if(line.equals("==")) {
            System.out.println("Version 2 Save File");
            state = 1;
          }
          else {
            System.out.println("Invalid Save File, must start with ==");
            break loop;
          }
          break;
        case 1: //expecting world metadata 
          if(line.length() > 0 && !line.startsWith("\t")) {
            String[] args = line.trim().split(" ");
            worldWidth = getDimension(args, 0, 1);
            worldHeight = getDimension(args, 1, 1);
            sky = getColor(args, 2, "82CAFF");
            ground = getColor(args, 3, "764D0D");
            println(worldWidth, worldHeight, sky, ground);
            state = 2;
          }
          break;
        case 2: //expecting player position
          break;
      }
    }
    in.close();
    println("end of file");
  }
  
  private void parse3(int[] data) {
    int START_SECTION = 29;
    int state = 0; //0: transition, 1: metadata, 2: transition, 3: world data
    int x = 1, y = 1;
    Texture[] textures = {
      new OneColor(color(0, 128, 0))
    };
    for(int i = 3; i < data.length; i++) {
      switch(state) {
        case 0:
          if(data[i] == START_SECTION) state = 1;
          break;
        case 1:
          worldWidth = getNumber(data, i, 1) + 1;
          worldHeight = getNumber(data, i+1, 1) + 1;
          playerX = getNumber(data, i+2, 0);
          playerY = getNumber(data, i+3, 0);
          i += 3;
          state = 2;
          break;
        case 2:
          if(data[i] == START_SECTION) state = 3;
          break;
        case 3:
          if(data[i] >= 32 && y < worldHeight) { //ignore control characters/newlines AND stay within the bounds of world
            if((char)data[i] == 'g') {
              terrain.add(new Solid(x, y, 3, textures[0]));
            }
            x++;
            if(x >= worldWidth) {x = 1; y++;}
          }
         break;
      }
    }
    println(worldWidth, worldHeight, playerX, playerY);
  }
  
  /** Returns what the parameter "thing" is representing.
    Can be a 6digit mixed-case hexadecimal "color,"
    Or a positive integer "i-coordinate,"
    Or a positive decimal "f-coordinate,"
    Or a whole number "whole,"
    Or a negative "integer" or "float,"
    Or a comma-separated "list"
    Otherwise, it returns "string."
  */
  private String typeof(String thing) {
    if(thing.length() == 6) {
      try {int i = Integer.parseInt(thing, 16); return "color";}
      catch(Exception e) {}
    }
    else if(thing.contains(",")) {
      return "list";
    }
    else {
      try {
        int i = Integer.parseInt(thing);
        if(i > 0) return "i-coordinate";
        else if(i >= 0) return "whole";
        return "integer";
      } catch(Exception e) {
        float f;
        try {f = (float)Double.parseDouble(thing);}
        catch(Exception ee) {return "string";}
        if(f > 0) return "f-coordinate";
        else if(f >= 0) return "whole";
        return "float";
      }
    }
    return "string";
  }
  public float getNumber(String[] array, int index, float Default) {
    if(index < array.length) {
      try {return (float)Double.parseDouble(array[index]);}
      catch(Exception e) {return Default;}
    }
    return Default;
  }
  public int getNumber(int[] array, int index, int Default) {
    if(index < array.length)
      return array[index];
    return Default;
  }
  public float getCoordinate(String[] array, int index, float Default) {
    float f = getNumber(array, index, Default);
    if(f >= 0) return f;
    return Default;
  }
  public int getDimension(String[] array, int index, int Default) {
    int i = (int)getNumber(array, index, Default);
    if(i > 0) return i;
    return Default;
  }
  public color getColor(String[] array, int index, String Default) {
    if(Default.length() < 8) Default = "FF" + Default;
    println(Default);
    if(index < array.length) {
      if(array[index].length() == 6) array[index] = "FF" + array[index];
      if(array[index].length() == 8) {
        try {return Integer.parseInt(array[index], 16);}
        catch(Exception e) {}
      }
    }
    return 0;
    //return Integer.parseInt(Default, 16);
  }
  
  World loadWorld() {
    try {
      return new World(terrain, worldWidth, worldHeight);
    } catch(IllegalArgumentException e) {
      println(e.getMessage());
      return new World(0, 0);
    }
  }
  
  /** Returns a Renderer object containing all the necessary components. The world will be
      as it was specified in the save file. The Player's start coordinates will be configured
      too. Default resolution is 100 and Player will be facing the world at 45deg */
  Renderer load() {
    Camera camera = new Camera(playerX, playerY, radians(45), 100);
    World world = loadWorld();
    RayCastor raycastor = new RayCastor(camera, world);
    Renderer renderer = new Renderer(raycastor);
    return renderer;
  }
}