// Timer class
class Timer {
	// Array of hexes containing ON states for each index
	private int[] nums = {0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B};

	// Start coodinates to draw the seven segment display and the colon
	private PVector startCoordinates = new PVector(250, 850);

	// Color should be solid or transparent?
	private color getColor(int val, int shift) {
		int r = 232;
		int g = 210;
		int b = 17;
		int a = 40 + 255 * ((val >> shift) & 1);
		return color(r, g, b, a);
	}

	// The seven segments setter
	void sevenSegment(int val, PVector startCoordinates) {
		pushMatrix();
		noStroke();
		noFill();

		// A
		fill(getColor(val, 6));
		rect(startCoordinates.x + 10, startCoordinates.y + 10, 40, 9);
		// B
		fill(getColor(val, 5));
		rect(startCoordinates.x + 50, startCoordinates.y + 20, 9, 49);
		// C
		fill(getColor(val, 4));
		rect(startCoordinates.x + 50, startCoordinates.y + 80, 9, 49);
		// D
		fill(getColor(val, 3));
		rect(startCoordinates.x + 10, startCoordinates.y + 130, 40, 9);
		// E
		fill(getColor(val, 2));
		rect(startCoordinates.x, startCoordinates.y + 80, 9, 49);
		// F
		fill(getColor(val, 1));
		rect(startCoordinates.x, startCoordinates.y + 20, 9, 49);
		// A
		fill(getColor(val, 0));
		rect(startCoordinates.x + 10, startCoordinates.y + 70, 40, 9);

		popMatrix();
	}

	// Timer that returns [m, m, 0, s, s] time digit array using frame refresh count
	public int[] getTimeDigits() {
		int totalSeconds = frameRefreshCount / 30;
		int minutes = totalSeconds / 60;
		int seconds = totalSeconds % 60;

		// mm formatted minute string
		String minuteString = (minutes < 10 ? "0" : "") + String.valueOf(minutes);
		// ss formatted seconds string
		String secondsString = (seconds < 10 ? "0" : "") + String.valueOf(seconds);
		// mm0ss: 0 will stand for the colon that should be drawn
		String timeString = minuteString + "0" + secondsString;

		String[] timeDigitsStrings = timeString.split("");
		int[] timeDigits = {0, 0, 0, 0, 0};

		for (int i = 0; i < timeDigitsStrings.length; i++) {
			if (i == 2) continue; // The 0 represeing the colon
			timeDigits[i] = Integer.parseInt(timeDigitsStrings[i]); // Convert the int to string
		}

		return timeDigits;
	}

	void draw() {
		int[] timeDigits = getTimeDigits();
		startCoordinates.x = 250; // Reset on each draw

		for (int i = 0; i < timeDigits.length; i++) {
			// Draw the colon if the index is 2
			if (i == 2) {
				fill(232, 210, 17);
				rect(startCoordinates.x, startCoordinates.y + 40, 20, 20);
				rect(startCoordinates.x, startCoordinates.y + 98, 20, 20);
				startCoordinates.x += 40; // Shift the drawing coords ahead
			}
			// Draw the seven-segment display if its a time digit
			else {
				sevenSegment(nums[timeDigits[i]], startCoordinates);
				startCoordinates.x += 75; // Shift the drawing coords ahead
			}
		}
	}
}
