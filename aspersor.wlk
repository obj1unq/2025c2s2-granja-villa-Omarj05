import personaje.*
import wollok.game.*

class Aspersor {
    var property position = hector.position()
    const property image = "aspersor.png"

    method activar() {
        game.addVisual(self)
        game.onTick(1000, "Regar parcelas", {self.regarAlrededor()})
    }

    method regarAlrededor() {
        if (self.hayPlantasLindantes()) {
            self.plantasLindantes().forEach({planta => planta.regar()})
        }
    }

    method posicionesDePlantasLindantes() {
        return self.posicionesLindantes().filter(
                {position => !self.esParcelaVaciaEn(position)}
                )
            
    }

    method plantasLindantes() {
        return self.posicionesDePlantasLindantes().map(
            {position => self.plantaEn(position)})
    }

    method hayPlantasLindantes() {
        return !self.plantasLindantes().isEmpty()
    }

    method posicionesLindantes() {
        return [position.down(1), position.down(1).left(1), position.down(1).right(1),
                position.left(1), position.right(1), position.up(1), position.up(1).left(1),
                position.up(1).right(1)]
    }

    method plantaEn(_position) {
        return 
    }
}

object detectorDePlantas {
    var property position = game.center()
    var plantasDetectadas = []

    method revisarAlrededor() {
        const indice = 0
        
        game.onTick(0, "hola", )
    }

    method plantaQueColisiona() { game.uniqueCollider(self) }

    method posicionesLindantes() {
        return [position.down(1), position.down(1).left(1), position.down(1).right(1),
                position.left(1), position.right(1), position.up(1), position.up(1).left(1),
                position.up(1).right(1)]
    }


    method esParcelaVacia() { return game.colliders(self).isEmpty() }
}