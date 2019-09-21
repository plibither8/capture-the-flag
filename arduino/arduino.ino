void setup() {
  pinMode(A0, INPUT); // Joystick X
  pinMode(A1, INPUT); // Joystick Y
  pinMode(A2, INPUT); // Joystick X
  pinMode(A3, INPUT); // Joystick Y
  pinMode(2, INPUT); // Button
  digitalWrite(2, HIGH);


  Serial.begin(9600);
}

void loop() {
  struct Input {
    int x;
    int y;
  };
digitalWrite(2, HIGH);
  struct Input analogInput1, analogInput2;

  analogInput1.x = analogRead(A0);
  analogInput1.y = analogRead(A1);
  analogInput2.x = analogRead(A2);
  analogInput2.y = analogRead(A3);
//
switch (analogInput1.x) {
case 0:
  Serial.println("Left0:");
  break;
case 1023:
  Serial.println("Right0:");
  break;
}

switch (analogInput2.x) {
case 0:
  Serial.println("Left1:");
  break;
case 1023:
  Serial.println("Right1:");
  break;
}


switch (analogInput1.y) {
case 0:
  Serial.println("Up0:");
  break;
case 1023:
  Serial.println("Down0:");
  break;
}

switch (analogInput2.y) {
case 0:
  Serial.println("Up1:");
  break;
case 1023:
  Serial.println("Down1:");
  break;
}

if (digitalRead(2) == LOW) {
Serial.println("Enter:");
}
delay(50);
}
