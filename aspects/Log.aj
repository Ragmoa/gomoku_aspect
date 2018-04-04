package aspects;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;

import javafx.scene.paint.Color;
import javafx.stage.Stage;
import gomoku.core.*;
import gomoku.core.model.Spot;
import gomoku.ui.*;

public aspect Log {
	File f = new File("log.txt");

	pointcut setFile(): call(public final void setTitle(String));
	before(): setFile(){ // Avant le point set plus haut, on execute le code suivant
		 f.delete();
		 f = new File("log.txt");
	}
	
	pointcut logIsWonBy(Player player): call(public boolean isWonBy(Player)) && args(player);
	before(Player player) : logIsWonBy(player) {
		BufferedWriter writer;
		try {
			writer = new BufferedWriter(new FileWriter(f, true));
			writer.write(player.getName() + System.getProperty("line.separator"));
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	pointcut logPlaceStoneSpot(Spot place): call(private void notifyStonePlaced(Spot)) && args(place);
	before(Spot place) : logPlaceStoneSpot(place) {
		BufferedWriter writer;
		try {
			writer = new BufferedWriter(new FileWriter(f, true));
			writer.write(place.x + " " + place.y + " : ");
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	pointcut callGameOver(Player player): execution(public void gameOver(Player)) && args(player);
	after(Player player) : callGameOver(player) {
		BufferedWriter writer;
		try {
			writer = new BufferedWriter(new FileWriter(f, true));
			writer.write("Fin de la partie ! " + player.getName() + " est vainqueur !"+ System.getProperty("line.separator"));
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}
