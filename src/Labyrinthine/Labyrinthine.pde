// Made by Marz Meyer, McKay Essig, David Madden, Connor DeWeerd
import gifAnimation.*;
Player p1;
Enemy e1;
Boss b1;

void setup() {
size (500,800);
p1 = new Player (100,200);
e1 = new Enemy (300,300);
b1 = new Boss(this); 
}

void draw() {
backround(127);
p1.display();
e1.display();
 b1.display(this); 
}

