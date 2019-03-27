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

	def getRepoUsr() {
		RepoUsuarios.instance
	}

	def validarUsuario() {
//		false
//		usuarioSeleccionado = repoUsr.search(usrname)
//		usuarioSeleccionado.validarPassword(pass)
//		return usuarioSeleccionado !== null
	}

}
