import wollok.game.*

object hector {
	var property position = game.center()
	const property image = "mplayer.png"

	method sembrar(planta) { 
		if (self.puedeSembrar()) {
			planta.sembrar() 
		}
	}

	method puedeSembrar() { return game.colliders(self).isEmpty() }
}
