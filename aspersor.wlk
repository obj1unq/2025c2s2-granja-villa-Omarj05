import personaje.*
import cultivos.*

class Aspersor {
    var property position = hector.position()
    const property image = "aspersor.png"

    method activar() {
        game.addVisual(self)
        game.onTick(1000, "Regar parcelas", {self.regarAlrededor()})
    }

    method regarAlrededor() {
        self.validarRiego()
        self.plantasLindantes().forEach({planta => planta.regar()})
    }

    method posicionesDePlantasLindantes() {
        return self.posicionesLindantes().intersection(plantas.posicionesDeTodaslasPlantas())
    }

    method plantasLindantes() {
        return self.posicionesDePlantasLindantes().map({posicion => self.plantaEn(posicion)})
    }

    method hayPlantasLindantes() {
        return !self.plantasLindantes().isEmpty()
    }

    method posicionesLindantes() {
        return #{position.down(1), position.down(1).left(1), position.down(1).right(1),
                position.left(1), position.right(1), position.up(1), position.up(1).left(1),
                position.up(1).right(1)}
    }

        method plantaEn(_position) { 
            return game.getObjectsIn(_position).find({ algo => algo.esPlanta() }) 
    }



    method esPlanta() { return false }

    method validarRiego() {
        if (!self.hayPlantasLindantes()) {
            self.error("No hay plantas para regar.")
        }
    }
}