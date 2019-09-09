import processing.serial.*;
import java.util.Arrays;
import java.util.List;

// Array of all the mazes that the game is going to use
// A random maze is going to be chosen each time and used
// for that game
String[][] mazes = {
	{
		"1111111111111111111111111111111",
		"1                             1",
		"1 1111111 1111111111111111111 1",
		"1 1       1                 1 1",
		"1 1 111111111111111 1111111 1 1",
		"1 1 1                     1 1 1",
		"1 1 1 1111111111111111111 1 1 1",
		"1 1 1 1         1       1 1 1 1",
		"1 1 1 1 1111111 1111111 1 1 1 1",
		"1 1 1 1 1           1 1 1   1 1",
		"1 1 1 1 1 11111111111 1 1 1 1 1",
		"1 1 1 1 1 1   1     1 1 1 1 1 1",
		"1 1 1 1 1 1 111 111 1 1 1 1 1 1",
		"1 1 1 1 1 1 1     1 1 1 1 1 1 1",
		"1 1 111 1 1 1 111 1 1 1 111 1 1",
		"1 1 1   1   1 1 1 1   1   1 1 1",
		"1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1",
		"1 1 1 1 1 1 1     1 1 1 1 1 1 1",
		"1 1 1 1 1 1 111111111 1 1 1 1 1",
		"1 1 1 1 1 1         1 1 1 1 1 1",
		"1 1 1 1 1 11111111111 1 1 1 1 1",
		"1 1 1 1 1     1       1 1 1 1 1",
		"1 1 1 1 1111111 1111111 1 1 1 1",
		"1 1 1 1         1       1 1   1",
		"1 1 1 1111111111111111111 1 1 1",
		"1 1 1                     1 1 1",
		"1 1 11111111111 11111111111 1 1",
		"1 1             1           1 1",
		"1 111111111111111111111111111 11",
		"1                              0",
		"11111111111111111111111111111111",
	}
};

// Processing setup
void setup() {
	size(700, 650);
	frameRate(30);
}

// Frame refresh counter
int frameRefreshCount = 0;

// Initialise Game object
Game game = new Game();

void draw() {
	clear(); // Clear the board to redraw everything and update states

	game.draw(); // Draw all game graphics

	frameRefreshCount++;
}

// Create immutable list of arrow-keys' keycodes to quickly
// check for valid condition
List<Integer> arrowKeyCodes = Arrays.asList(UP, DOWN, RIGHT, LEFT);

void keyPressed() {
	if (key == CODED && arrowKeyCodes.contains(keyCode)) {
		switch(keyCode) {
			case UP:
				game.player.attemptMove(new PVector(0, -1));
				break;
			case DOWN:
				game.player.attemptMove(new PVector(0, 1));
				break;
			case RIGHT:
				game.player.attemptMove(new PVector(1, 0));
				break;
			case LEFT:
				game.player.attemptMove(new PVector(-1, 0));
				break;
		}
	}
}
