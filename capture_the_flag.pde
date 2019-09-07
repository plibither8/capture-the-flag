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

// Player class
class Player {
	PVector position; // position vector: {x_coord, y_xoord}
	PVector velocity = new PVector(10, 10); // velocity vector: {x_vel, y_vel}

	int RADIUS = 11; // constant radius
	int STEP_SIZE = 10; // pixels to move on each step

	// First check if the next move does NOT cause
	// a collision with the walls. If it doesn't
	// then procede with updating the player's position
	void attemptMove(int directionX, int directionY) {
		PVector newPosition = new PVector(
			position.x + directionX * STEP_SIZE,
			position.y + directionY * STEP_SIZE
		);

		if (!detectCollision(newPosition)) {
			updatePosition(newPosition);
		}
	}

	// Update position of the player when key is pressed
	// with new position coordinates
	void updatePosition(PVector newPosition) {
		position = newPosition;
	}

	// Draw the player graphics
	void draw() {
		noStroke();
		fill(232, 210, 17); // Shade of yellow
		circle(position.x, position.y, RADIUS * 2); // 3rd argument is diameter
	}

	// Collision detection between player and wall units
	// 4-stepped logic borrowed and modified into code
	// from https://stackoverflow.com/a/402010
	boolean detectCollision(PVector playerPosition) {
		boolean collisionDetected = false;

		for (WallUnit unit : wallUnits) {
			PVector playerDistance = new PVector(
				Math.abs(playerPosition.x - unit.center.x),
				Math.abs(playerPosition.y - unit.center.y)
			);

			if (
				playerDistance.x > (unit.dimensions.x / 2 + player.RADIUS) ||
				playerDistance.y > (unit.dimensions.y / 2 + player.RADIUS)
			) {
				continue;
			}

			if (
				playerDistance.x <= (unit.dimensions.x / 2) ||
				playerDistance.y <= (unit.dimensions.y / 2)
			) {
				collisionDetected = true;
				break;
			}

			double cornerDistanceSq =
				Math.pow(playerDistance.x - unit.dimensions.x / 2, 2) +
				Math.pow(playerDistance.y - unit.dimensions.y / 2, 2);

			if (cornerDistanceSq <= Math.pow(player.RADIUS, 2)) {
				collisionDetected = true;
				break;
			};
		}

		return collisionDetected;
	}

	// Constructor that takes in the initial coords
	Player(PVector initialPosition) {
		position = initialPosition;
	}
}

// Wall Unit Class
class WallUnit {
	PVector position; // rect position
	PVector dimensions; // rect dimensions
	PVector center; // rect center

	WallUnit(float x_coord, float y_coord, float width, float height) {
		position = new PVector(x_coord, y_coord);
		dimensions = new PVector(width, height);
		center = new PVector(
			x_coord + width / 2,
			y_coord + height / 2
		);
	}
}

// Maze class
class Maze {
	// The main "maze array" containing the string
	// of rows with '1's for walls
	String[] rows;

	// Draw the maze with respect to the row strings
	void draw() {
		// Empty out/clear the wall units since they are
		// dynamically created and changing (inner walls)
		wallUnits.clear();

		int SMALL_WIDTH = 10; // Wall width
		int LARGE_WIDTH = 30; // Space width

		// Current drawing y coordinate
		int currentY = 0; 
		for (int i = 0; i < rows.length; i++) {
			// Split the row string into an array and then
			// draw out for each unit repectively
			String[] units = rows[i].split("");

			// Current drawing x coordinate
			int currentX = 0;
			// Current row's rects' height
			int currentHeight = i % 2 == 1 ? LARGE_WIDTH : SMALL_WIDTH;

			for (int j = 0; j < units.length; j++) {
				String unit = units[j].trim();
				// Current row's rects' height
				int currentWidth = j % 2 == 1 ? LARGE_WIDTH : SMALL_WIDTH;

				// Draw the wall if the unit is "1" and
				// push WallUnit unit to wallUnits list
				if (unit.equals("1")) {
					fill(21, 30, 113);
					noStroke();
					rect(currentX, currentY, currentWidth, currentHeight);

					// Add wall unit to the array
					wallUnits.add(new WallUnit(currentX, currentY, currentWidth, currentHeight));
				}

				// Initiate the player graphic if the unit is "0"
				// and the unit has not already been initiated
				if (unit.equals("0") && player == null) {
					PVector playerInitialPosition = new PVector(
						currentX + LARGE_WIDTH / 2,
						currentY + LARGE_WIDTH / 2
					);
					player = new Player(playerInitialPosition);
				}

				// Shift the drawing x coordinate right
				currentX += currentWidth;
			}

			// Shift the drawing y coordinate bottom
			currentY += currentHeight;
		}
	}

	// Rotate inner most walls
	void rotateInnerWall() {
		// Rotate every 1.5 seconds (45 / 30 = 1.5)
		if (frameRefreshCount % 45 != 0) {
			return;
		}

		// Array of string arrays containing the inner wall states
		String[][] INNER_WALL_STATES = {
			{
				"111",
				"1 1",
				"1 1"
			}, {
				"111",
				"  1",
				"111"
			}, {
				"1 1",
				"1 1",
				"111"
			}, {
				"111",
				"1  ",
				"111"
			}
		};

		int BASE_INDEX = ((rows.length - 1) / 2) - 1; // Index to start editing
		String[] currentState = INNER_WALL_STATES[frameRefreshCount % 4]; // State selection

		// Looping over each string of the selected state and editing it
		for (int i = 0; i < currentState.length; i++) {
			String innerStr = currentState[i];
			String rowStr = rows[BASE_INDEX + i]; // main maze array's corresponding row string
			// Editing the string with updated inner string
			rows[BASE_INDEX + i] =
				rowStr.substring(0, BASE_INDEX) +
				innerStr +
				rowStr.substring(BASE_INDEX + innerStr.length());
		}
	}

	// Constructor
	Maze(String[] rows) {
		this.rows = rows;
	}
}

// Processing setup
void setup() {
	size(700, 650);
	frameRate(30);
}

// Initiating the player
Player player;

// Array of wall rects
List<WallUnit> wallUnits = new ArrayList<WallUnit>();

// Initiating the game's maze with a random maze selected from
// the array of mazes declared in the start
String[] randomMaze = mazes[(int)(Math.random() * mazes.length)];
Maze gameMaze = new Maze(randomMaze);

// Frame refresh counter
int frameRefreshCount = 0;

void draw() {
	clear(); // Clear the board to redraw everything and update states
	background(11, 76, 244); // Shade of blue

	gameMaze.draw(); // Draw the maze
	gameMaze.rotateInnerWall(); // Rotate the inner wall
	player.draw(); // Draw the player

	frameRefreshCount++;
}

// Create immutable list of arrow-keys' keycodes to quickly
// check for valid condition
List<Integer> arrowKeyCodes = Arrays.asList(UP, DOWN, RIGHT, LEFT);

void keyPressed() {
	if (key == CODED && arrowKeyCodes.contains(keyCode)) {
		switch(keyCode) {
			case UP:
				player.attemptMove(0, -1);
				break;
			case DOWN:
				player.attemptMove(0, 1);
				break;
			case RIGHT:
				player.attemptMove(1, 0);
				break;
			case LEFT:
				player.attemptMove(-1, 0);
				break;
		}
	}
}
