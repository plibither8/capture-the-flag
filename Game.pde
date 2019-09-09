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
	}

	Game(String mode) {
		// Array of player colors in RGB int arrays
		int[][] colors = {
			{232, 210, 17},
			{255, 0, 0}
		};

		// Add the first player (for both single and multiplayer)
		players.add(new Player(selectedMaze, colors[0]));

		if (mode.equals("multi")) {
			// Add the second player (only for multi)
			players.add(new Player(selectedMaze, colors[1]));
		}
	}
}
