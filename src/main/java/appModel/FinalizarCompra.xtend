package appModel

import domain.Carrito
import domain.Entrada
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import repos.RepoUsuarios
import domain.CarritoFactory

@Accessors
@Observable
class FinalizarCompra {

	Usuario usuario
	Entrada entradaSeleccionada
	Carrito carrito

	new(Usuario usr) {
		usuario = RepoUsuarios.instance.searchById(usr.id) // necesito traerme las entradas compradas para agregar las nuevas
		carrito = CarritoFactory.instance.usuarioEntradasRedis(usuario.id)
	}

	@Dependencies("carrito")
	def getTotalCarrito() {
		"Total: $".concat(carrito.total.toString)
	}

	def eliminarItem() {
		print(entradaSeleccionada.funcion.hora)
		CarritoFactory.instance.eliminarEntradaRedis(usuario.id, entradaSeleccionada)
		carrito.eliminarDelCarrito(entradaSeleccionada)
		ObservableUtils.firePropertyChanged(this, "carrito")
	}

	def limpiarCarrito() {
		carrito.vaciarCarrito()
		CarritoFactory.instance.vaciarCarrito(usuario.id)
		ObservableUtils.firePropertyChanged(this, "carrito")
		this.actualizarPrecioCarrito()
	}

	def actualizarPrecioCarrito() {
		ObservableUtils.firePropertyChanged(this, "totalCarrito")
	}

	def comprarEntradas() {
		usuario.comprarEntradas(carrito)
		carrito.vaciarCarrito()
		CarritoFactory.instance.vaciarCarrito(usuario.id)
		this.actualizarUsuario()
		ObservableUtils.firePropertyChanged(this, "carrito")
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
