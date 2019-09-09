// Player class
public class Player {
	private String[] rows; // Main maze array string

	private PVector position; // position vector: {x_coord, y_xoord}

	private int RADIUS = 11; // constant radius
	private int STEP_SIZE = 10; // pixels to move on each step

	private int[] backgroundRgb; // Player object's background rgb color

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
		// Unit class
		class Unit {
			public PVector position = new PVector(100, 210); // rect position
			public PVector dimensions = new PVector(0, 0); // rect dimensions
			public PVector center = new PVector(0, 0); // rect center
		}

		// Flag to check whether a collision with walls has been detected
		boolean collisionDetected = false;

		int SMALL_LENGTH = 10; // Wall pixel length
		int LARGE_LENGTH = 30; // Space pixel length

		// Unit object that will keep track of position, center and dimensions of rect
		Unit unit = new Unit();

		for (int i = 0; i < rows.length && !collisionDetected; i++) {
			unit.position.x = 100; // row-wise so start with 0 every time
			// Set current length of rect dimensions
			unit.dimensions.y = i % 2 == 1 ? LARGE_LENGTH : SMALL_LENGTH;

			for (int j = 0; j < rows[i].length(); j++) {
				// Set current length of rect dimensions
				unit.dimensions.x = j % 2 == 1 ? LARGE_LENGTH : SMALL_LENGTH;

				// Set rect center coords
				unit.center.x = unit.position.x + unit.dimensions.x / 2;
				unit.center.y = unit.position.y + unit.dimensions.y / 2;

				// Increase unit position before doing any continues
				unit.position.x += unit.dimensions.x;

				// If not '1' or not wall, skip to next iteration
				if (rows[i].charAt(j) != '1') continue;

				PVector playerDistance = new PVector(
					Math.abs(playerPosition.x - unit.center.x),
					Math.abs(playerPosition.y - unit.center.y)
				);

				if (
					playerDistance.x > (unit.dimensions.x / 2 + this.RADIUS) ||
					playerDistance.y > (unit.dimensions.y / 2 + this.RADIUS)
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

				if (cornerDistanceSq <= Math.pow(this.RADIUS, 2)) {
					collisionDetected = true;
					break;
				};
			}

			unit.position.y += unit.dimensions.y;
		}

		return collisionDetected;
	}

	// Get initial position of player by finding the "0" player
	// string from the maze array
	private PVector getInitialPosition() {
		int SMALL_LENGTH = 10; // Wall pixel length
		int LARGE_LENGTH = 30; // Space pixel length

		int playerFoundCount = 0;
		boolean playerFound = false;

		PVector activePosition = new PVector(100, 210); // Keep track of current drawing position
		PVector unitDimensions = new PVector(0, 0); // Keep track of active units' dimensions

		// Loop over maze array to find "0" player position
		for (int i = 0; i < rows.length && !playerFound; i++) {
			activePosition.x = 100; // Searching row-wise so start with 0 every time
			unitDimensions.y = i % 2 == 1 ? LARGE_LENGTH : SMALL_LENGTH;

			for (int j = 0; j < rows[i].length(); j++) {
				unitDimensions.x = j % 2 == 1 ? LARGE_LENGTH : SMALL_LENGTH;

				if (rows[i].charAt(j) == '0') {
					if (playerCount == playerFoundCount) {
						playerFound = true; // Found!

						// Set the circle center at the center of the unit
						activePosition.x += unitDimensions.x / 2;
						activePosition.y -= unitDimensions.y / 2;
						break;
					}

					playerFoundCount++; // One more player found
				}

				activePosition.x += unitDimensions.x;
			}

			activePosition.y += unitDimensions.y;
		}

		return activePosition;
	}

	// Draw the player graphics
	public void draw() {
		noStroke(); // No borders
		fill(backgroundRgb[0], backgroundRgb[1], backgroundRgb[2]);
		circle(position.x, position.y, RADIUS * 2); // 3rd argument is diameter
	}

	// Constructor that takes in the initial coords and maze
	Player(String[] maze, int[] rgb) {
		rows = maze;

		backgroundRgb = rgb;
		position = getInitialPosition();

		playerCount++;
	}
}
