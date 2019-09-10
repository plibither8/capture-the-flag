const int x=A0;
const int y=A1;
void setup() {
  // put your setup code here, to run once:
pinMode(x,INPUT);
pinMode(y,INPUT);
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
int s=analogRead(x);
int s1=analogRead(y);

if(s==1023){
  Serial.println("Right:");
  }
  if(s1==1023){
    Serial.println("Down:");
    }
      if(s1==0){
    Serial.println("Up:");
    }
      if(s==0){
    Serial.println("Left:");
    }
delay(50);
}
