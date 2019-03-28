package appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import domain.Usuario
import java.util.List
import repos.RepoUsuarios
import org.uqbar.commons.model.annotations.Transactional

@Observable
@Accessors
@Transactional
class BuscadorAmigos {
	Usuario usuarioSeleccionado
	Usuario amigoSeleccionado
	List<Usuario> usuarios = newArrayList
	List<Usuario> amigosSugeridos = newArrayList
	String buscar

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

}
