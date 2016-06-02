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

  void afficher(int valide) {
    if (valide == identifiant) {
      if(frameCount % vitesse == 0){
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
  
  void reset(int verif){
    if(verif != identifiant){
      curseur = 0;
    }
  }
}