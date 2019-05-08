package appModel

import domain.Usuario
import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils
import repos.RepoUsuarios

@Observable
@Accessors
class UsuarioPanel {
	Usuario usuarioSeleccionado
	BigDecimal cargarSaldo
	// Creo esta variable antes que volver a hacer llamada al repo para ir a buscar al usuario nuevamente.
	int usuarioEdad

	new(Usuario usuario) {
		this.usuarioSeleccionado = RepoUsuarios.instance.searchById(usuario.id)
		this.usuarioEdad = usuarioSeleccionado.edad
	}

	def Boolean puedeAgregarSaldo() {
		if (!(cargarSaldo !== null && cargarSaldo > BigDecimal.ZERO))
			throw new UserException("Ingrese monto válido!")
	}

	def void agregarSaldo() {
		// Bug con el binding de un BigDecimal? (Cuando sumo por ejemplo 44.4 lo toma como 444)
		usuarioSeleccionado.agregarSaldinho(cargarSaldo)
		// cargarSaldo = null TODO: Por qué no funca con null la vista?
		cargarSaldo = BigDecimal.ZERO
		// SIMPSON: Entra cuchillo salen las tripas (actualizamos usuario --> remove y add)
		this.actualizar
	}

	def void actualizarUsuario() {
		usuarioSeleccionado.setEdad(usuarioEdad)
		this.actualizar
	}

	def void actualizar() {
		RepoUsuarios.instance.update(usuarioSeleccionado)
	}

	def void actualizarAmigos() {
		this.usuarioSeleccionado = RepoUsuarios.instance.searchById(usuarioSeleccionado.id)
		ObservableUtils.firePropertyChanged(this, "usuarioSeleccionado")
	}
}
