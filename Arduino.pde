void arduino() {
  if (myPort.available() > 0) {
    data = myPort.readStringUntil('\n');
    if (data != null) {
      String valeurs[] = splitTokens(data, "$ \n \r \t ");
      if (int(valeurs[0]) >= 3) {
        test = 1;
      } else {
        test = 0;
      }
    }
  }
}