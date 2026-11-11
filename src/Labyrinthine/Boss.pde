    // David Madden
import gifAnimation.*; 
class Boss{ 
    // 1. Member Variables
    int x, y, health;
    int p;
    PImage cow1; 
    Gif loopingGif,bossGif,cowCharge,cowSmash,cowShock; 

    // 2. Constructor
    Boss(PApplet parent) { 
        imageMode(CENTER);
        this.x = parent.width/2;
        this.y = parent.height/2;
        this.health = 1000;
        this.p = p+1;
        this.loopingGif = new Gif(parent, "Minotaurinthemaze.gif");
        this.loopingGif.loop(); 
         this.bossGif = new Gif(parent, "Tour1.gif");
        this.bossGif.loop();
        this.cowCharge = new Gif(parent, "TourCharge.gif");
        this.cowSmash = new Gif(parent, "TourSmash.gif");
        this.cowShock = new Gif(parent, "TourShock.gif");
    }

    // 3. Member Methods
    void display(PApplet parent) {
      if(p>=0){ noLoop();
    }else if(p<=1) {loadImage("TourNorm.png");
    }else if(p<p+1) {this.loopingGif = new Gif(parent, "Minotaurinthemaze.gif");
        this.loopingGif.loop(); 
      } else if(p<p+2){this.bossGif = new Gif(parent, "Tour1.gif");
        this.bossGif.loop();
      }else if(p<p+3) {this.cowCharge = new Gif(parent, "TourCharge.gif");
    }else if(p<p+4) {this.cowSmash = new Gif(parent, "TourSmash.gif");
  }else if(p<p+5) {this.cowShock = new Gif(parent, "TourShock.gif");
  }
        
    }
}
