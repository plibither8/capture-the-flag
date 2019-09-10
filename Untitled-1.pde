import processing.serial.*;
import java.util.Arrays;
import java.util.List;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import javax.swing.KeyStroke;

Serial myPort;
String KeyString="";

// Array of all the mazes that the game is going to use
// A random maze is going to be chosen each time and used
// for that game
String[][] mazes = {
 {
  "11111111111111111111111111111111",
  "1                              0",
  "1 1111111 1111111111111111111 11",
  "1 1             1           1 1",
  "1 1 11111111111 11111111111 1 1",
  "1 1 1                     1 1 1",
  "1 1 1 1111111111111111111 1 1 1",
  "1 1 1 1         1       1 1   1",
  "1 1 1 1 1111111 1111111 1 1 1 1",
  "1 1 1 1 1     1       1 1 1 1 1",
  "1 1 1 1 1 11111111111 1 1 1 1 1",
  "1 1 1 1 1 1         1 1 1 1 1 1",
  "1 1 1 1 1 1 111 111 1 1 1 1 1 1",
  "1 1 1 1 1 1 1     1 1 1 1 1 1 1",
  "1 1 1 1 1 1 1 111 1 1 1 111 1 1",
  "1 1 1   1   1 121 1   1   1 1 1",
  "1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1",
  "1 1 1 1 1 1 1     1 1 1 1 1 1 1",
  "1 1 1 1 1 1 111 11111 1 1 1 1 1",
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

// Create PImage object
PImage headLogo;

// Processing setup
void setup() {
	size(840, 1010);
	frameRate(30);
	String portName = Serial.list()[0];

	myPort = new Serial(this, portName , 9600);
	myPort.bufferUntil('\n');
 // Load the image
 headLogo = loadImage("assets/logo.png");
}

// Frame refresh counter
int frameRefreshCount = 0;

// Maintains number of players that are in the game
int playerCount = 0;

// Initialise Game object
Game game = new Game("multi");

void draw() {
 // Stop the game and drawings once someone has won
 if (game.hasPlayerOne()) return;

 clear(); // Clear the board to redraw everything and update states

 background(11, 76, 244); // Shade of blue
 image(headLogo, 345, 30, 150, 150); // Draw out image
 game.draw(); // Draw all game graphics

 frameRefreshCount++;
}

void serialEvent(Serial myPort)throws Exception {
	KeyString = myPort.readStringUntil('\n');
	KeyString = KeyString.substring(0, KeyString.indexOf(':'));//takes the part of the string before the :
	System.out.println(KeyString);
	Robot Arduino = new Robot();//Constructor of robot class
	switch(KeyString){
		case "Up" :
			Arduino.keyPress(KeyEvent.VK_UP);//presses up key.
			Arduino.keyRelease(KeyEvent.VK_UP);//releases up key
			break;
		case "Down" :
			Arduino.keyPress(KeyEvent.VK_DOWN);
			Arduino.keyRelease(KeyEvent.VK_DOWN);
			break;
		case "Right" :
			Arduino.keyPress(KeyEvent.VK_RIGHT);
			Arduino.keyRelease(KeyEvent.VK_RIGHT);
			break;
		case "Left" :
			Arduino.keyPress(KeyEvent.VK_LEFT);
			Arduino.keyRelease(KeyEvent.VK_LEFT);      
			break;
   } 
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