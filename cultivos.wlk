import wollok.game.*
import personaje.*

class Maiz {
	var position = game.origin()
	var faseDeEvolucion = faseBebe

	method position() { return position }
	
	method image() { return "corn_" + faseDeEvolucion.nombre() + ".png" }

	method sembrar() {
		position = hector.position()
		game.addVisual(self)
	}
}

class Trigo {
	var position = game.origin()
	var evolucion = 0

	method position() { return position }
	
	method image() { return "wheat_" + evolucion + ".png" }

	method sembrar() {
		position = hector.position()
		game.addVisual(self)
	}
}

class Tomaco {
	var position = game.origin()

	method position() { return position }
	
	method image() { return "tomaco.png" }

	method sembrar() {
		position = hector.position()
		game.addVisual(self)
	}
}

object faseBebe { method nombre() { return "baby" } }

object faseAdulta { method nombre() { return "adult" } }
