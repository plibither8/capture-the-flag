void setup() {
	pinMode(A0, INPUT); // Joystick X
	pinMode(A1, INPUT); // Joystick Y
	pinMode(A2, INPUT); // Potentiometer

	Serial.begin(9600);
}

void loop() {
	struct Input {
		int x;
		int y;
	};

	struct Input analogInput;

	analogInput.x = analogRead(A0);
	analogInput.y = analogRead(A1);

	switch (analogInput.x) {
		case 0:
			Serial.println("Left0:");
			break;
		case 1023:
			Serial.println("Right0:");
			break;
	}

	switch (analogInput.y) {
		case 0:
			Serial.println("Up0:");
			break;
		case 1023:
			Serial.println("Down0:");
			break;
		}

	int potentiometerInput = analogRead(A2);

	if (potentiometerInput == 1023) {
		Serial.println("Right1:");
	}
	if (potentiometerInput == 0) {
		Serial.println("Left1:");
	}

	delay(50);
}
