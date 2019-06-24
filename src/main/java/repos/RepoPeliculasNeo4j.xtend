package repos

import domain.Pelicula

class RepoPeliculasNeo4j extends RepoAbstractNeo4j {

	static RepoPeliculasNeo4j instance

	def static RepoPeliculasNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasNeo4j
		}
		instance
	}

	def getPeliculasRecomendadas() {
		// query peliculas recomendadas
	}

	def guardarPelicula(Pelicula pelicula) {
		/* Para no guardar las funciones disponibles de la pelicula */
		session.save(pelicula, 0)
	}

}
