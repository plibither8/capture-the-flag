// Screen class
class Screen {
	// "Press to Start" screen
	void startScreen() {
		image(headLogo, width / 2 - 200, height / 4 - 200, 400, 400);

		textFont(pixelFont); // Loaded in setup()
		textSize(90);

		// To give the blinking effect, change color mode every half-second
		if (frameRefreshCount % 30 < 15) {
			fill(232, 210, 17); // Yellow
		} else {
			fill(21, 30, 113); // Dark blue
		}

		String displayText = "Press to Start >>";
		float displayTextWidth = textWidth(displayText); // Drawn text width

		// Draw text
		text(displayText, width / 2 - displayTextWidth / 2 + 10, height * 2 / 3);
	}

	// "Select mode" screen
	void selectModeScreen() {
		image(headLogo, width / 2 - 200, height / 4 - 200, 400, 400);

		// They should be equal length strings for equal widths
		String[] modes = {"Single", "Multi "};
		textFont(pixelFont); // Loaded in setup()
		textSize(90);

		for (int i = 0; i < modes.length; i++) {
			String displayText = modes[i];

			if (gameMode == i) {
				displayText = ">> " + displayText;
				fill(232, 210, 17);
			} else {
				displayText = "   " + displayText;
				fill(255, 255, 255);
			}

			float displayTextWidth = textWidth(displayText); // Drawn text width
			// Draw text
			text(displayText, width / 2 - displayTextWidth / 2, height * 2 / 3 + i * 100);
		}
	}

	// Draw the respective screens corresponding to the current index
	void draw() {
		switch(currentScreen) {
			// Start screen
			case 0:
				startScreen();
				break;

			// Mode selection screen
			case 1:
				selectModeScreen();
				break;

			// Game play screen
			case 2:
				game.draw();
				break;
		}
	}
}
