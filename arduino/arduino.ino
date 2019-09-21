void setup() {
  pinMode(A0, INPUT); // Joystick X
  pinMode(A1, INPUT); // Joystick Y
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
  struct Input analogInput;

  analogInput.x = analogRead(A0);
  analogInput.y = analogRead(A1);
//
//  switch (analogInput.x) {
//    case 0:
//      Serial.println("Left0:");
//      break;
//    case 1023:
//      Serial.println("Right0:");
//      break;
//  }
//
//  switch (analogInput.y) {
//    case 0:
//      Serial.println("Up0:");
//      break;
//    case 1023:
//      Serial.println("Down0:");
//      break;
//  }

//  if (digitalRead(2) == LOW) {
//    Serial.println("Enter:");
//  }
}
