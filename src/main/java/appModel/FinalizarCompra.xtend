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
//transactionaldialog
class FinalizarCompra {

	Usuario usuario // usuario para finalizar compra solamente
	Entrada entradaSeleccionada
	Carrito carrito

	// repo de entradas para cargar el carrito
	new(Usuario usr) {
		usuario = usr
		carrito = usr.carrito
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

// No se deshabilitan los botones de limpiar carrito y comprar cuando se borran los items en el carrito
	def getBotonVolver() {
		true
	}

}
