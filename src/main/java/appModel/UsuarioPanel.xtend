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
			username = "Pedro"
			password = "123"
		]
		var amigo3 = new Usuario => [
			username = "Ronaldo"
			password = "123"
		]
		var amigo4 = new Usuario => [
			username = "Messi"
			password = "123"
		]
		
		amigos.add(amigo1)
		amigos.add(amigo2)
		amigos.add(amigo3)
		amigos.add(amigo4)
	}
}
