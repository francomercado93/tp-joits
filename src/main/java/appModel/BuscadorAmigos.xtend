package appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import domain.Usuario
import java.util.List

@Observable
@Accessors
class BuscadorAmigos {
	Usuario usuarioSeleccionado
	List<Usuario> usuarios = newArrayList
	List<Usuario> amigosSugeridos = newArrayList

	new(Usuario usuario) {
		
		this.usuarioSeleccionado = usuario
		var usuarios1 = new Usuario => [
			username = "Franco"
			apellido = "Mercado"
			password = "123"
		]
		var usuarios2 = new Usuario => [
			username = "Pedro"
			apellido = "Picapiedras"
			password = "123"
		]
		var usuarios3 = new Usuario => [
			username = "Ronaldo"
			apellido = "Kirk"
			password = "123"
		]
		var usuarios4 = new Usuario => [
			username = "Messi"
			apellido = "Messias"
			password = "123"
		]
		
		usuarios.add(usuarios1)
		usuarios.add(usuarios2)
		usuarios.add(usuarios3)
		usuarios.add(usuarios4)

		var sugeridos1 = new Usuario => [
			username = "Lisa"
			password = "123"
			apellido = "Simpson"
		]
		var sugeridos2 = new Usuario => [
			username = "Bart"
			password = "123"
			apellido = "Simpson"
		]
		var sugeridos3 = new Usuario => [
			username = "Homero"
			password = "123"
			apellido = "Simpson"
		]
		var sugeridos4 = new Usuario => [
			username = "Pipi"
			password = "123"
			apellido = "De Moura"
		]
		
		amigosSugeridos.add(sugeridos1)
		amigosSugeridos.add(sugeridos2)
		amigosSugeridos.add(sugeridos3)
		amigosSugeridos.add(sugeridos4)
		
	}
}
