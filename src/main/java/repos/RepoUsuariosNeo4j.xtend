package repos

import domain.Usuario
import java.util.Collections
import java.util.Set

//import java.util.Set
class RepoUsuariosNeo4j extends RepoAbstractNeo4j {
	static RepoUsuariosNeo4j instance

	def static RepoUsuariosNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}

	def guardarUsuario(Usuario usuario) {
		session.save(usuario, 1)
	}

	def Set<Usuario> getAmigosSugeridos(Usuario usuario) {
		val query = "MATCH (n:Usuario {username:'" + usuario.username +
			"'}) MATCH (n)-[:ES_AMIGO*2]-(m:Usuario) WHERE NOT (n)-[:ES_AMIGO]-(m) AND n <> m RETURN m"
		val usuarios = session.query(typeof(Usuario), query, Collections.EMPTY_MAP).toSet
		usuarios
	}

}
