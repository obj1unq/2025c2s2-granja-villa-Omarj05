import wollok.game.*

object hector {
	var property position = game.center()
	const property image = "mplayer.png"

	method sembrar(planta) { 
		self.validarSiembra()
		planta.sembrar() 
	}

	method regar() {
		self.validarRiego()
		self.plantaQueColisiona().regar()
	}

	method plantaQueColisiona() { return game.uniqueCollider(self) }

	method esParcelaConPlanta(planta) {
		return self.plantaQueColisiona() == planta
	}

	method esParcelaVacia() { return game.colliders(self).isEmpty() }

	method validarRiego() {
		if (self.esParcelaVacia()) {
			self.error("No tengo nada para regar.")
		}
	}

	method validarSiembra() {
		if (!self.esParcelaVacia()) {
			self.error("No puede sembrar aqui.")
		}
	}
}
