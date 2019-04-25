package appModel

import domain.Carrito
import domain.Entrada
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import repos.RepoUsuarios

@Accessors
@Observable
class FinalizarCompra {

	Usuario usuario
	Entrada entradaSeleccionada
	Carrito carrito

	new(Usuario usr) {
		usuario = RepoUsuarios.instance.searchById(usr.id) // necesito traerme las entradas compradas para agregar las nuevas
		carrito = usr.carrito
		usuario.carrito = carrito
	}

	@Dependencies("carrito")
	def getTotalCarrito() {
		"Total: $".concat(carrito.total.toString)
	}

	def eliminarItem() {
		carrito.eliminarDelCarrito(entradaSeleccionada)
	}

	def limpiarCarrito() {
		carrito.vaciarCarrito()
		this.actualizarCarrito()
	}

	def actualizarCarrito() {
		ObservableUtils.firePropertyChanged(this, "totalCarrito")
	}

	def comprarEntradas() {
		usuario.comprarEntradas()
		this.actualizarUsuario()
		this.actualizarCarrito()
	}

	def void actualizarUsuario() {
		RepoUsuarios.instance.update(usuario)
	}

	@Dependencies("carrito")
	def getCarritoEstaVacio() {
		!carrito.carritoEstaVacio
	}

	def getBotonVolver() {
		true
	}

}
