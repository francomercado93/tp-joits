package domain

import java.math.BigDecimal
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

	def BigDecimal getPrecioBase() {
		PRECIO_BASE_PELICULA
	}

	override toString() {
		return titulo
	}

}
