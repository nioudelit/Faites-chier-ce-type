void arduino() {
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
          seuil2 *= 1.1;
          seuil3 *= 1.1;
        }
        if (key == 'c') {
          seuil2 /= 1.1;
          seuil3 /= 1.1;
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
        } else if (son >= 51 && son < 55.5) {
          test = 4;
        } else if (son >= 55.5) {
          test = 5;
        } else if (int(valeurs[3]) >= seuil4) {
          test = 6;
        } else {
          test = 0;
        }
      }
    } else {
      println("capte rien !");
    }
  }
}