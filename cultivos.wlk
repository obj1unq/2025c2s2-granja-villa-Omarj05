import wollok.game.*
import personaje.*

class Planta {
	var property tipoDePlanta
	var position = hector.position()
	const property valor = tipoDePlanta.valor()

	method valor() { return tipoDePlanta.valor() }

	method position() { return position }

	method faseDeEvolucion() { return tipoDePlanta.faseDeEvolucion() }

	method image() { return tipoDePlanta.image() }

	method sembrar() {
		plantas.agregarPlantaAlJuego(self)
	}

	method regar() { self.crecer() }

	method crecer() { 
		tipoDePlanta.faseDeEvolucion(tipoDePlanta.proximaFaseDeEvolucion()) 
	}

	method cosechar() {
		if (tipoDePlanta.estaListaParaCosechar()) {
			plantas.eliminarPlantaDelJuego(self)
		}
	}
}	

class Maiz {
	var property faseDeEvolucion = faseBebe
	
	method valor() { return 150 }

	method image() { return "corn_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseAdulta }

	method estaListaParaCosechar() { return faseDeEvolucion == faseAdulta }
}

class Trigo {
	var property faseDeEvolucion = estadoInicial
	
	method valor() { return (faseDeEvolucion.nivelDelEstado() -1) * 100 }
	
	method image() { return "wheat_" + faseDeEvolucion.nivelDelEstado() + ".png" }

	method proximaFaseDeEvolucion() { return faseDeEvolucion.proximaFase() }

	method estaListaParaCosechar() { return faseDeEvolucion >= 2 }
}

//(faseDeEvolucion +1) * ((3 - faseDeEvolucion).max(0).min(1))

class Tomaco {
	/*ACLARACION: 
		Quise hacerlo con fase bebe y fase adulta pero si se desea que siempre esté
		en fase	adulta hay que cambiar la variable faseDeEvolucion por una constante 
		en faseAdulta.
	*/
	var property faseDeEvolucion = faseBebe

	method valor() { return 80 }
	
	method image() { return "tomaco_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseAdulta }

	method estaListaParaCosechar() { return faseDeEvolucion == faseAdulta }
}

//estados del trigo
object estadoInicial {
	method proximaFase() { return segundoEstado }

	method nivelDelEstado() { return 0 }
}

object segundoEstado {
	method proximaFase() { return tercerEstado }

	method nivelDelEstado() { return 1 }
}

object tercerEstado {
	method proximaFase() { return ultimoEstado }

	method nivelDelEstado() { return 2 }
}

object ultimoEstado {
	method proximaFase() { return estadoInicial }

	method nivelDelEstado() { return 3 }
}


//estados del tomaco y el maiz
object faseBebe { method nombre() { return "baby" } }

object faseAdulta { method nombre() { return "adult" } }

object plantas {
	const property plantasSembradas = #{}

	method nuevaPlanta(_tipoDePlanta) {
		return new Planta( tipoDePlanta = _tipoDePlanta ) 
	}

	method agregarPlantaAlJuego(planta) {
		plantasSembradas.add(planta)
		game.addVisual(planta)
	}

	method eliminarPlantaDelJuego(planta) {
		plantasSembradas.remove(planta)
		game.removeVisual(planta)
	}

	method posicionesDeTodaslasPlantas() {
		return plantasSembradas.map({ planta => planta.position() })
	}
}
