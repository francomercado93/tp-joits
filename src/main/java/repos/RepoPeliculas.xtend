package repos

import domain.Pelicula
import java.util.List
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

	override update(Pelicula elemento) {
		// No se actualizan las peliculas		
	}

	override busquedaPorNombre(Pelicula pelicula, String nombre) {
		pelicula.titulo.equalsIgnoreCase(nombre) || pelicula.titulo.toLowerCase.indexOf(nombre.toLowerCase()) != -1
	}

	override asignarId(Pelicula elemento) {
	}

	def getPeliculasRecomendadas() {
		val pelisRecomendadas = lista.takeWhile[pelicula|pelicula.puntaje.doubleValue() >= PUNTAJE_RECOMENDABLE]
		val List<Pelicula> pelis = newArrayList
		pelis.add(pelisRecomendadas.get(0)) // head?
		pelis.add(pelisRecomendadas.get(1))
		pelis.add(pelisRecomendadas.get(2))
		return pelis
	}

	override searchById(long id) {
	}
}
