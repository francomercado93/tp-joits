package repos

import domain.Usuario

class RepoUsuariosNeo4j extends RepoAbstractNeo4j {
	static RepoUsuariosNeo4j instance

	def static RepoUsuariosNeo4j getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosNeo4j
		}
		instance
	}

	def guardarUsuario(Usuario usuario) {
		/* Guarda todo el grafo de usuario, es decir los amigos y las entradas con las peliculas y sin las funciones */
		session.save(usuario, 1)
	}

	def getAmigosSugeridos(Usuario usuario) {
		// query  amigos sugeridos
	}
}
