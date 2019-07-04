package repos

import domain.Pelicula
import domain.Usuario
import java.util.ArrayList
import java.util.Collections
import java.util.Set
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter

class RepoPeliculasNeo4j extends RepoAbstractNeo4j<Pelicula> implements RepoPeliculasInterface {

	static RepoPeliculasNeo4j instance

	def static RepoPeliculasNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoPeliculasNeo4j
		}
		instance
	}

	override create(Pelicula pelicula) {
		/*guardar todo el grafo y agregar un anotattion transient a lo que no se quiere guardar*/
		val peli = this.searchByName(pelicula.titulo)
		if (peli !== null) {
			pelicula.id = peli.id
		}
		session.save(pelicula)
	}

	override Set<Pelicula> getRecomendadas(Usuario usuario) {
		val query = "MATCH(usuario {username:'" + usuario.username + "'})-[:ES_AMIGO]->(amigo)-[:MIRO]->(pelicula)
					 WHERE NOT(usuario) -[:MIRO]->(pelicula) RETURN pelicula"
		val pelis = session.query(typeof(Pelicula), query, Collections.EMPTY_MAP).toSet
		pelis
	}

	override Pelicula searchByName(String titulo) {
		new ArrayList(session.loadAll(typeof(Pelicula), this.filtroNombre(titulo))).head
	}

	override filtroNombre(String titulo) {
		return new Filter("titulo", ComparisonOperator.EQUALS, titulo)
	}

}
