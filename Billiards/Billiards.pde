int w = 600;
int h = w/2;
int numballs = 15;
float cornpockrad = 75;
float middlepockrad = 60;
Ball[] Balls;

void drawBoard()
{
 background(0,130,0);
 fill(0);
 ellipse(0, 0, cornpockrad, cornpockrad);
 ellipse(width,0, cornpockrad, cornpockrad);
 ellipse(width,height, cornpockrad, cornpockrad); 
 ellipse(0,height,cornpockrad,cornpockrad);
 ellipse(width/2,0,middlepockrad, middlepockrad);
 ellipse(width/2,height, middlepockrad, middlepockrad);
}

void drawBalls()
{
  int i;
  for( i = 0; i < numballs; i ++ )
  {
    if (!Balls[i].isInPocket)
      Balls[i].drawSelf();
  }
}

void moveBalls()
{
 int i;
 for ( i = 0; i < numballs; i ++ )
 {
   if(!Balls[i].isInPocket)
     Balls[i].move();
 } 
}

void checkCollisions()
{
  int i, j;
  Ball ball1, ball2;
  float phi, theta1, theta2;
  for( i = 0; i < numballs; i ++ )
  {
     ball1 = Balls[i];
     if(!ball1.isInPocket)
     {
         for( j = 0; j < numballs; j ++ )
         {
           ball2 = Balls[j];
           if(!ball2.isInPocket)
           {
            //Check to see if other ball is colliding with this one.
            //If it is, handle the collision.
             ball2 = Balls[j];
             if( dist(ball1.pos.x, ball1.pos.y, ball2.pos.x, ball2.pos.y) < ball1.rad + ball2.rad )
             {
               //If I'm going to wind up dividing by zero...don't.
               if( ball1.mom.y == 0 && ball1.mom.x > 0)
                 theta1 = 0;
               else if( ball1.mom.y == 0 && ball1.mom.x <= 0 )
                  theta1 = PI;
               else
               {
               //Not sure about arctan.
                theta1 = arctan(ball1.mom.x / ball1.mom.y);
               }
               //If I'm going to wind up dividing by zero...don't.
               if( ball2.mom.y == 0 && ball2.mom.x > 0)
                 theta2 = 0;
               else if( ball1.mom.y == 0 && ball1.mom.x <= 0 )
                  theta2 = PI;
               else
               {
               //Not sure about arctan.
                theta2 = arctan(ball2.mom.x / ball2.mom.y);
               }
             }
           }
         }
     }
  }
}

void setup()
{
  int i;
  PVector Pos = new PVector( w/4, h/2 ); //Stores the starting position of ball #1 
  size(w,h);
  drawBoard();
  fill(0);
  Balls = new Ball[numballs];
  for ( i = 0; i < numballs; i ++ )
    Balls[i] = new Ball(Pos.x, Pos.y, 0.5, 10, i);
}

void draw()
{
    drawBoard();
    drawBalls();
    checkCollisions();
    moveBalls();
}


class Ball
{
 PVector pos;
 PVector mom;
 PVector acc;
 float fric, rad;
 boolean isInPocket;
 int ballNum;
 
 Ball(float x, float y, float fric, float rad, int ballNum)
 {
  this.fric = fric;
  pos = new PVector(x, y);
  mom = new PVector(0, 0);
  acc = new PVector(0, 0);
  this.rad = rad;
  this.ballNum = ballNum;
  isInPocket = false;
 }
 
 void move()
 {
   //If I'm moving, I feel friction. 
   if(mag(mom.x, mom.y) > 0.001)
   {
     acc.x = -fric;
     acc.y = -fric; 
   }
   mom.x = mom.x + acc.x;
   mom.y = mom.y + acc.y;
   pos.x = pos.x + mom.x;
   pos.y = pos.y + mom.y;
   //Check your pockets, check your friend's pockets
   if(checkPockets())
     isInPocket = true;
 }
 
 void drawSelf()
 {
   fill(255,0,0);
   ellipse(pos.x, pos.y, rad, rad);   
 }
 
 //Check your friend's pockets!
 boolean checkPockets()
 {
  if( dist(pos.x, pos,y, 0, 0) < cornpockrad )
   return true;
  if( dist(pos.x, pos.y, 0, h) < cornpockrad )
   return true;
  if( dist(pos.x, pos.y, w, h) < cornpockrad )
    return true;
  if( dist(pos.x, pos.y, w, 0) < cornpockrad )
    return true;
  if( dist(pos.x, pos.y, w/2, 0) < middlepockrad )
    return true;
  if( dist(pos.x, pos.y, w/2, h) < middlepockrad )
    return true;
    
  return false;
 }
}
