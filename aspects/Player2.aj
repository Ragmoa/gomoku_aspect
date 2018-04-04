package aspects;

import gomoku.core.*;
import gomoku.ui.*;
import javafx.stage.*;
import javafx.scene.paint.Color;

public aspect Player2 {
	//Pour stocker la variable de tour
	private static final ThreadLocal<Integer> CURRENT = new ThreadLocal<Integer>();
	private static final ThreadLocal<Player> PLAYER = new ThreadLocal<Player>();
	
	// On cherche le moment où il set le titre de la fenêtre.
	pointcut playercreation(Stage mainstage): (target(mainstage) && call(public final void setTitle(String)));
	before(Stage mainstage):playercreation(mainstage){ // Avant le point set plus haut, on execute le code suivant
		 CURRENT.set(1);
		 PLAYER.set(new Player ("Mr. Red",Color.RED));
	}
	
	//On change le tour et/ou le player en fonction du tour
	pointcut gettingplayerturn0(): execution(private Player getCurrentPlayer()) && if(CURRENT.get()==0);
	Player around(): gettingplayerturn0(){
		CURRENT.set(1);
		return PLAYER.get();
	}
	
	//Pas around parce qu'il faudrait spécifier un player en return
	//Pas after, sinon l'autre pointcut est déclenché et on ne change jamais de joueur
	pointcut gettingplayerturn1(): execution(private Player getCurrentPlayer()) && if(CURRENT.get()==1);
	before(): gettingplayerturn1(){
		CURRENT.set(0);
	}
}
