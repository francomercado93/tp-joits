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
		session.save(usuario, 1)
	}

	def getAmigosSugeridos(Usuario usuario) {
		// query  amigos sugeridos
	}
}
