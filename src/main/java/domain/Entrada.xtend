package domain

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
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
