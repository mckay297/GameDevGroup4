import gifAnimation.*; 

class Boss { 
    // 1. Member Variables
    int x, y, health;
    PImage cow1; 
    Gif loopingGif; 

    // 2. Constructor
    Boss(PApplet parent) { 
        imageMode(CENTER);
        this.x = parent.width/2;
        this.y = parent.height/2;
        this.health = 1000;
        
        this.loopingGif = new Gif(parent, "Minotaurinthemaze.gif");
        this.loopingGif.loop(); 
    }

    // 3. Member Methods
    void display(PApplet parent) {
       
        parent.image(loopingGif, this.x, this.y);
    }
}
