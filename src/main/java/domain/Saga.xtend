package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Saga extends Pelicula {
	static final BigDecimal PRECIO_BASE_SAGA = new BigDecimal("10")
	static final BigDecimal MULTIPLICADOR_NIVEL_CLASICO = new BigDecimal("5")

	List<Pelicula> peliculasSaga = new ArrayList<Pelicula>

	override getPrecioBase() {
		return PRECIO_BASE_SAGA * this.cantidadPeliculasSaga() + this.nivelDeClasico
	}

	def cantidadPeliculasSaga() {
		return new BigDecimal(peliculasSaga.size)
	}

	def BigDecimal getNivelDeClasico() {
		return this.promedioPuntajePeliculas() * MULTIPLICADOR_NIVEL_CLASICO
	}

	def BigDecimal promedioPuntajePeliculas() {
		return new BigDecimal(
			Math.round(peliculasSaga.fold(0d, [acum, peli|acum + peli.puntaje]) / cantidadPeliculasSaga()))
	}

	def agregarPeliculaSaga(Pelicula pelicula) {
		peliculasSaga.add(pelicula)
	}
}
