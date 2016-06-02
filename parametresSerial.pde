void parametresSerial() {
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
  myPort = new Serial(this, portName, 9600);
}