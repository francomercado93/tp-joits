package appModel

import domain.Entrada
import domain.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils

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
	}

	def getBotonVolver() {
		true
	}

}
