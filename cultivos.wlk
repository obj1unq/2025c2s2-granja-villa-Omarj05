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

	method cosechar() {
		if (tipoDePlanta.estaListaParaCosechar()) {
			game.removeVisual(self)
		}
	}
}

class Maiz {
	var position = game.origin()
	var property faseDeEvolucion = faseBebe
	
	method image() { return "corn_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseAdulta }

	method estaListaParaCosechar() { return faseDeEvolucion == faseAdulta }
}

class Trigo {
	var property faseDeEvolucion = 0
	
	method image() { return "wheat_" + faseDeEvolucion + ".png" }

	method proximaFaseDeEvolucion() {
		return (faseDeEvolucion +1) * ((3 - faseDeEvolucion).max(0).min(1))
	}

	method estaListaParaCosechar() { return faseDeEvolucion >= 2 }
}

class Tomaco {
	/*ACLARACION: 
		Quise hacerlo con fase bebe y fase adulta pero si se desea que siempre esté
		en fase	adulta hay que cambiar la variable faseDeEvolucion por una constante 
		en faseAdulta.
	*/
	var property faseDeEvolucion = faseBebe
	
	method image() { return "tomaco_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseAdulta }

	method estaListaParaCosechar() { return faseDeEvolucion == faseAdulta }
}

object faseBebe { method nombre() { return "baby" } }

object faseAdulta { method nombre() { return "adult" } }
