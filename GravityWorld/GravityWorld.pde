/*
    This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

int nSteps = 100;
ArrayList harmonicList = new ArrayList<Harmonic>();

void setup()
{
 size(800, 600); 
}

void draw()
{
  background(0);
  
}

PVector hat( PVector input )
{
 PVector returnMe = input.get();
 returnMe.mult(1/returnMe.mag());
 return returnMe; 
}

PVector getGravitationalField( PVector pos )
{
 int numItems = harmonicList.size();
 PVector field = new PVector(0,0);
 float mass;
 PVector otherPos, r, rhat;
 for( int i = 0; i < numItems; i ++ )
 {
   mass = ((Harmonic)harmonicList.get(i)).mass;
   otherPos = ((Harmonic)harmonicList.get(i)).pos;
   r = otherPos.get();
   r.sub(pos);
   /*If this is an object that's REALLY close skip it so we don't have integration problems*/
   if( r.mag() < 0.01 )
     continue;
     
   rhat = hat(r);
   rhat.mult(-mass / (r.mag()*r.mag()));
   field.add( rhat );
 } 
 
 return field;
}

class Harmonic
{
  PVector pos, vel, accel;
  float mass;  
  boolean isClicked; //lets you move the bob
}

class Spring extends Harmonic
{
 float constant, amp;
 PVector equi;
 boolean equiClicked; // lets you move both the equilibrium
  
 Spring( float equiX, float equiY, float x, float y, float constant, float mass)
 {
   pos = new PVector(x,y);
   equi = new PVector(equiX, equiY);
   vel = new PVector(0,0);
   accel = new PVector(0,0);  
   this.constant = constant;
   this.mass = mass;
   isClicked = false;
   equiClicked = false;
 }
 
 void move()
 {
   PVector distanceVec;
   for( int i = 0; i < nSteps; i ++ )
   {
      accel.set(0,0);
      /*Get spring acceleration, distance vector from the equi to the bob times -k*/
      distanceVec = pos.get();
      distanceVec.sub(equi);
      distanceVec.mult(-constant*distanceVec.mag());
      accel = distanceVec.get();
      
      /*Get gravitational acceleration*/
      accel.add(getGravitationalField(pos));
      
      vel.add(accel.x/nSteps, accel.y/nSteps, 0);
      pos.add(vel.x/nSteps, vel.y/nSteps, 0); 
   }
 }
 
 void moveAllHarmonics()
 {
  int s = harmonicList.size();
  for( int i = 0; i < s; i ++ )
  {
   harmonicList.get(i))
  } 
 }
 
 void drawSelf()
 {
   stroke(100,20,244);
   line(pos.x, pos.y, equi.x, equi.y);
   fill(255, 100, 20);
   stroke(0);
   rect(pos.x, pos.y, 10, 10);
 }
}
