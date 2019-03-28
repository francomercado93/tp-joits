package appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import domain.Usuario
import java.util.List
import repos.RepoUsuarios
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.commons.model.utils.ObservableUtils

@Observable
@Accessors
@Transactional
class BuscadorAmigos {
	Usuario usuarioSeleccionado
	Usuario amigoSeleccionado
	List<Usuario> usuarios = newArrayList
	List<Usuario> amigosSugeridos = newArrayList
	String busqueda

	new(Usuario usuario) {
		this.usuarioSeleccionado = usuario
	}

	def agregarAmigo() {
		if (amigoSeleccionado !== null)
			usuarioSeleccionado.agregarAmego(amigoSeleccionado)
	}

	def search() {
		usuarios = RepoUsuarios.instance.getAll
		amigosSugeridos = RepoUsuarios.instance.getAll
	}
	
	def void buscarAmigo() {
		if (busqueda == "" || busqueda === null) {
			usuarios = RepoUsuarios.instance.getAll
		} else {
			usuarios = RepoUsuarios.instance.searchAmigo(busqueda)	
		}
		ObservableUtils.firePropertyChanged(this, "usuarios", usuarios)		
	}

}