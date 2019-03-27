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
//	static final Integer PRECIO_BASE_PELICULA = 30
	String titulo
	Integer anio
	BigDecimal puntaje
	String genero
	List<Funcion> funcionesDisponibles = newArrayList
	Funcion validarFuncion

	@Dependencies("funcionElegida", "precioBase")
	def getPrecioTotal() {
		return this.precioBase + validarFuncion.valorPorDiaFuncion
	}

	def getPrecioBase() {
		PRECIO_BASE_PELICULA
	}

	def elegirFuncion(Funcion funcion) {
		validarFuncion = funcion
	}

	def agregarFuncion(Funcion funcion) {
		funcionesDisponibles.add(funcion)
	}

	def validarFuncion(Funcion funcion) {
		if (funcion === null)
			throw new UserException("Debe seleccionar una funcion")
		validarFuncion = funcion
	}

}
