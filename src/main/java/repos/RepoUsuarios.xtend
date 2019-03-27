package repos

import domain.Usuario

class RepoUsuarios extends Repositorio<Usuario> {

	// INSTANCIA REPO
	static RepoUsuarios instance

	// INICIALIZACION REPO
	static def getInstance() {
		if (instance === null) {
			instance = new RepoUsuarios()
		}
		instance
	}

	override create(Usuario usuario) {
		this.asignarId(usuario)
		super.create(usuario)
	}

	override searchById(int id) {
		lista.findFirst(usuario|usuario.id == id)
	}

	override asignarId(Usuario usuario) {
		if (usuario.id == -1) {
			usuario.id = id
			this.id = id + 1
		}
	}

	override update(Usuario updateUsuario) {
	}

	def Usuario getUsuario(String usrname, String pass) {
		return lista.findFirst(usuario|usuario.username == usrname && usuario.password == pass)
	}
}
