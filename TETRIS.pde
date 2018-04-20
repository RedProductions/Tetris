int lenx = 20;
int leny = 24;

int[][] grid = new int [lenx][leny];
//0 = empty  1 = permcase  2 = falling
int[][] col = new int [lenx][leny];

int type = 0;

int refx;
int refy;

int speed = 40;
int cspeed = speed;

boolean move = false;

boolean movelock = false;

int score = 0;

void setup(){
  
  //fullScreen ();
  size(800, 800);
  
  frameRate (120);
  
  stroke (0);
  
  textSize(20);
  
  noStroke ();
  
  resetgrid ();
  createblocks ();
  
}


void draw (){
  
  background(255);
  
  drawcases ();
  fill(0);
  text("Score: " + score, 0, 20);
  
  if (frameCount % speed == 0){
    refresh();
    detectlose ();
    detectline ();
  }
  
}


void refresh (){
  
  boolean quit = false;
  boolean down = false;
  
  for (int i = 0; i < lenx; i++){
    for (int j = leny - 1; j >= 0; j--){
      
      if (grid [i][j] == 2){
        if (j + 1 >= leny || grid[i][j + 1] == 1){
          
          quit = true;
          
        }else {
          down = true;
        }
      }
      
    }
    
  }
  
  if (quit){
    for (int k = 0; k < lenx; k++){
      for (int l = 0; l < leny; l++){
        
        if (grid[k][l] == 2){
          grid [k][l] = 1;
        }
        
      }
    }
    
    createblocks ();
    
  }else if (down){
    
    for (int k = 0; k < lenx; k++){
      for (int l = leny - 2; l >= 0; l--){
        
        if (grid [k][l] == 2){
          grid [k][l] = 0;
          grid[k][l + 1] = 2;
          col [k][l + 1] = col[k][l];
        }
        
      }
    }
  }
  
}

void detectlose (){
  
  for (int i = 0; i < lenx; i++){
    for (int j = 0; j < 5; j++){
      
      if (grid [i][j] == 1){
        
        resetgrid ();
        createblocks ();
        speed = 40;
        cspeed = speed;
        score = 0;
        
      }
      
    }
  }
  
}

void detectline (){
  
  for (int j = leny - 1; j >= 0; j--){
    int amount = 0;
    for (int i = 0; i < lenx; i++){
      
      if (grid [i][j] == 1){
        amount++;
      }
      
    }
    
    if(amount == lenx){
      lower (j);
    }
    
  }
  
}


void lower (int y){
  
  for (int j = y; j > 0; j--){
    for (int i = 0; i < lenx; i++){
      
      if (grid [i][j-1] != 2 && grid [i][j] != 2){
        grid [i][j] = grid [i][j-1];
        col [i][j] = col [i][j - 1];
      }
      
    }
  }
  
  score += 100;
  if(speed > 5){
    speed -= 2;
    cspeed = speed;
  }
  
}


void mousePressed (){
  
  move = false;
  
  if (mouseY < height/2){
    
    if (mouseX > width/2 && !movelock){
      
      rotateright ();
      
    }
    
  }else {
    refy = mouseY;
    move = true;
  }
  
}

void mouseReleased (){
  
  if (move){
    if(mouseX > width/2){
      moveright ();
    }else {
      moveleft ();
    }
  }
  
  move = false;
  
}



void keyPressed(){
  
  if(key == CODED){
    if(keyCode == LEFT){
      moveleft();
    }else if(keyCode == RIGHT){
      moveright();
    }else if(keyCode == UP){
      rotateright ();
    }else if(keyCode == DOWN){
      speed = 3;
    }
  }
  
}


void moveright (){
  
  boolean border = false;
  
  for (int i = 0; i < leny; i++){
    
    if(grid [lenx - 1][i] == 2){
      border = true;
    }
    
  }
  
  for (int i = 0; i < lenx - 1; i++){
    for (int j = 0; j < leny - 1; j++){
      
      if (grid [i][j] == 2){
        if (grid [i + 1][j] == 1){
          border = true;
        }
      }
      
    }
  }
  
  if (!border){
    for (int j = 0; j < leny; j++){
      for (int i = lenx - 2; i >= 0; i--){
        
        if(grid [i][j] == 2){
          grid [i][j] = 0;
          grid [i + 1][j] = 2;
          col [i + 1][j] = col [i][j];
        }
        
      }
    }
  }
  
  return;
  
}

void moveleft (){
  
  boolean border = false;
  
  for (int i = 0; i < leny; i++){
    
    if(grid [0][i] == 2){
      border = true;
    }
    
  }
  
  for (int i = 1; i < lenx; i++){
    for (int j = 1; j < leny; j++){
      
      if (grid [i][j] == 2){
        if (grid [i - 1][j] == 1){
          border = true;
        }
      }
      
    }
  }
  
  if (!border){
    for (int j = 0; j < leny; j++){
      for (int i = 0; i < lenx; i++){
        
        if(grid [i][j] == 2){
          grid [i][j] = 0;
          grid [i - 1][j] = 2;
          col [i - 1][j] = col [i][j];
        }
        
      }
    }
  }
  
  return;
  
}


void rotateright(){
  
  int cx = lenx;
  int cy = leny;
  
  int w = 0;
  int h = 0;
  
  for (int i = lenx - 1; i >= 0; i--){
    for (int j = leny - 1; j >= 0; j--){
      
      if (grid [i][j] == 2){
        
        if (i < cx){
          cx = i;
        }
        
        if (j < cy){
          cy = j;
        }
        
        if(i > w){
          w = i;
        }
        
        if(j > h){
          h = j;
        }
        
      }
      
    }
  }
  
  
  cx--;
  
  w -= cx;
  w+=2;
  
  cy--;
  
  h -= cy;
  
  h++;
  
  if(h > w){
    w = h;
  }
  
  int[][] replace = new int[w][w];
  int[][] ncol = new int [w][w];
  
  boolean able = true;
  
  if(cx + w < lenx && cy + w < leny && cx > 0 && cy > 1){
    
    for (int i = 0; i < w; i++){
      for (int j = 0; j < w; j++){
        
        replace [i][j] = grid [cx + i][cy + j];
        ncol [i][j] = col [cx + i][cy + j];
        
      }
    }
    
    
    for (int i = 0; i < w; i++){
      for (int j = 0; j < w; j++){
        
        //grid [cx + (4 - j) - 1][cy + i] = replace [i][j];
        if(grid [cx + (w - j) - 1][cy + i] == 2 && replace [i][j] == 1){
          able = false;
        }else if(grid [cx + (w - j) - 1][cy + i] == 1 && replace [i][j] == 2){
          able = false;
        }
        
      }
    }
    
  }else {
    able = false;
    if(!movelock){
      if(cx > lenx/2){
        movelock = true;
        for(int loop = 0; loop < w; loop++){
          moveleft();
        }
        rotateright();
        for(int loop = 0; loop < w; loop++){
          moveright();
        }
        movelock = false;
      }else {
        movelock = true;
        for(int loop = 0; loop < w; loop++){
          moveright();
        }
        rotateright();
        for(int loop = 0; loop < w; loop++){
          moveleft();
        }
        movelock = false;
      }
    }
  }
  
  if(able){
    
    for (int i = 0; i < w; i++){
      for (int j = 0; j < w; j++){
        
        if(grid [cx + ((w-1) - j)][cy + i] != 1 && replace [i][j] != 1){
          
          grid [cx + ((w-1) - j)][cy + i] = replace [i][j];
          col [cx + ((w-1) - j)][cy + i] = ncol [i][j];
          
        }
        
      }
    }
    
  }
  
}

void mouseDragged (){
  
  if (move){
    
    if (mouseY > refy + width/5){
      
      speed = 3;
      move = false;
      
    }
    
  }
  
}


void drawgrid (){
  
  for (int i = 0; i < lenx; i++){
    
    line (i * (width/float(lenx)), 0, i * (width/lenx), height);
    
  }
  
  for(int i = 0; i < leny; i++){
    
    line (0, i * (height/leny), width, i * (height/leny));
    
  }
  
}


void createblocks (){
  
  speed = cspeed;
  
  type = int (random (0, 7));
  //type = 0;
  int sx = int (random(lenx/2 - 2, lenx/2 + 2));
  
  /*
  0  **
     **
        
  1  *
     *
     *
     *
  
  2  **
      *
      *
  
  3  **
     *
     *
     
  4   *
     ***
     
  5  **
      **
      
  6   **
     **
     
  */
  
  
  
  if (type == 0){
    grid [sx][0] = 2;
    col [sx][0] = type;
    grid [sx + 1][0] = 2;
    col [sx + 1][0] = type;
    grid [sx][1] = 2;
    col [sx][1] = type;
    grid [sx + 1][1] = 2;
    col [sx + 1][1] = type;
  }else if (type == 1){
    for (int i = 0; i < 4; i++){
      grid [sx][i] = 2;
      col [sx][i] = type;
    }
  }else if (type == 2){
    grid [sx - 1][0] = 2;
    col [sx - 1][0] = type;
    for (int i = 0; i < 3; i++){
      grid [sx][i] = 2;
      col [sx][i] = type;
    }
  }else if (type == 3){
    grid [sx][0] = 2;
    col [sx][0] = type;
    grid [sx + 1][0] = 2;
    col [sx + 1][0] = type;
    grid [sx][1] = 2;
    col [sx][1] = type;
    grid [sx][2] = 2;
    col [sx][2] = type;
  }else if (type == 4){
    grid [sx][0] = 2;
    col [sx][0] = type;
    grid [sx - 1][1] = 2;
    col [sx - 1][1] = type;
    grid [sx][1] = 2;
    col [sx][1] = type;
    grid [sx + 1][1] = 2;
    col [sx + 1][1] = type;
  }else if (type == 5){
    grid [sx - 1][0] = 2;
    col[sx - 1][0] = type;
    grid [sx][0] = 2;
    col [sx][0] = type;
    grid [sx][1] = 2;
    col [sx][1] = type;
    grid [sx + 1][1] = 2;
    col [sx + 1][1] = type;
  }else if (type == 6){
    grid [sx][0] = 2;
    col [sx][0] = type;
    grid [sx + 1][0] = 2;
    col[sx + 1][0] = type;
    grid [sx][1] = 2;
    col[sx][1] = type;
    grid [sx - 1][1] = 2;
    col [sx - 1][1] = type;
  } 
  
}


void drawcases (){
  
  float x = width/float(lenx);
  float y = height/(float(leny)-4);
  
  for (int i = 0; i < lenx; i++){
    for (int j = 0; j < leny; j++){
      
      if (grid [i][j] != 0){
        int c = col [i][j];
        if (c == 0){
          fill (200, 200, 0);
        }else if (c == 1){
          fill (190, 70, 70);
        }else if (c == 2){
          fill(90, 150, 120);
        }else if (c == 3){
          fill (50, 80, 140);
        }else if(c == 4){
          fill (100, 15, 120);
        }else if (c == 5){
          fill (90, 120, 30);
        }else if (c == 6){
          fill (100, 100, 100);
        }
      }else {
        fill(255);
      }
      
      rect (float(i) * x, (float(j)-4) * y, x, y);
      
    }
  }
  
}


void resetgrid (){
  
  for (int i = 0; i < lenx; i++){
    for (int j = 0; j < leny; j++){
      
      grid [i][j] = 0;
      col [i][j] = 0;
      
    }
  }
  
}