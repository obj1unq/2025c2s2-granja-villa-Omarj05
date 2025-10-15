import wollok.game.*
import personaje.*
import extras.*

class Planta {
	var property tipoDePlanta
	var property position = hector.position()
	const property valor = tipoDePlanta.valor()

	method valor() { return tipoDePlanta.valor() }

	method position() { return position }

	method faseDeEvolucion() { return tipoDePlanta.faseDeEvolucion() }

	method image() { return tipoDePlanta.image() }

	method sembrar() {
		plantas.agregarPlantaAlJuego(self)
	}

	method regar() { tipoDePlanta.crecer(self) }

	method cosechar() {
		if (tipoDePlanta.estaListaParaCosechar()) {
			plantas.eliminarPlantaDelJuego(self)
		}
	}

	method esPlanta() { return true }
}	

class Maiz {
	var property faseDeEvolucion = faseBebe
	
	method valor() { return 150 }

	method image() { return "corn_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseAdulta }

	method crecer(planta) { faseDeEvolucion = self.proximaFaseDeEvolucion() }

	method estaListaParaCosechar() { return faseDeEvolucion.puedeCosecharse() }
}

class Trigo {
	var property faseDeEvolucion = estadoInicial
	
	method valor() { return (faseDeEvolucion.nivelDelEstado() -1) * 100 }
	
	method image() { return "wheat_" + faseDeEvolucion.nivelDelEstado() + ".png" }

	method proximaFaseDeEvolucion() { return faseDeEvolucion.proximaFase() }

	method crecer(planta) { faseDeEvolucion = self.proximaFaseDeEvolucion() }

	method estaListaParaCosechar() { return faseDeEvolucion.nivelDelEstado() >= 2 }
}

//(faseDeEvolucion +1) * ((3 - faseDeEvolucion).max(0).min(1))

class Tomaco {
	var property faseDeEvolucion = faseAdulta

	method valor() { return 80 }
	
	method image() { return "tomaco_" + faseDeEvolucion.nombre() + ".png" }

	method proximaFaseDeEvolucion() { return faseDeEvolucion }

	method crecer(planta) { 
		if (self.hayParcelaLibreArribaPara(planta)) {
			planta.position(planta.position().up(1))
		}
		else {
			self.validarHayParcelaLibreEnBordeInferiorPara(planta)
			planta.position(game.at(planta.position().x(), 0))
		}
	}

	method hayParcelaLibreArribaPara(planta) {
		return self.hayParcelaLibre(planta.position().up(1))
	}
 
	method hayParcelaLibre(_position) {
		return self.hayParcela(_position) && self.esParcelaVacia(_position)
	}

	method validarHayParcelaLibreEnBordeInferiorPara(planta) {
		if (!self.hayParcelaLibreEnBordeInferiorPara(planta)) {
			self.error("No puedo crecer arriba.")
		}
	}

	method hayParcelaLibreEnBordeInferiorPara(planta) {
		return self.hayParcelaLibre(game.at(planta.position().x(), 0))
	}

	method hayParcela(_position) {
		return _position.y().between(0, game.height()-1)
	}

	method esParcelaVacia(_position) {
		return game.getObjectsIn(_position).isEmpty()
	}

	method hayCelda(direccion) {
        return direccion.siguiente(self).x().between(0, game.width()-2)
    }
 
	method estaListaParaCosechar() { return faseDeEvolucion.puedeCosecharse() }
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
object faseBebe { 
	method nombre() { return "baby" } 
	method puedeCosecharse() { return false }	
}

object faseAdulta { 
	method nombre() { return "adult" } 
	method puedeCosecharse() { return true }
}


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
