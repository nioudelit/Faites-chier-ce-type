const int in0 = A0;
const int in1 = A1;
const int in2 = A2;
const int in3 = A5;

int piezo0 = 0;
int piezo1 = 0;
int piezo2 = 0;
int lumi = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  piezo0 = analogRead(in0);
  piezo1 = analogRead(in1);
  piezo2 = analogRead(in2);
  lumi = analogRead(in3);
  
  //Serial.write(piezo0);
  Serial.print(piezo0);
  Serial.print("$");

  
  //Serial.write(piezo1);
  Serial.print(piezo1);
  Serial.print("$");

  
  //Serial.write(piezo2);
  Serial.print(piezo2);
  Serial.print("$");

  //Serial.write(piezo2);
  Serial.print(lumi);
  delay(100);//120
  Serial.print('\n');
  delay(50);
  
  
}
