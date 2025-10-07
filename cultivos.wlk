import wollok.game.*
import personaje.*

class Planta {
	var property tipoDePlanta
	var position = game.origin()

	method position() { return position }

	method faseDeEvolucion() { return tipoDePlanta.faseDeEvolucion() }

	method image() { return tipoDePlanta.image() }

	method sembrar() {
		position = hector.position()
		game.addVisual(self)
	}

	method regar() { self.crecer() }

	method crecer() { 
		tipoDePlanta.faseDeEvolucion(tipoDePlanta.proximaFaseDeEvolucion()) 
	}
}

class Maiz {
	var position = game.origin()
	var property faseDeEvolucion = faseBebe
	
	method image() { return "corn_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseAdulta }
}

class Trigo {
	var property faseDeEvolucion = 0
	
	method image() { return "wheat_" + faseDeEvolucion + ".png" }

	method regar() { faseDeEvolucion = self.proximaFaseDeEvolucion() }

	method proximaFaseDeEvolucion() {
		return (faseDeEvolucion +1) * ((3 - faseDeEvolucion).max(0).min(1))
	}
}

class Tomaco {
	var property faseDeEvolucion = faseBebe
	
	method image() { return "tomaco_" + faseDeEvolucion.nombre() + ".png" }

	method regar() {
		faseDeEvolucion = faseAdulta
	}

	method proximaFaseDeEvolucion() { return faseAdulta }
}

object faseBebe { method nombre() { return "baby" } }

object faseAdulta { method nombre() { return "adult" } }
