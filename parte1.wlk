object rolando{
  var property valorBaseHechiceria = 3
  var property valorBaseLucha = 1
  var property hechizoPreferido = espectroMalefico   //uno de los objetos 
  const property artefactos = #{}   //ARTEFACTOS


//hechiceria: punto 1-----------------------------------------------------------------------------
  method nivelDeHechiceria() = valorBaseHechiceria * hechizoPreferido.poder() + fuerzaOscura.valor()
//hechiceria: punto 3-----------------------------------------------------------------------------
  method cambiarHechizoPreferido(hechizo){
    hechizoPreferido = hechizo
  }
//hechiceria: punto 5-----------------------------------------------------------------------------
  method seCreePoderoso() = hechizoPreferido.esPoderoso()
//lucha: punto 1-----------------------------------------------------------------------------
  method nuevoValorBaseLucha(valor){
    valorBaseLucha = valor
  }
//lucha: punto 2-----------------------------------------------------------------------------
  method agregarArtefacto(algo){
    artefactos.add(algo)
  }

  method removerArtefacto(algo){
    artefactos.remove(algo)
  }
//lucha: punto 3-----------------------------------------------------------------------------
  method valorDeLucha() = valorBaseLucha + self.aporteDeArtefactos()

  method aporteDeArtefactos() = artefactos.sum({a => a.unidadesDeLucha()})
//lucha: punto 4-----------------------------------------------------------------------------
  method esMasLuchadorQueHechicero() = self.valorDeLucha() > self.nivelDeHechiceria()

  method mejorArtefacto() = self.artefactosSinEspejo().max({a => a.unidadesDeLucha()})

  method artefactosSinEspejo() = artefactos.filter({a=> !a.esEspejo()})

//lucha y hechiceria avanzada: punto 1--------------------------------------------------------
  method estaCargado() = artefactos.size() > 4
//lucha y hechiceria avanzada: punto 2--------------------------------------------------------
//Se entraria en un bucle donde se va pidiendo el poder() asi mismo una y otra vez (corregir ese error)
}


object espectroMalefico{
  var nombre = "Espectro Malefico"

  method poder() = nombre.length()
//hechiceria: punto 2-----------------------------------------------------------------------------
  method cambiarNombre(nombre_){
    nombre = nombre_
  }
  method esPoderoso() = self.poder() > 15
}


//HECHIZOS
object hechizoBasico{

  method poder()= 10

  method esPoderoso() = false

}

object fuerzaOscura{
  var property valor = 5

  method cambiarValor(valor_){
    valor = valor_
  }
}

//NUEVOS HECHIZOS
object libroDeHechizos{
  const property hechizos = #{} 

  method poder() = hechizos.sum({h => h.poder()})

  method esPoderoso() = hechizos.size() > 0
}

//hechiceria: punto 4-----------------------------------------------------------------------------
object eclipse{
  method ocurrir(){
    fuerzaOscura.cambiarValor(fuerzaOscura.valor() * 2) 
  }
}


//ARTEFACTOS

object espadaDelDestino{
  const property esEspejo = false
  method unidadesDeLucha() = 3
}
class CollarDivino{
  const property esEspejo = false
  var property cantidadDerPerlas  

  method unidadesDeLucha() = cantidadDerPerlas 
}
object mascaraOscura{
  const property esEspejo = false
  method unidadesDeLucha() =
    4.max(fuerzaOscura.valor()/2)
}

//NUEVOS ARTEFACTOS
object armadura {
  const property esEspejo = false
  var property valorDeRefuerzo = cotaDeMalla
  method unidadesDeLucha() = 2 + valorDeRefuerzo.unidades()
}
          //REFUERZOS
            object cotaDeMalla{
              method unidades() = 1
            }

            object bendicion{
              var property guerrero = rolando 
              method unidades() = guerrero.nivelDeHechiceria()
            }

            object hechizo{
              var property hechizo = espectroMalefico

              method unidades() =  hechizo.poder()
            }

            object ninguno{
              method unidades() = 0
            }

object espejo{
  const property esEspejo = true
  var property guerrero = rolando

  method unidadesDeLucha() = 
    if (guerrero.artefactosSinEspejo().isEmpty()) 0 
    else guerrero.mejorArtefacto().unidadesDeLucha()
}

