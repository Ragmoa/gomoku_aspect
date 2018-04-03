package aspects;

import gomoku.core.*;
import gomoku.ui.*;
import javafx.stage.*;
import javafx.scene.paint.Color;

public aspect Player2 {
	//Pour stocker la variable de tour
	private static final ThreadLocal<Integer> CURRENT = new ThreadLocal<Integer>();
	
	// On cherche le moment o� il set le titre de la fen�tre.
	pointcut playercreation(Stage mainstage): (target(mainstage) && call(public final void setTitle(String)));
	
	//On change le tour et/ou le player en fonction du tour
	pointcut gettingplayerturn0(): execution(private Player getCurrentPlayer()) && if(CURRENT.get()==0);
	pointcut gettingplayerturn1(): execution(private Player getCurrentPlayer()) && if(CURRENT.get()==1);
	
	before(Stage mainstage):playercreation(mainstage){ // Avant le point set plus haut, on execute le code suivant
		 CURRENT.set(1);
	}
	
	Player around(): gettingplayerturn0(){
		CURRENT.set(1);
		System.out.println("0");
		return new Player ("Mr. Red",Color.RED);	
	}
	
	//Pas around parce qu'il faudrait sp�cifier un player en return
	//Pas after, sinon l'autre pointcut est d�clench� et on ne change jamais de joueur
	before(): gettingplayerturn1(){
		System.out.println("1");
		CURRENT.set(0);
	}
}
