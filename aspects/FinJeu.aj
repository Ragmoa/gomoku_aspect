package aspects;
import gomoku.core.Player;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

public aspect FinJeu {
	private static final ThreadLocal<Integer> ENDGAME = new ThreadLocal<Integer>();
	
	pointcut setEndGame(): call(public final void setTitle(String));
	before():setEndGame(){ // Avant le point set plus haut, on execute le code suivant
		 ENDGAME.set(0);
	}
	
	
	pointcut callGameOver(): execution(public void gameOver(Player));
	after() : callGameOver() {
		System.out.println("Fin de la partie !");
		ENDGAME.set(1);
	}
	
	pointcut stopPlaceStone(): execution(public void placeStone(int, int, Player)) && if(ENDGAME.get()==1);
	void around() : stopPlaceStone() {
		//On saute le placement de pion si la partie est finie
	}
}
