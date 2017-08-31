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
  
  SaveFile(File file) {
    try {parse(new Scanner(file));}
    catch(Exception e) {parse(new Scanner(""));}
  }
  SaveFile(String file) {
    parse(new Scanner(file));
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
}