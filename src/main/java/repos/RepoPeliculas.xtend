package repos

import domain.Pelicula
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoPeliculas extends Repositorio<Pelicula> {

	static final Integer PUNTAJE_RECOMENDABLE = 7
	static RepoPeliculas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPeliculas()
		}
		instance
	}

	override busquedaPorNombre(Pelicula pelicula, String nombre) {
		pelicula.titulo.equalsIgnoreCase(nombre) || pelicula.titulo.toLowerCase.indexOf(nombre.toLowerCase()) != -1
	}

	def getPeliculasRecomendadas() {
		val pelisRecomendadas = lista.takeWhile[pelicula|pelicula.puntaje.doubleValue() >= PUNTAJE_RECOMENDABLE]
		return pelisRecomendadas.take(3).toSet
	}
}
