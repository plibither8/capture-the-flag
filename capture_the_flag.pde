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

// Game class
public class Game {
	// Player class
	public class Player {
		private PVector position; // position vector: {x_coord, y_xoord}
		private PVector velocity = new PVector(10, 10); // velocity vector: {x_vel, y_vel}

		private int RADIUS = 11; // constant radius
		private int STEP_SIZE = 10; // pixels to move on each step

		// First check if the next move does NOT cause
		// a collision with the walls. If it doesn't
		// then procede with updating the player's position
		public void attemptMove(PVector direction) {
			PVector newPosition = new PVector(
				position.x + direction.x * STEP_SIZE,
				position.y + direction.y * STEP_SIZE
			);

			if (!detectCollision(newPosition)) {
				updatePosition(newPosition);
			}
		}

		// Update position of the player when key is pressed
		// with new position coordinates
		private void updatePosition(PVector newPosition) {
			position = newPosition;
		}

		// Collision detection between player and wall units
		// 4-stepped logic borrowed and modified into code
		// from https://stackoverflow.com/a/402010
		private boolean detectCollision(PVector playerPosition) {
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

		// Draw the player graphics
		public void draw() {
			noStroke();
			fill(232, 210, 17); // Shade of yellow
			circle(position.x, position.y, RADIUS * 2); // 3rd argument is diameter
		}

		// Constructor that takes in the initial coords
		Player(PVector initialPosition) {
			position = initialPosition;
		}
	}

	// Wall Unit Class
	public class WallUnit {
		private PVector position; // rect position
		public PVector dimensions; // rect dimensions
		public PVector center; // rect center

		WallUnit(PVector position, PVector dimensions) {
			this.position = position;
			this.dimensions = dimensions;
			center = new PVector(
				position.x + dimensions.x / 2,
				position.y + dimensions.y / 2
			);
		}
	}

	// Maze class
	public class Maze {
		// The main "maze array" containing the string
		// of rows with '1's for walls
		private String[] rows;

		// Draw the maze with respect to the row strings
		public void draw() {
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
						wallUnits.add(new WallUnit(
							new PVector(currentX, currentY),
							new PVector(currentWidth, currentHeight)
						));
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
		public void rotateInnerWall() {
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

	// Initiating the player
	public Player player;

	// Array of wall rects
	private List<WallUnit> wallUnits = new ArrayList<WallUnit>();

	// Initiating the game's maze with a random maze selected from
	// the array of mazes declared in the start
	private String[] randomMaze = mazes[(int)(Math.random() * mazes.length)];
	private Maze maze = new Maze(randomMaze);

	// Timer that returns mm:ss time using frame refresh count
	public String timer() {
		int totalSeconds = frameRefreshCount / 30;
		int minutes = totalSeconds / 60;
		int seconds = totalSeconds % 60;

		String minuteString = (minutes < 10 ? "0" : "") + String.valueOf(minutes);
		String secondsString = (seconds < 10 ? "0" : "") + String.valueOf(seconds);
		String timeString = minuteString + ":" + secondsString;

		return timeString;
	}

	public void draw() {
		background(11, 76, 244); // Shade of blue

		maze.draw(); // Draw the maze
		maze.rotateInnerWall(); // Rotate the inner wall
		player.draw(); // Draw the player
	}
}

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
