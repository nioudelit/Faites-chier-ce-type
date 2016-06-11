void parametresSerial() {
  //CONFIGURATION ENTREES par TXT
  PrintWriter periph;
  String[] lignes;
  lignes = loadStrings("config.txt");
  int config = int(lignes[0]);
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