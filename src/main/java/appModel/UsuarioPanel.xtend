package appModel

import domain.Usuario
import java.math.BigDecimal
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import repos.RepoUsuarios

@Observable
@Accessors
class UsuarioPanel {
	Usuario usuarioSeleccionado
	// List<Usuario> amigos = newArrayList
	BigDecimal cargarSaldo
	// Creo esta variable antes que volver a hacer llamada al repo para ir a buscar al usuario nuevamente.
	int usuarioEdad

	new(Usuario usuario) {
		this.usuarioSeleccionado = usuario
		this.usuarioEdad = usuarioSeleccionado.edad
	// cargarSaldo = new BigDecimal(0)
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
		// Lo unico que deberia actualizar al apretar el boton Aceptar.
		if (usuarioSeleccionado.edad !== this.usuarioEdad) {
			usuarioSeleccionado.edad = this.usuarioEdad
			this.actualizar
		}
	}

	def void actualizar() {
		RepoUsuarios.instance.update(usuarioSeleccionado)
	}
}
