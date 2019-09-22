const int pingPin_1 = 7; // Trigger Pin of Ultrasonic Sensor
const int echoPin_1 = 6; // Echo Pin of Ultrasonic Sensor

const int pingPin_2 = 9; 
const int echoPin_2 = 8;
void setup() {
  pinMode(A0, INPUT); // Joystick X
  pinMode(A1, INPUT); // Joystick Y
  pinMode(A2, INPUT); // Joystick X
  pinMode(A3, INPUT); // Joystick Y
  pinMode(13, INPUT); // Button
  pinMode(12, INPUT); // Button
  


  Serial.begin(9600);
}

void loop() {

  digitalWrite(12,HIGH);
  if(digitalRead(12)==0){
  Serial.println("Enter:");
  delay(100);
  }
  digitalWrite(13,HIGH);
  if(digitalRead(13)==0){
  Serial.println("Enter:");
  delay(100);
  }
  long duration_1,duration_2,cm_1,cm_2;
   //#1
   pinMode(pingPin_1, OUTPUT);
   digitalWrite(pingPin_1, LOW);
   delayMicroseconds(2);
   digitalWrite(pingPin_1, HIGH);
   delayMicroseconds(10);
   digitalWrite(pingPin_1, LOW);
   pinMode(echoPin_1, INPUT);
   duration_1 = pulseIn(echoPin_1, HIGH);
   cm_1 = microsecondsToCentimeters(duration_1);
   
   //#2
pinMode(pingPin_2, OUTPUT);
   digitalWrite(pingPin_2, LOW);
   delayMicroseconds(2);
   digitalWrite(pingPin_2, HIGH);
   delayMicroseconds(10);
   digitalWrite(pingPin_2, LOW);
   pinMode(echoPin_2, INPUT);
   duration_2 = pulseIn(echoPin_2, HIGH);
   cm_2 = microsecondsToCentimeters(duration_2);
   
if(cm_1>0&&cm_1<5){
  Serial.println("g1_1:");
  }
  if(cm_1>=7&&cm_1<12){
  Serial.println("g2_1:");
  }
  if(cm_1>=14&&cm_1<19){
  Serial.println("g3_1:");
  }
  
if(cm_2>0&&cm_2<5){
  Serial.println("g1_2:");
  }
  if(cm_2>=7&&cm_2<12){
  Serial.println("g2_2:");
  }   
  if(cm_2>=14&&cm_2<19){
  Serial.println("g3_2:");
  }
  
   
   
   
  struct Input {
    int x;
    int y;
  };
  struct Input analogInput1, analogInput2;

  analogInput1.x = analogRead(A0);
  analogInput1.y = analogRead(A1);
  analogInput2.x = analogRead(A2);
  analogInput2.y = analogRead(A3);
//

if (analogInput1.x <= 30) {
  Serial.println("Left0:");
} else if (analogInput1.x >= 1000) {
  Serial.println("Right0:");
}

if (analogInput2.x <= 30) {
  Serial.println("Left1:");
} else if (analogInput2.x >= 1000) {
  Serial.println("Right1:");
}

if (analogInput1.y <= 20) {
  Serial.println("Up0:");
} else if (analogInput1.y >= 1000) {
  Serial.println("Down0:");
}

if (analogInput2.y <= 20) {
  Serial.println("Up1:");
} else if (analogInput2.y >= 1000) {
  Serial.println("Down1:");
}


delay(40);
}
long microsecondsToCentimeters(long microseconds) {
   return microseconds / 29 / 2;
}
