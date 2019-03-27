package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

//Eliminar clase entrada?
@Accessors
@Observable
class Entrada {

	Pelicula peliculaElegida

	def elegirPelicula(Pelicula pelicula) {
		peliculaElegida = pelicula
	}

	def elegirFuncion(Funcion funcion) {
		// Validacion de peliculaElegida no sea null
		peliculaElegida.elegirFuncion(funcion)
	}

	def valorEntrada() {
		// Validacion de peliculaElegida y funcion elegida no sea null
		peliculaElegida.precioTotal()
	}

}
