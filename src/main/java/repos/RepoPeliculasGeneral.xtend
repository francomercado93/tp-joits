package repos

import domain.Pelicula
import java.util.List

class RepoPeliculasGeneral {
	List<RepoPeliculasInterface> repos = newArrayList

	static RepoPeliculasGeneral instance

	def static RepoPeliculasGeneral getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasGeneral
		}
		instance
	}

	def void create(Pelicula pelicula) {
		repos.forEach(repo|repo.create(pelicula))
	}

	def agregarRepo(RepoPeliculasInterface repo) {
		repos.add(repo)
	}
}
