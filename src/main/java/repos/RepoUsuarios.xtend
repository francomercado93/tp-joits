package repos

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
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
			usuario.id = new Long(id)
			this.id = id + 1
		}
	}

	override busquedaPorNombre(Usuario usuario, String nombre) {
		usuario.username.equalsIgnoreCase(nombre)
	}

	override update(Usuario elemento) {
	}

}
