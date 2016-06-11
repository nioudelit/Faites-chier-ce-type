void arduino() {
  if (myPort.available() > 0) {
    data = myPort.readString();
    //println("dataaaa    ", data);
    if (data != null) {
      String valeurs[] = split(data, "$");
      /*
      for (int i = 0; i < valeurs.length; i++) {
        println(i, int(valeurs[i]) + "end");
      }*/
      //println(valeurs.length);
      float seuil1 = 3;
      float seuil2 = 20;
      float seuil3 = 40;

      if (keyPressed) {
        if (key == 'v') {
          seuil2 *= 1.1;
          seuil3 *= 1.1;
        }
        if (key == 'c') {
          seuil2 /= 1.1;
          seuil3 /= 1.1;
        }
      }

      if (valeurs.length == 3) {
        //PIEZOS !
        if (int(valeurs[0]) >= seuil1 && int(valeurs[0]) < seuil2 
        || int(valeurs[1]) >= 3 && int(valeurs[1]) < 7
        || int(valeurs[2]) >= 3 && int(valeurs[2]) < 7 ) {
          test = 1;
        } else if (int(valeurs[0]) >= seuil2 && int(valeurs[0]) < seuil3
        || int(valeurs[1]) >= 7 && int(valeurs[1]) < 10
        || int(valeurs[2]) >= 7 && int(valeurs[2]) < 10) {
          test = 2;
        } else if (int(valeurs[0]) >= seuil3
        || int(valeurs[1]) >= 10
        || int(valeurs[2]) >= 10) {
          test = 3;
        } else {
          test = 0;
        }
      }
    } else {
      println("capte rien !");
    }
  }
}