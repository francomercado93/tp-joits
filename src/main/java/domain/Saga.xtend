package domain

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.uqbar.commons.model.annotations.Observable

//para crear otra collection
//@Entity
@Accessors
@Observable
class Saga extends Pelicula {
	static final BigDecimal PRECIO_BASE_SAGA = new BigDecimal("10")
	static final BigDecimal MULTIPLICADOR_NIVEL_CLASICO = new BigDecimal("5")

	BigDecimal multiplicador

	List<Pelicula> peliculasSaga

	new() {
		precioBase = PRECIO_BASE_SAGA
		multiplicador = MULTIPLICADOR_NIVEL_CLASICO
		peliculasSaga = newArrayList
	}

	override getPrecioBase() {
		return PRECIO_BASE_SAGA * this.cantidadPeliculasSaga() + this.nivelDeClasico
	}

	def cantidadPeliculasSaga() {
		return new BigDecimal(peliculasSaga.size)
	}

	def BigDecimal getNivelDeClasico() {
		return this.promedioPuntajePeliculas() * multiplicador
	}

	def BigDecimal promedioPuntajePeliculas() {
		return new BigDecimal(Math.round(peliculasSaga.fold(0d, [acum, peli|acum + peli.puntaje]) /
			cantidadPeliculasSaga()))
	}

	def agregarPeliculaSaga(Pelicula pelicula) {
		peliculasSaga.add(pelicula)
	}
}
