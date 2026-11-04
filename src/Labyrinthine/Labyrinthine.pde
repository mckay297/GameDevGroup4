// Made by Marz Meyer, McKay Essig, David Madden, Connor DeWeerd
Player p1;
Enemy e1;

void setup() {
size (500,800);
p1 = new Player (100,200);
e1 = new Enemy (300,300);
}

void draw() {
backround(127);
p1.display();
e1.display();
}

