package repos

import domain.Pelicula
import domain.Usuario

class RepoPeliculasNeo4j extends RepoAbstractNeo4j {

	static RepoPeliculasNeo4j instance

	def static RepoPeliculasNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasNeo4j
		}
		instance
	}

	def getPeliculasRecomendadas(Usuario usuario) {
	}

	def filtroRecomendadas(Usuario usuario) {
//		val filtroUsuario = new Filter("username", ComparisonOperator.EQUALS, usuario.username )
//		val filtroAmigosUsuario = new Filter()
//		return
	}
	
	 def find(Long id) {
        return session.load(typeof(Pelicula), id)
    }

	def guardarPelicula(Pelicula pelicula) {
		/* Para no guardar las funciones disponibles de la pelicula */
//		session.save(pelicula, 0)
		/*guardar todo el grafo y agregar un anotattion transient en funcion */
		session.save(pelicula)
	}

}
