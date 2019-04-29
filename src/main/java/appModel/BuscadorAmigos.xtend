package appModel

import domain.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import repos.RepoUsuarios

@Observable
@Accessors
@Transactional
class BuscadorAmigos {
	Usuario usuarioSeleccionado
	Usuario amigoSeleccionado
	List<Usuario> usuarios
	String busqueda
	List<Usuario> amigosSugeridos

	new(Usuario usuario) {
		this.usuarioSeleccionado = RepoUsuarios.instance.searchById(usuario.id)
		busqueda = ""
		amigosSugeridos = RepoUsuarios.instance.getAmigosSugeridos(usuarioSeleccionado)
	}

	def agregarAmigo() {
		// error al persistir en bd, duplicate pk, no cambia de pk del amigo seleccionado cuando se agregan mas de dos amigos
		usuarioSeleccionado.agregarAmigo(amigoSeleccionado)
		removerDeListas()
//		actualizarUsuario()
//		usuarios = getUsuariosFiltered()
//		amigosSugeridos = RepoUsuarios.instance.getAmigosSugeridos(usuarioSeleccionado)
	}

	def void actualizarUsuario() {
		RepoUsuarios.instance.update(usuarioSeleccionado)
	}

	def boolean removerDeListas() {
		usuarios.remove(amigoSeleccionado)
		amigosSugeridos.remove(amigoSeleccionado)
	}

	def void search() {
		usuarios = getUsuariosFiltered()
	}

	def List<Usuario> getUsuariosFiltered() {
		RepoUsuarios.instance.allInstances
//		RepoUsuarios.instance.search(busqueda).filter [ usr |
//			! usuarioSeleccionado.esAmigo(usr) && !usuarioSeleccionado.username.equalsIgnoreCase(usr.username)
//		].toList
	}
}
