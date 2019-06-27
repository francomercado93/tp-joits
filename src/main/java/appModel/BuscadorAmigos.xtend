package appModel

import domain.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import repos.RepoUsuarios
import repos.RepoUsuariosNeo4j

@Observable
@Accessors
class BuscadorAmigos {
	Usuario usuarioSeleccionado
	Usuario amigoSeleccionado
	Set<Usuario> usuariosFiltrados
	String busqueda

	new(Usuario usuario) {
		this.usuarioSeleccionado = RepoUsuarios.instance.searchById(usuario.id)
		busqueda = ""
	}

	def void setAmigoSeleccionado(Usuario amigo) {
		if (amigo !== null)
//			amigoSeleccionado = RepoUsuarios.instance.getAmigosSugeridos(amigo)
			amigoSeleccionado = RepoUsuarios.instance.searchById(amigo.id)
	}

	def agregarAmigo() {
		usuarioSeleccionado.agregarAmigo(amigoSeleccionado)
		this.actualizarTablas()
	}

	@Dependencies("usuarioSeleccionado")
	def getAmigosSugeridos() {
		RepoUsuariosNeo4j.instance.getAmigosSugeridos(usuarioSeleccionado)
	}

	def void actualizarTablas() {
		search()
		this.amigosSugeridos
		ObservableUtils.firePropertyChanged(this, "amigosSugeridos")
	}

	def void actualizarUsuario() {
		RepoUsuarios.instance.update(usuarioSeleccionado)
		RepoUsuariosNeo4j.instance.guardarUsuario(usuarioSeleccionado)
	}

	def boolean removerDeListas() {
		amigosSugeridos.remove(amigoSeleccionado)
	}

	@Dependencies("usuarioSeleccionado")
	def search() {
		usuariosFiltrados = RepoUsuarios.instance.getUsuariosFiltrados(busqueda, usuarioSeleccionado)
	}

}
