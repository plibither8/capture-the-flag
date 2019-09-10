// Menu class
class Menu {
	// Start pressed?
	private boolean startPressed = false;

	// Mode selected?
	private boolean modeSelected = false;
	private int selectedMode = 0;

	// "Press to Start" screen
	void startScreen() {
		image(headLogo, 220, 100, 400, 400);

		textFont(pixelFont); // Loaded in setup()
		textSize(90);

		// To give the blinking effect, change color mode every half-second
		if (frameRefreshCount % 30 < 15) {
			fill(232, 210, 17); // Yellow
		} else {
			fill(21, 30, 113); // Dark blue
		}
		text("Press to Start >>", 125, 750);
	}

	// "Select mode" screen
	void selectMode() {
		image(headLogo, 220, 100, 400, 400);

	}

	void draw() {
		// "Press to Start" screen
		if (!startPressed) {
			startScreen();

			// Exit
			return;
		}

		// "Select mode" screen
		if (!modeSelected) {
			selectMode();

			// Exit
			return;
		}
	}
}
