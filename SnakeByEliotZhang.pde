int Mode = 0; // 0 Right 1 Left 2 Down 3 Up
boolean Flag = true; // true for play false for game over
int timer = 0;
int fraq = 8; // determins the speed of this game
int scr = 0;
int w = 17;
int sizeX=800;
int sizeY=600;
PFont font;

boolean inBound(int x, int y) {
  return (x > 8 && x < 792 && y > 8 && y < 592);
}

class Food {
  int x;
  int y;
  Food() { this.generate(); }
  void generate() {
    x = (int)random(0, 45) * w + 9;
    y = (int)random(0, 34) * w + 9;
  }
  void display() {
    fill(255, 100, 160);
    rect(x, y, w, w);
  }
}

class Snake {
  int[] x = new int[200];
  int[] y = new int[200];
  int l = 0;
  int tailx;
  int taily;
  Snake() {
    this.l = 3;
    x[0] = 23 * w + 9;
    y[0] = 17 * w + 9;
    x[1] = 22 * w + 9;
    y[1] = 17 * w + 9;
    x[2] = 21 * w + 9;
    y[2] = 17 * w + 9;
  }
  void move() {
    int lasx = x[0];
    int lasy = y[0];
    int tempx;
    int tempy;
    tailx = x[l-1];
    taily = y[l-1];
    switch(Mode) {
    case 0:
      x[0] += w;
      break;
    case 1:
      x[0] -= w;
      break;
    case 2:
      y[0] += w;
      break;
    case 3:
      y[0] -= w;
      break;
    }
    for (int i = 1; i < l; ++i) {
      tempx = x[i];
      tempy = y[i];
      x[i] = lasx;
      y[i] = lasy;
      lasx = tempx;
      lasy = tempy;
    }
  }
  void judge() {
    boolean flag = false;
    int posx = x[0];
    int posy = y[0];
    if (posx == food.x && posy == food.y) {
      l++;
      scr++;
      this.x[l-1] = tailx;
      this.y[l-1] = taily;
      food.generate();
    }
    for (int i = 1; i <= l-1; ++i) {
      if ((posx == x[i] && posy == y[i]) || !inBound(x[i], y[i])) {
        flag = true;
        break;
      }
    }
    if (flag) Flag = false;
  }
  void drawBody() {
    fill(50,160,12);
    rect(x[0], y[0], w, w);
    fill(25,100,200);
    for (int i = 1; i < l; ++i)
      rect(x[i], y[i], w, w);
  }
}

void reset() {
  Mode = 0;
  Flag = true;
  scr = 0;
  snake = new Snake();
  food = new Food();
}

Snake snake = new Snake();
Food food = new Food();

void keyPressed()
{
  if (key == 'd' && Mode != 1) Mode = 0;
  if (key == 'a' && Mode != 0) Mode = 1;
  if (key == 's' && Mode != 3) Mode = 2;
  if (key == 'w' && Mode != 2) Mode = 3;
  if (key == 'r' && Flag == false) reset();
  if (key == 'e' && Flag == false) exit();
}

void setup()
{
  size(800, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  background(255, 255, 255);
  font = createFont("Arial", 16, true);
}

void draw()
{
  if (Flag) {
    timer++;
    if (timer == fraq) {
      timer = 0;
      fill(255);
      rect(sizeX/2, sizeY/2, sizeX, sizeY);
      textFont(font, 16);
      drawText("Snake!", 400, 50, 50, color(123, 13, 155));
      drawText("Developed by EliotZhang", 400, 580, 30, color(123, 123, 155));
      drawText("Score: " + scr, 750, 40, 20, color(0, 100, 200));
      food.display();
      snake.move();
      snake.judge();
      snake.drawBody();
    }
  } else {
    drawText("GameOver!", 400, 300, 100, color(255, 50, 50));
    drawText("Your final score is: " + scr + "!", 400, 350, 30, color(255, 50, 50));   
    drawText("Press 'r' to restart, 'e' to exit!", 400, 400, 30, color(255, 200, 50));    
  }
}

void drawText(String t, int x, int y, int size, color c) {
    fill(c);
    textSize(size);
    text(t, x, y);
}
