package appModel

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repos.RepoUsuarios

@Accessors
@Observable
class LoginUsuario {
	String usrname
	String pass
	Usuario usuarioSeleccionado

	def Usuario validarUsuario() {
		usuarioSeleccionado = RepoUsuarios.instance.getUsuario(usrname, pass)
		return usuarioSeleccionado
	}

}
