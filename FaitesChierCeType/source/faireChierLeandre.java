import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class faireChierLeandre extends PApplet {




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

public void setup() {
  //size(720, 405, P2D);
  
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
  println("Images\u2026 ok !!!");

  minim = new Minim(this);
  in = minim.getLineIn();
  //frameRate(52);
}

public void draw() {
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

class Animation {
  PImage[] images;
  int curseur; 
  int vitesse;
  int identifiant;

  Animation(String nom, int nombreImages, 
    int vitesseAnimation, int id) {
    images = new PImage[nombreImages];
    for (int i = 0; i < nombreImages-1; i++) {
      images[i] = loadImage(nom + i + ".jpg");
    }
    println("ok " + id);
    vitesse = vitesseAnimation;
    identifiant = id;
  }

  public void afficher(int valide) {
    if (valide == identifiant) {
      if (frameCount % vitesse == 0) {
        curseur++;
      }
      if (curseur >= images.length-1) {
        curseur = 0;
        test = 0;
      } else {
        test = valide;
      }
      image(images[curseur], width/2, height/2);
    }
  }

  public void reset(int verif) {
    if (verif != identifiant) {
      curseur = 0;
    }
  }
}
public void arduino() {
  if (myPort.available() > 0) {
    data = myPort.readStringUntil('\n');
    //println("dataaaa    ", data);
    if (data != null) {
      String valeurs[] = splitTokens(data, "$ \n");

      /*for (int i = 0; i < valeurs.length; i++) {
       println(i, int(valeurs[i]) + "end");
       }*/

      if (keyPressed) {
        if (key == 'v') {
          seuil2 *= 1.1f;
          seuil3 *= 1.1f;
        }
        if (key == 'c') {
          seuil2 /= 1.1f;
          seuil3 /= 1.1f;
        }
        if(key == 'l'){
          seuil4-=10;
        }
        if(key == 'm'){
          seuil4+=10;
        }
      }

      if (valeurs.length == 4) {
        //println(int(valeurs[3]));
        //PIEZOS !
        if (PApplet.parseInt(valeurs[0]) >= seuil1 && PApplet.parseInt(valeurs[0]) < seuil2 
          || PApplet.parseInt(valeurs[1]) >= 3 && PApplet.parseInt(valeurs[1]) < 7
          || PApplet.parseInt(valeurs[2]) >= 3 && PApplet.parseInt(valeurs[2]) < 7 ) {
          test = 1;
        } else if (PApplet.parseInt(valeurs[0]) >= seuil2 && PApplet.parseInt(valeurs[0]) < seuil3
          || PApplet.parseInt(valeurs[1]) >= 7 && PApplet.parseInt(valeurs[1]) < 10
          || PApplet.parseInt(valeurs[2]) >= 7 && PApplet.parseInt(valeurs[2]) < 10) {
          test = 2;
        } else if (PApplet.parseInt(valeurs[0]) >= seuil3
          || PApplet.parseInt(valeurs[1]) >= 10
          || PApplet.parseInt(valeurs[2]) >= 10) {
          test = 3;
        } else if (son >= 51 && son < 55.5f) {
          test = 4;
        } else if (son >= 55.5f) {
          test = 5;
        } else if (PApplet.parseInt(valeurs[3]) >= seuil4) {
          test = 6;
        } else {
          test = 0;
        }
      }
    } //else {
      //println("capte rien !");
    //}
  }
}

public void parametresSerial() {
  //CONFIGURATION ENTREES par TXT
  PrintWriter periph;
  String[] lignes;
  lignes = loadStrings("config.txt");
  int config = PApplet.parseInt(lignes[0]);
  periph = createWriter("peripheriques.txt");

  String[] ports = Serial.list();
  for (int i = 0; i < Serial.list().length; i++) {
    println(i + "     " + Serial.list()[i]);
    periph.println(i + " " + ports[i]);
  }
  periph.flush();
  periph.close();
  String portName = Serial.list()[config];
  println("port choisi: " + config);
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}
public void keyReleased() {
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
   if (key == 'u') {
    test = 6;
  }
  if (key == 'x') {
    println("tchao"); 
    noLoop(); 
    exit();
  }
}
  public void settings() {  fullScreen(P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "faireChierLeandre" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
