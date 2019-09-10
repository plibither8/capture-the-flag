import processing.serial.*;
import java.util.Arrays;
import java.util.List;
import java.awt.AWTException;

// USB Arduino Port
Serial arduinoPort;

// Array of all the mazes that the game is going to use
// A random maze is going to be chosen each time and used
// for that game
String[][] mazes = {
	{
		"11111111111111111111111111111111",
		"1                              0",
		"1 1111111111111 1111111111111 11",
		"1 1                         1 1",
		"1 1 11111111111111111111111 1 1",
		"1 1 1         1           1 1 1",
		"1 111 11111 11111 1111111 1 1 1",
		"1 1 1 1   1   1         1   1 1",
		"1 1 1 1 11111 1111111 111 1 1 1",
		"1 1   1 1     1       1 1 1 1 1",
		"1 1 1 1 1 1111111 111 1 1 111 1",
		"1 1 1 1   1   1     1 1 1 1 1 1",
		"1 1 1 1 111 1 11111 111 1 1 1 1",
		"1   1 1     1     1   1   1   1",
		"111 111 111 1 1 1 1 111 111 111",
		"1 1 1 1 1 1 1 121 1 1 1 1 1 1 1",
		"1 111 111 111 1 1 111 111 111 1",
		"1   1 1     1     1   1   1   1",
		"1 1 1 1 111 1 11111 111 1 1 1 1",
		"1 1 1 1   1   1     1 1 1 1 1 1",
		"1 1 1 1 1 1111111 111 1 1 111 1",
		"1 1   1 1     1       1 1 1 1 1",
		"1 1 1 1 11111 1111111 111 1 1 1",
		"1 1 1 1   1   1         1   1 1",
		"1 111 11111 11111 1111111 1 1 1",
		"1 1 1         1           1 1 1",
		"1 1 11111111111111111111111 1 1",
		"1 1                         1 1",
		"1 1111111111111 1111111111111 11",
		"1                              0",
		"11111111111111111111111111111111",
	}
};

// Create PImage object
PImage headLogo;
// Create PFont object
PFont pixelFont;

// Processing setup
void setup() {
	// Get port name
	String portName = Serial.list()[0];
	// Setting arduino port
	arduinoPort = new Serial(this, portName, 9600);
	arduinoPort.bufferUntil('\n');

	// Canvas size and drawing framerate
	size(840, 1010);
	frameRate(30);

	// Load the image
	headLogo = loadImage("assets/logo.png");
	// Load the font
	pixelFont = createFont("assets/pixel-font.ttf", 32);
}

void serialEvent(Serial port) throws Exception {
	// Get output from port and take substring upto colon
	String keyString = port.readStringUntil('\n');
	keyString = keyString.substring(0, keyString.indexOf(':'));

	switch(keyString) {
		case "Up0":
			game.players.get(0).attemptMove(new PVector(0, -1));
			break;

		case "Down0":
			game.players.get(0).attemptMove(new PVector(0, 1));
			break;

		case "Right0":
			game.players.get(0).attemptMove(new PVector(1, 0));
			break;

		case "Left0":
			game.players.get(0).attemptMove(new PVector(-1, 0));
			break;

		case "Up1":
			game.players.get(1).attemptMove(new PVector(0, -1));
			break;

		case "Down1":
			game.players.get(1).attemptMove(new PVector(0, 1));
			break;

		case "Right1":
			game.players.get(1).attemptMove(new PVector(1, 0));
			break;

		case "Left1":
			game.players.get(1).attemptMove(new PVector(-1, 0));
			break;
	}
}

// Frame refresh counter
int frameRefreshCount = 0;

// Maintains number of players that are in the game
int playerCount = 0;

// Initialse Menu object
Menu menu = new Menu();

// Initialise Game object
Game game = new Game("multi");

void draw() {
	// Stop the game and drawings once someone has won
	if (game.hasPlayerOne()) return;

	clear(); // Clear the board to redraw everything and update states
	background(11, 76, 244); // Shade of blue

	// menu.draw();

	image(headLogo, 345, 30, 150, 150); // Draw out image
	game.draw(); // Draw all game graphics

	frameRefreshCount++;
}

// Create immutable list of arrow-keys' keycodes to quickly
// check for valid condition
List<Integer> directionKeys = Arrays.asList(
	UP,
	DOWN,
	RIGHT,
	LEFT,
	87,
	65,
	83,
	68
);

void keyPressed() {
	if (directionKeys.contains(keyCode)) {
		switch(keyCode) {
			case UP:
				game.players.get(0).attemptMove(new PVector(0, -1));
				break;
			case DOWN:
				game.players.get(0).attemptMove(new PVector(0, 1));
				break;
			case RIGHT:
				game.players.get(0).attemptMove(new PVector(1, 0));
				break;
			case LEFT:
				game.players.get(0).attemptMove(new PVector(-1, 0));
				break;
			case 87:
				game.players.get(1).attemptMove(new PVector(0, -1));
				break;
			case 83:
				game.players.get(1).attemptMove(new PVector(0, 1));
				break;
			case 68:
				game.players.get(1).attemptMove(new PVector(1, 0));
				break;
			case 65:
				game.players.get(1).attemptMove(new PVector(-1, 0));
				break;
		}
	}
}
