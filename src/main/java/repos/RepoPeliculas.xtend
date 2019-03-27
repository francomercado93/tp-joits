package repos

import domain.Pelicula
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoPeliculas extends Repositorio<Pelicula> {
	// INSTANCIA REPO
	static RepoPeliculas instance

	// INICIALIZACION REPO
	static def getInstance() {
		if (instance === null) {
			instance = new RepoPeliculas()
		}
		instance
	}

	override update(Pelicula elemento) {
	}

	override busquedaPorNombre(Pelicula elemento, String value) {
		true
	}

	override asignarId(Pelicula elemento) {
	}

	override searchById(int id) {
	}

}
