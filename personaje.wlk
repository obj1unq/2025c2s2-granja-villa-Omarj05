import wollok.game.*

object hector {
	var property position = game.center()
	const property image = "mplayer.png"
	const property plantasCosechadas = []
	var oroAlmacenado = 0

	//acciones
	method sembrar(planta) { 
		self.validarSiembra()
		planta.sembrar() 
	}

	method regar() {
		self.validarRiego()
		self.plantaQueColisiona().regar()
	}

	method cosechar() {
		self.validarCosecha()
		plantasCosechadas.add(self.plantaQueColisiona())
		self.plantaQueColisiona().cosechar()
	}

	method venderTodoLoCosechado() {
		oroAlmacenado += self.totalAVender()
		plantasCosechadas.clear()
	}

	//consultas
	method plantaQueColisiona() { return game.uniqueCollider(self) }

	method esParcelaConPlanta(planta) {
		return self.plantaQueColisiona() == planta
	}

	method decirCantidadDeOroYPlantasCosechadas() {
		game.say( self, self.mensajeSobreCantidadDeOroYPlantasCosechadas() )
	}

	method mensajeSobreCantidadDeOroYPlantasCosechadas() {
		return "Tengo " + oroAlmacenado + " monedas, y " + 
			self.cantidadDePlantasCosechadas() + " planta/s para vender."
	}

	method cantidadDePlantasCosechadas() { return plantasCosechadas.size() }

	method oroAlmacenado() { return oroAlmacenado }

	method esParcelaVacia() { return game.colliders(self).isEmpty() }
 
	method totalAVender() { return plantasCosechadas.sum({planta => planta.valor()}) }

	//validaciones
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

	method validarCosecha() {
		if (self.esParcelaVacia()) {
			self.error("No tengo nada para cosechar aqui.")
		}
	}
}
