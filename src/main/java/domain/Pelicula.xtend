package domain

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@Observable
class Pelicula {
	static final BigDecimal PRECIO_BASE_PELICULA = new BigDecimal("30")
	String titulo
	Integer anio
	BigDecimal puntaje
	String genero
	List<Funcion> funcionesDisponibles = newArrayList

	def getPrecioBase() {
		PRECIO_BASE_PELICULA
	}

	def agregarFuncion(Funcion funcion) {
		funcionesDisponibles.add(funcion)
	}

}
