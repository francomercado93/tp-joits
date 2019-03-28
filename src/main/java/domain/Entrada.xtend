package domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Entrada {

	Pelicula pelicula
	Funcion funcion

	@Dependencies("pelicula", "funcion")
	def precioEntrada() {
		pelicula.precioBase + funcion.valorPorDiaFuncion
	}

	def LocalDate fechaFuncion() {
		return funcion.getFecha
	}

}
