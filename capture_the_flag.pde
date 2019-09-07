import processing.serial.*;

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

class Player {
	PVector position;
	PVector velocity;

	float radius = 22;

	Player(float x, float y) {
		position = new PVector(x, y);
		velocity = new PVector(x, y);
	}

	void updatePosition(float x, float y) {
		position = new PVector(x, y);
	}

	void draw() {
		noStroke();
		fill(232, 210, 17);
		circle(position.x, position.y, radius);
	}
}

class Maze {
	String[] rows;

	void draw() {
		int SMALL_WIDTH = 10;
		int LARGE_WIDTH = 30;

		int currentY = 0;
		for (int i = 0; i < rows.length; i++) {
			String[] units = rows[i].split("");

			int currentX = 0;
			int currentHeight = i % 2 == 1 ? LARGE_WIDTH : SMALL_WIDTH;

			for (int j = 0; j < units.length; j++) {
				String unit = units[j].trim();
				int currentWidth = j % 2 == 1 ? LARGE_WIDTH : SMALL_WIDTH;

				if (unit.equals("1")) {
					fill(21, 30, 113);
					noStroke();
					rect(currentX, currentY, currentWidth, currentHeight);
				}

				if (unit.equals("0")) {
					fill(232, 210, 17);
					player = new Player(currentX + 12.5, currentY + 14.5);
				}

				currentX += currentWidth;
			}

			currentY += currentHeight;
		}
	}

	void rotateInnerSquares() {
		if (frameRefreshCount % 45 != 0) {
			return;
		}

		String[][] INNER_SQUARES = {
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

		int BASE_INDEX = ((rows.length - 1) / 2) - 1;
		String[] currentSquare = INNER_SQUARES[frameRefreshCount % 4];

		for (int i = 0; i < currentSquare.length; i++) {
			String innerStr = currentSquare[i];
			String rowStr = rows[BASE_INDEX + i];
			rows[BASE_INDEX + i] =
				rowStr.substring(0, BASE_INDEX) +
				innerStr +
				rowStr.substring(BASE_INDEX + 3);
		}
	}

	Maze(String[] rows) {
		this.rows = rows;
	}
}


void setup() {
	size(700, 650);
	frameRate(30);
}

Player player;
Maze gameMaze = new Maze(mazes[(int)(Math.random() * mazes.length)]);

int frameRefreshCount = 0;

void draw() {
	clear();
	background(11, 76, 244);

	gameMaze.draw();
	gameMaze.rotateInnerSquares();
	player.draw();

	frameRefreshCount++;
}

