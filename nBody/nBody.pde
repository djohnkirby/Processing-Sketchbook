//Copyright 2013
//D. John Kirby

int simNum = 1;
float[] CoM;
Ball[] ballList;
float scaleFactor = 1.0;

void setup()
{
  size(1280,760);
  smooth();
  if (simNum ==0)
  {
    //Just a bunch of dumb balls
    ballList = new Ball[5];
    for( int i = 0; i < ballList.length; i ++)
    {
     if (simNum == 0)
     {
       float mass = random(100,1000);
       ballList[i] = new Ball( random(width), random(height), random(5), random(5),
        color(random(255),random(255),random(255)), (int)mass/10,mass); 
     }
    }
  }
  else if(simNum == 1)
  {
    //Basic solar system
   ballList = new Ball[3];
   ballList[0] = new Ball(width/2, height/2, 0, 0, color(255,255,0), 50, 3*1000);
   ballList[1] = new Ball(width/2,0.65*height+10, 3.5, 0, color(0,0,255), 30, 10); 
   ballList[2] = new Ball(width/2,0.80*height, 3,0, color(255,0,0), 25, 10);
  }
  else if(simNum ==2)
  {
   //That's no Moon!
   ballList = new Ball[4]; 
   ballList[0] = new Ball(width/2, height/2, 0, 0, color(255,255,0), 75, 3*10^10000);
   ballList[1] = new Ball(0.75*width, height/2,0,-6.5, color(205,183,158),25,10^100);
   ballList[2] = new Ball(0.75*width-15, height/2,0,-4.5, color(255,255,255),5,1);
   ballList[3] = new Ball(width/2,0.8*height,4,0,color(255,0,0),25,10);
  }
  else if(simNum == 3)
  {
    //Binary Star System
   ballList = new Ball[2];
   ballList[0] = new Ball(width/2-100, height/2, 0, 1.5, color(255,255,0), 75, 10^1000);
   ballList[1] = new Ball(width/2+100, height/2, 0, -1.5, color(255,255,0), 75, 10^1000);
  }
  else if(simNum ==4)
  {
    //It's a space station!
    ballList = new Ball[5];
   ballList[0] = new Ball(width/2-100, height/2, 0, 1.5, color(255,255,0), 30, 10^1000);
   ballList[1] = new Ball(width/2+100, height/2, 0, -1.5, color(255,255,0), 30, 10^1000);
   ballList[2] = new Ball(width/2-150, height/2, 0, 4.75, color(0,0,255),15, 1);
   ballList[3] = new Ball(width/2+150, height/2, 0, 3.25, color(255,0,0), 15,1);  
   ballList[4] = new Ball(width/2-350, height/2, 0, 2.5, color(0,255,0),15, 1);
  }
  else if (simNum == 5)
  {
    
    //Orbit they Barry Center
     ballList = new Ball[3];
     ballList[0] = new Ball(width/2-100, height/2, 0, 1.5, color(255,255,0), 75, 10^1000);
     ballList[1] = new Ball(width/2+100, height/2, 0, -1.5, color(255,255,0), 75, 10^1000);
     ballList[2] = new Ball(width/2-350, height/2, 0, 2.5, color(0,0,255),15, 1);

  }
  else if (simNum == 6)
  {
    
    //This one is borken
     ballList = new Ball[3];
     ballList[0] = new Ball(width/2-100, height/2, 0, 1.5, color(255,255,0), 75, 10^1000);
     ballList[1] = new Ball(width/2+100, height/2, 0, -1.5, color(255,255,0), 75, 10^1000);
     ballList[2] = new Ball(width/2-250, height/2, 0, 3, color(0,0,255),15, 1);

  }
  else if (simNum == 7)
  {
  //It's a space station!
    ballList = new Ball[3];
   ballList[0] = new Ball(width/2-100, height/2, 0, 0, color(255,255,0), 30, 10^10000);
   ballList[1] = new Ball(width/2+100, height/2, 0, -6, color(255,255,0), 30, 10^1000);
   //ballList[2] = new Ball(width/2-150, height/2, 0, 4.75, color(0,0,255),15, 1);
  }
}

void draw()
{
 background(0);
 CoM = findCoM(ballList);
 //translate(-CoM[0],0);
 pushMatrix();
   translate(-width/2*scaleFactor+CoM[0],-height/2*scaleFactor+CoM[1]);
  // print(CoM[0]+", "+CoM[1]+"\n");
   scale(scaleFactor);
 popMatrix();
// scale(scaleFactor);
  for( int j =0; j < ballList.length; j= j + 1)
 {
//   print("handling ball $"+i+"\n");
    if( ballList[j] != null)
    {
     // print("handlingy ball # "+ i);
      (ballList[j]).display();
      (ballList[j]).move(ballList); 
    }
  }
}

void mouseWheel(MouseEvent event)
{
  // scaleFactor += event.getAmount()/10;
}

float[] findCoM(Ball[] ballList)
{
  float[] CoM = {0,0};
  float mass = 0;
  for( int i=0; i< ballList.length; i++)
  {
    if (ballList[i] == null)
      continue;
    CoM[0] = CoM[0] + ballList[i].xpos*ballList[i].mass;
    CoM[1] = CoM[1] + ballList[i].ypos*ballList[i].mass;
    mass = mass + ballList[i].mass;
  } 
  CoM[0] = CoM[0]/mass;
  CoM[1] = CoM[1]/mass;
  
  return CoM;
}

class Ball
{
 float xpos;
 float ypos;
 float xvel;
 float yvel; 
 float rad;
 float fric;
 float gravy = 20000;
 color col;
 float mass;
  float gravityFeltX = 0;//Actually has units of accelleration
  float gravityFeltY = 0;//Actually has units of accelleration
  float gravityFelt = 0;

 Ball(float xin, float yin, float xvin, float yvin, color col, int rad, float mass)
 {
  xpos = xin;
  ypos = yin;
  xvel = xvin;
  yvel = yvin; 
  this.rad = rad;
  this.col = col;
  this.mass = mass;
 
  }
 
 void display()
 {
  fill(col);
  ellipse(xpos,ypos,rad,rad); 
 }
 
 void move(Ball[] ballList)
 {
   if(simNum == 0)
   {
     if ( (xpos > width)|| (xpos <0))
       xvel = -xvel;
     if (ypos > height || (ypos < 0))
       yvel = -yvel;
   }
   
   xpos = xpos + xvel;
   ypos = ypos + yvel;
   for( int i = 0; i < ballList.length; i++)
   {
     //If I'm looking at myself just hop to the next one.
     if(ballList[i] == null)
       continue;
     if((abs(ballList[i].xpos - xpos) < 1) && (abs(ballList[i].ypos - ypos) < 1))
       continue;
     gravityFelt = ballList[i].mass/pow(dist(xpos,ypos,ballList[i].xpos,ballList[i].ypos),3);
     gravityFeltX = gravityFeltX +  gravityFelt*(xpos-ballList[i].xpos);
     gravityFeltY = gravityFeltY + gravityFelt*(ypos-ballList[i].ypos);
   }
   xvel = xvel - gravityFeltX;
   yvel = yvel - gravityFeltY;

 }
}
