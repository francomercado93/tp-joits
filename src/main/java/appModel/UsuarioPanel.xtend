package appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import domain.Usuario
import java.util.List

@Observable
@Accessors
class UsuarioPanel {
	Usuario usuarioSeleccionado
	List<Usuario> amigos = newArrayList

	new(Usuario usuario) {
		this.usuarioSeleccionado = usuario
		var amigo1 = new Usuario => [
			username = "Franco"
			password = "123"
		]
		var amigo2 = new Usuario => [
			username = "Franco"
			password = "123"
		]
		amigos.add(amigo1)
		amigos.add(amigo2)
	}
}
