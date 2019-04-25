package appModel

import domain.Usuario
import java.util.List
import javax.persistence.EntityManager
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

	new(Usuario usuario) {
		this.usuarioSeleccionado = RepoUsuarios.instance.searchById(usuario.id)
		busqueda = ""
	}

	def agregarAmigo() {
		usuarioSeleccionado.agregarAmigo(amigoSeleccionado)
		actualizarUsuario()
		removerDeListaUsuarios()
	}

	def EntityManager actualizarUsuario() {
		RepoUsuarios.instance.update(usuarioSeleccionado)
	}

	def boolean removerDeListaUsuarios() {
		usuarios.remove(amigoSeleccionado)
	}

	def void search() {
//		print("amigos usr" + usuarioSeleccionado.amigos.get(0).nombre + usuarioSeleccionado.amigos.get(0) + "\n")
		usuarios = getUsuariosFiltered()
	}

	def List<Usuario> getUsuariosFiltered() {
		RepoUsuarios.instance.search(busqueda).filter [ usr |
			! usuarioSeleccionado.esAmigo(usr)
		].toList
	}

	def getAmigosSugeridos() {
		RepoUsuarios.instance.getAmigosSugeridos(usuarioSeleccionado)
	}

}
