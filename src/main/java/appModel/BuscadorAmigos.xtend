package appModel

import domain.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.exceptions.UserException
import repos.RepoUsuarios

@Observable
@Accessors
@TransactionalAndObservable
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
		if (amigoSeleccionado === null)
			throw new UserException("Debe seleccionar un amigo")
		usuarioSeleccionado.agregarAmigo(amigoSeleccionado)
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

//	def void actualizarLista() {
//		ObservableUtils.firePropertyChanged(this, "usuarios", usuarios)
//	}
	def getAmigosSugeridos() {
		RepoUsuarios.instance.getAmigosSugeridos(usuarioSeleccionado)
	}

}
