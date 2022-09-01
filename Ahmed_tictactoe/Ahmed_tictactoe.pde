/*
 Tic Tac Toe
 by Ahmed Qazi
 Start Screen & play button
 Play screen - show the grid
 Initialize - clear grid - randomize the turn
 Take a turn - pick a empty spot
 - check for win AP - draw the line
 check for tie
 Keep Score - at the end of each game - cont & restart
 */
int level = 0; // 0 = menu 1 = play 2 = win 3 = lose 4 = tie
int turn = 0; // 0 = init 1 = player 2 = AI
String [] mItems = {"START"};
float angle = 0;
int time = 50;
int alarm = -1;
int scoreP = 0   ;
int scoreAI = 0    ;
int topX=100, topY=100, sq=150, gap=25;// draw the grid
int winlines =-1;
PImage xImg, oImg, back, AIturnImg;
int [] grid = new int[9];
void setup()
{
  size(1000, 800);
  //load images
  back = loadImage("back.jpg");
  xImg = loadImage("Redstone.png");
  oImg = loadImage("glowstone.png");
  AIturnImg = loadImage("loading.png");
}
void draw()
{
  if (level == 0)
  {
    showMenu
      ();
  } else if (level == 1)
  {
    if (turn==0)
      initGrid();
    showGrid();
    if (turn == 2)
      AITurn();
  } else if (level > 1)
  {
    showEnd();
  }
}
void mousePressed()
{
  if (level ==0)
  {
    menu();
  }
  if (level == 1 && turn == 1)
    playerTurn();
  if (mouseX< 20&& mouseY<20) //restart
  {
    level=1;
    turn=0;
  }
}
void keyPressed()
{
  if (key == 'x')
    exit();
  {
    if (key == 'r')
    {
      level = 0;
    }
  }
}
void initGrid()
{
  for (int i=0; i<grid. length; i++)
    grid[i]=0;
  turn=(int)random(1, 3);
}
void showGrid()
{
  background(200);
  //horizontal lines
  image(back, 0, 0, width, height);
  strokeWeight(gap/2);
  line(topX, topY+sq + gap, topX + 3*sq + 4*gap, topY + sq + gap);
  line(topX, topY+2*sq + 3*gap, topX + 3*sq + 4*gap, topY + 2*sq + 3*gap);
  //vertical lines
  line(topX+sq+gap, topY, topX+sq+gap, topY + 3*sq + 4*gap);
  line(topX+2*sq+3*gap, topY, topX+2*sq+3*gap, topY + 3*sq + 4*gap);
  //
  for (int i = 0; i<grid.length; i++)
  {
    int row = i/3;
    int col = i%3;
    if (grid[i] == 1)
      image(xImg, topX + col*sq + 2*col*gap, topY + row*sq + 2*row*gap, sq, sq);
    if (grid[i] == 2)
      image(oImg, topX + col*sq + 2*col*gap, topY + row*sq + 2*row*gap, sq, sq);
  }
}
void showMenu()
{
  image(back, 0, 0, width, height);
  textSize(30);
  for (int i=0; i<mItems.length; i++)
  {
    if (mouseX>400 && mouseX <400+200
      && mouseY>150+i*90 && mouseY<150+i*90+50)
      fill(#E30E0E);
    else fill(500);
    rect(400, 150+i*90, 200, 60, 100);
    fill(255);
    text(mItems[i], 415, 185+i*90);
  }
}
void menu()
{
  for (int i=0; i<3; i++)
  {
    if (mouseX>400 && mouseX <400+200
      && mouseY>150+i*60 && mouseY< 150+i*60+50 )
    {
      level = 1;
      turn=0;
    }
  }
}
void showEnd()
{
  showGrid();
  textSize(30);
  if (level == 2)
    text("YOU WIN!!", 700, 200);
  fill(#10FF00);
  text("PRESS X TO EXIT", 700, 400);
  text("PRESS R TO RESTART", 700, 500);
  fill(#FF0000);
  if (level == 3)
    text("LOSER", 700, 200);
  fill(#020302);
  text("PRESS X TO EXIT", 700, 400);
  text("PRESS R TO RESTART", 700, 500);
  if (level == 4)
    text("TIE", 700, 200);
  fill(#0229F7);
  text("PRESS X TO EXIT", 700, 400);
  text("PRESS R TO RESTART", 700, 500);
}
void playerTurn()
{
  //choose an empty square
  for (int i = 0; i<grid.length; i++)
  {
    int row = topY + (i/3)*sq + 2* (i/3)*gap;
    int col = topX + (i%3)*sq + 2* (i%3)*gap;
    if (grid[i] == 0 && mouseX>col && mouseX< col+sq
      && mouseY > row && mouseY < row+sq)
    {
      grid[i]=1;
      turn=2;
      if (win(1) > -1)
        level=2; //for the win
      if (level==1 && tie())
      {
        level=4;
      }
    }
  }
  //check for win
  //check for tie
  //swap turn
}
void AITurn()
{
  if (alarm == -1)
  {
    alarm = time;
    angle=0;
  } else
  {
    alarm --;
    spinIt();
  }
  if (alarm==0)
  {
    turn=1;
    alarm=-1;
    int ran = -1;
    for (int i=0; i<grid.length && ran == -1; i++)
    {
      //choose an empty square

      if (grid[i] == 0)
      {
        grid[i] = 2;
        if (win(2) > -1)
          ran= i;  //for the lose
        else
          grid[i]=0;
      }
    }
    for (int i=0; i<grid.length && ran == -1; i++)
    {
      //choose an empty square

      if (grid[i] == 0)
      {
        grid[i] = 1;
        if (win(1) > -1)
        {
          ran= i;
          grid[i]=2;
        }//for the lose
        else
          grid[i]=0;
      }
    }
    if (ran == -1)
    {
      ran = (int)random(grid. length);
      while (grid[ran] !=0)
        ran = (int)random(grid. length);
      grid[ran]=2;
    }
    if (win(2) > -1)
      level=3;
    if (level==1 && tie())
    {
      level=4;
    }
  }
}
int win (int token)
{
  for (int i=0; i<3; i++) //rows
    if (grid[i*3+0]==token && grid [i*3+1] == token && grid[i*3+2] == token)
      return i;
  for (int i=0; i<3; i++) //col
    if (grid[i+3*0]==token && grid [i+3*1] == token && grid[i+3*2] == token)
      return i+3;
  if (grid[0]==token && grid [4] == token && grid[8] == token)
    return 6;
  if (grid[2]==token && grid [4] == token && grid[6] == token)
    return 7;
  return -1;
}
boolean tie()
{
  for (int i=0; i<grid. length; i++)
    if (grid[i] == 0)
      return false;
  return true;
}
void spinIt()
{
  pushMatrix();
  imageMode(CORNER);
  translate(800, 450);
  rotate(angle);
  image(AIturnImg, -90, 1, 500, 50);
  angle+= PI/4;
  popMatrix();
}
