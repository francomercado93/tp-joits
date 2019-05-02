package appModel

import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import repos.RepoUsuarios

@Accessors
@Observable
class LoginUsuario {
	String usrname
	String pass
	Usuario usuarioSeleccionado

	def void validarUsuario() {
		usuarioSeleccionado = RepoUsuarios.instance.getUsuario(usrname, pass)
		if (usuarioSeleccionado === null)
			throw new UserException("Login incorrecto!")
	}
}
