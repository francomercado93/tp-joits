package appModel

import domain.Entrada
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repos.RepoUsuarios

@Accessors
@Observable
class FinalizarCompra {

	Usuario usuario
	Entrada entradaSeleccionada

	new(Usuario usr) {
		usuario = usr
	}

	@Dependencies("usuario")
	def getTotalCarrito() {
		"Total: $".concat(usuario.totalCarrito().toString)
//		ObservableUtils.firePropertyChanged(FinalizarCompra, "usuario")
	}

	def eliminarItem() {
		usuario.eliminarItemCarrito(entradaSeleccionada)
	}

	def limpiarCarrito() {
		usuario.vaciarCarrito()
	}

	def comprarEntradas() {
		usuario.comprarEntradas()
		//actualizacion de usuario
		RepoUsuarios.instance.update(usuario)
	}

	@Dependencies("usuario")
	def getCarritoEstaVacio() {
		!usuario.getCarritoEstaVacio()
	}

	def getBotonVolver() {
		true
	}

// No se deshabilitan los botones de limpiar carrito y comprar cuando se borran los items en el carrito
}
