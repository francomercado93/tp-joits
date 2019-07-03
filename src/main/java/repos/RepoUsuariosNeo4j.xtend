package repos

import domain.Usuario
import java.util.ArrayList
import java.util.Collections
import java.util.Set
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter

//import java.util.Set
class RepoUsuariosNeo4j extends RepoAbstractNeo4j<Usuario> {

	static RepoUsuariosNeo4j instance

	def static RepoUsuariosNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}

	override create(Usuario usuario) {
		val usr = this.searchByUsername(usuario)
		if (usr !== null) {
			usuario.id = usr.id
		}
		session.save(usuario, 1)
	}

	def Usuario searchByUsername(Usuario usuario) {
		new ArrayList(session.loadAll(typeof(Usuario), filtroNombre(usuario.username))).head
	}

	override filtroNombre(String nombre) {
		return new Filter("username", ComparisonOperator.EQUALS, nombre)
	}

	override Set<Usuario> getRecomendadas(Usuario usuario) {
		val query = "MATCH (n:Usuario {username:'" + usuario.username +
			"'}) MATCH (n)-[:ES_AMIGO*2]-(m:Usuario) WHERE NOT (n)-[:ES_AMIGO]-(m) AND n <> m RETURN m"
		val usuarios = session.query(typeof(Usuario), query, Collections.EMPTY_MAP).toSet
		usuarios
	}
}
