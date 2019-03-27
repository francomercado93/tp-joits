package domain

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Pelicula {
	static final BigDecimal PRECIO_BASE_PELICULA = new BigDecimal("30")
	String titulo
	Integer anio
	BigDecimal puntaje
	String genero
	List<Funcion> funcionesDisponibles = newArrayList
	Funcion funcionElegida

	def precioTotal() {
		return this.precioBase + funcionElegida.valorPorDiaFuncion()
	}

	def getPrecioBase() {
		return PRECIO_BASE_PELICULA
	}

	def elegirFuncion(Funcion funcion) {
		if (funcionesDisponibles.contains(funcion))
			funcionElegida = funcion
		else
			print("Funcion no disponible")
	}

	def agregarFuncion(Funcion funcion) {
		funcionesDisponibles.add(funcion)
	}

}
