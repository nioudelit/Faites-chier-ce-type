import processing.serial.*;

//ANIMATION
int nombreAnimation = 6;
Animation[] leandre = new Animation[nombreAnimation];
int test = 0; //curseur objets

//CONFIGURATION ENTREES par TXT
PrintWriter periph;
String[] lignes;

//ARDUINO
Serial myPort;
int nombreCapteurs = 4; //3 piezos, 1 photoresistance
String data;
float[] valeurs = new float[nombreCapteurs];

void setup() {
  //size(720, 405, P2D);
  fullScreen(P2D);
  background(0);
  imageMode(CENTER);
  parametresSerial();
  leandre[0] = new Animation("initial_", 120, 2, 0);
  leandre[1] = new Animation("chocforceune-", 18, 2, 1);
  leandre[2] = new Animation("choc_force_deux ", 24, 2, 2);
  leandre[3] = new Animation("chocforcetrois-", 37, 2, 3);
  leandre[4] = new Animation("bruit_un-", 73, 2, 4);
  leandre[5] = new Animation("bruit_deux-", 29, 2, 5);
  println("Images… ok !!!");
  frameRate(52);
}

void draw() {
  for (int i = 0; i < leandre.length; i++) {
    leandre[i].reset(test);
  }
  leandre[test].afficher(test);
  if (test == 0) {
    arduino();
  }
}

void keyReleased() {
  if (key == 'a') {
    test = 0;
  }
  if (key == 'z') {
    test = 1;
  }
  if (key == 'e') {
    test = 2;
  }
  if (key == 'r') {
    test = 3;
  }
  if (key == 't') {
    test = 4;
  }
  if (key == 'y') {
    test = 5;
  }
  if (key == 'x') {
    println("tchao"); 
    noLoop(); 
    exit();
  }
}