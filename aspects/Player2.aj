package aspects;

import gomoku.core.*;
import gomoku.ui.*;
import javafx.stage.*;
import javafx.scene.paint.Color;

public aspect Player2 {
	
	pointcut playercreation(Stage mainstage): (target(mainstage) && call(public final void setTitle(String)));// On cherche le moment o� il set le titre de la fen�tre.
	
	
	before(Stage mainstage):playercreation(mainstage){ // Avant le point set plus haut, on execute le code suivant
		 Player secondplayer=new Player ("Mr. Red",Color.RED);
		 System.out.println("COUCOU FDP");
	}
	
}
