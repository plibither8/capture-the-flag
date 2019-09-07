import processing.serial.*;

void setup() {
	size(700, 650);
	frameRate(30);
}

int count = 0;
int check = 0;

void draw() {
	clear();
	background(11, 76, 244);

	drawMaze(maze1);
	rotateInnerSquares(maze1);

	count++;
}

void drawMaze(String[] mazeArray) {
	int SMALL_WIDTH = 10;
	int LARGE_WIDTH = 30;

	int currentY = 0;
	for (int i = 0; i < mazeArray.length; i++) {
		String[] units = mazeArray[i].split("");

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
				circle(currentX + 12.5, currentY + 14.5, 22);
			}

			currentX += currentWidth;
		}

		currentY += currentHeight;
	}
}

void rotateInnerSquares(String[] mazeArray) {
	if (count < check + 45) {
		return;
	}

	check = count;

	String[][] INNER_SQUARES = { //<>//
		{
			"111",
			"1 1",
			"1 1"
		},
		{
			"111",
			"  1",
			"111"
		},
		{
			"1 1",
			"1 1",
			"111"
		},
		{
			"111",
			"1  ",
			"111"
		}
	};

	int BASE_INDEX = ((mazeArray.length - 1) / 2) - 1;
	String[] currentSquare = INNER_SQUARES[count % 4];

	for (int i = 0; i < currentSquare.length; i++) {
		String innerStr = currentSquare[i];
		String rowStr = mazeArray[BASE_INDEX + i];
		mazeArray[BASE_INDEX + i] =
			rowStr.substring(0, BASE_INDEX) +
			innerStr +
			rowStr.substring(BASE_INDEX + 3);
	}
}

String maze1[] = {
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
};
