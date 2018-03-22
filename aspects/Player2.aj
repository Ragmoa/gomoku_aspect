package aspects;

import gomoku.core.*;
import gomoku.ui.*;
import javafx.stage.*;
import javafx.scene.paint.Color;

public aspect Player2 {
	
	pointcut playercreation(Stage mainstage): (target(mainstage) && call(public final void setTitle(String)));// On cherche le moment où il set le titre de la fenêtre.
	
	pointcut gettingplayer (Player Popeye, Player secondplayer, int turn):(call(private Player getCurrentPlayer()));
	
	before(Stage mainstage):playercreation(mainstage){ // Avant le point set plus haut, on execute le code suivant
		 Player secondplayer=new Player ("Mr. Red",Color.RED);
		 int turn=1;
	}
	
	Player around(Player Popeye, Player secondplayer, int turn): gettingplayer(Popeye,secondplayer,turn){
		if (turn==1) {
			turn++;
			return secondplayer;
		} else {
			turn=1;
			return Popeye;
		}
		
	}
}
