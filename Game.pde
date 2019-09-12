// Game class
public class Game {
	// Initiating the game's maze with a random maze selected from
	// the array of mazes declared in the start
	private String[] selectedMaze = mazes[(int)(Math.random() * mazes.length)];
	private Maze mazeBoard = new Maze(selectedMaze);

	// Initiating the players
	public List<Player> players = new ArrayList<Player>();

	// Timer
	public Timer timer = new Timer();

	// Draw all game graphics
	public void draw() {
		// Draw out image
		image(headLogo, width / 2 - 75, 30, 150, 150);

		// Draw the maze
		mazeBoard.draw();
		// Rotate the inner wall
		mazeBoard.rotateInnerWall();

		// Draw each player (multiple in case of multiplayer)
		for (Player player : players) {
			player.draw();
		}

		// Draw the timer
		timer.draw();

		if (playerWon) {
			fill(0, 0, 0, 180);
			noStroke();
			rect(0, 0, width, height);
		}
	}

	// Returns boolean if player one
	public boolean hasPlayerOne() {
		for (Player player : players) {
			if (player.playerWon) return true;
		}

		return false;
	}

	Game(int mode) {
		// Array of player colors in RGB int arrays
		int[][] colors = {
			{232, 210, 17},
			{255, 0, 0}
		};

		// Add the first player (for both single and multiplayer)
		players.add(new Player(selectedMaze, colors[0]));

		if (mode == 1) {
			// Add the second player (only for multi)
			players.add(new Player(selectedMaze, colors[1]));
		}
	}
}
