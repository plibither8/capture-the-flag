void setup() {
	// put your setup code here, to run once:
	pinMode(A0, INPUT);
	pinMode(A1, INPUT);
	Serial.begin(9600);
}

void loop() {
	struct Input {
		int x;
		int y;
	};

	// put your main code here, to run repeatedly:
	struct Input analogInput;

	analogInput.x = analogRead(A0);
	analogInput.y = analogRead(A1);

	switch (analogInput.x) {
		case 0:
			Serial.println("Left:");
			break;
		case 1023:
			Serial.println("Right:");
			break;
	}

	switch (analogInput.y) {
		case 0:
			Serial.println("Up:");
			break;
		case 1023:
			Serial.println("Down:");
			break;
	}

	delay(50);
}
