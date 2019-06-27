package appModel

import domain.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repos.RepoUsuarios
import repos.RepoUsuariosNeo4j

@Observable
@Accessors
class BuscadorAmigos {
	Usuario usuarioSeleccionado
	Usuario amigoSeleccionado
	List<Usuario> usuarios
	String busqueda
	List<Usuario> amigosSugeridos

	new(Usuario usuario) {
		this.usuarioSeleccionado = RepoUsuarios.instance.searchById(usuario.id)
		busqueda = ""
		//amigosSugeridos = RepoUsuarios.instance.getAmigosSugeridos(usuarioSeleccionado)
		amigosSugeridos = RepoUsuariosNeo4j.instance.getAmigosSugeridos(usuario)
	}

	def agregarAmigo() {
		usuarioSeleccionado.agregarAmigo(amigoSeleccionado)
		search()
//		removerDeListas()
	}

	def void actualizarUsuario() {
		//setear de nuevo los usuarios en las entradas compradas al recuperar de la bd relacional o guardar
		usuarioSeleccionado.entradasCompradas.forEach( entrada |
			print(entrada.usuario.username + " " + entrada.pelicula.titulo + "\n")
		)
		RepoUsuarios.instance.update(usuarioSeleccionado)
		RepoUsuariosNeo4j.instance.guardarUsuario(usuarioSeleccionado)
	}

	def boolean removerDeListas() {
		amigosSugeridos.remove(amigoSeleccionado)
	}

	def void search() {
		usuarios = getUsuariosFiltrados()
	}

	def getUsuariosFiltrados() {
		RepoUsuarios.instance.searchByName(busqueda).filter(usr|filtrarAmigosYUsuario(usr)).toList
	}

	def boolean filtrarAmigosYUsuario(Usuario usr) {
		usuarioSeleccionado.id != usr.id && ! usuarioSeleccionado.esAmigo(usr)
	}
}
