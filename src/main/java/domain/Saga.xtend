package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Entity
@Observable
class Saga extends Pelicula {
	static final BigDecimal PRECIO_BASE_SAGA = new BigDecimal("10")
	static final BigDecimal MULTIPLICADOR_NIVEL_CLASICO = new BigDecimal("5")

	@Column
	BigDecimal multiplicador

	new() {
		precioBase = PRECIO_BASE_SAGA
		multiplicador = MULTIPLICADOR_NIVEL_CLASICO
	}

	@OneToMany(fetch=FetchType.EAGER) // necesito tener las peliculas para calcular el costo de las entradas
	List<Pelicula> peliculasSaga = new ArrayList<Pelicula>

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
