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

//	def Usuario validarUsuario() {
//		usuarioSeleccionado = RepoUsuarios.instance.getUsuario(usrname, pass)
//		return usuarioSeleccionado
//	}
//	def getRepoUsr() {
//		RepoUsuarios.instance
//	}
//
//	def validarUsuario() {
//		false
//		usuarioSeleccionado = repoUsr.search(usrname)
//		usuarioSeleccionado.validarPassword(pass)
//		return usuarioSeleccionado !== null
//	}

}
