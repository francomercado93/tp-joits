package repos

import domain.Pelicula
import domain.Usuario
import java.util.ArrayList
import java.util.Collections
import java.util.Set

class RepoPeliculasNeo4j extends RepoAbstractNeo4j {

	static RepoPeliculasNeo4j instance

	def static RepoPeliculasNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasNeo4j
		}
		instance
	}

	def Set<Pelicula> getRecomendadas(Usuario usuario) {
		val query = "MATCH(usuario {username:'" + usuario.username + "'})-[:ES_AMIGO]->(amigo)-[:MIRO]->(pelicula)
					 WHERE NOT(usuario) -[:MIRO]->(pelicula) RETURN pelicula"
		val pelis = session.query(typeof(Pelicula), query, Collections.EMPTY_MAP).toSet
		pelis
	}

	def guardar(Pelicula pelicula) {
		/*guardar todo el grafo y agregar un anotattion transient a lo que no se quiere guardar*/
		val peli = this.find(pelicula)
		if (peli !== null) {
			pelicula.id = peli.id
		}
		session.save(pelicula)
	}

	def Pelicula find(Pelicula pelicula) {
		new ArrayList(session.loadAll(typeof(Pelicula), this.filtroNombre(pelicula.titulo))).head
	}
}
