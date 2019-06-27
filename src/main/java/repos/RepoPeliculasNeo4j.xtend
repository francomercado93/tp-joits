package repos

import domain.Pelicula
import domain.Usuario
import java.util.Collections

class RepoPeliculasNeo4j extends RepoAbstractNeo4j {

	static RepoPeliculasNeo4j instance

	def static RepoPeliculasNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasNeo4j
		}
		instance
	}

	def getPeliculasRecomendadas(Usuario usuario) {
		val query = "MATCH(usuario {username:'" + usuario.username + "'})-[:AMIGOS]->(amigo)-[:MIRO]->(pelicula) 
					WHERE NOT(usuario) -[:MIRO]->(pelicula) RETURN pelicula"
		val pelis = session.query(typeof(Pelicula), query, Collections.EMPTY_MAP).toSet
		val peliculas = RepoPeliculas.instance.allInstances.toSet
		pelis.forEach(peli|print("neo " + peli.titulo + peli.hashCode))
		peliculas.forEach(peli|print("mongodb " + peli.titulo + peli.hashCode))
		val toyStoryNeo = pelis.get(0)
		val toyStoryMongo = RepoPeliculas.instance.searchByName("Toy")
		print(toyStoryNeo.titulo + " " + toyStoryNeo.hashCode)
		print(toyStoryMongo.titulo + " " + toyStoryMongo.hashCode)
		print(toyStoryNeo.equals(toyStoryNeo))
//		pelis.forEach(peli|RepoPeliculas.instance.allInstances.forEach(pelicula|peli.equals(pelicula)))
		pelis
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
