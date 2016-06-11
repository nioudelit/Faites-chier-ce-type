import processing.serial.*;
import ddf.minim.*;

//SON 
Minim minim;
AudioInput in;
float son;

//ANIMATION
int nombreAnimation = 7;
Animation[] leandre = new Animation[nombreAnimation];
int test = 0; //curseur objets

//ARDUINO
Serial myPort;
int nombreCapteurs = 4; //3 piezos, 1 photoresistance
String data;
float[] valeurs = new float[nombreCapteurs];

//SEUILS

float seuil1 = 5;
float seuil2 = 20;
float seuil3 = 40;
float seuil4 = 400;

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
  leandre[6] = new Animation("lumiere_deux-", 21, 2, 6);
  println("Images… ok !!!");

  minim = new Minim(this);
  in = minim.getLineIn();
  //frameRate(52);
}

void draw() {
  for (int i = 0; i < in.bufferSize(); i++) {
    son = map(in.mix.get(i), -1, 1, 0, 100);
  }
  for (int i = 0; i < leandre.length; i++) {
    leandre[i].reset(test);
  }
  leandre[test].afficher(test);
  if (test == 0) {
    arduino();
  }
  //println(son);
}
