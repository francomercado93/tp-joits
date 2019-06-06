package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Carrito {
	List<Entrada> entradas

	new() {
		entradas = new ArrayList<Entrada>
	}

	def agregarAlCarrito(Entrada entrada) {
		entradas.add(entrada)
//		entrada.setNombrePelicula()
	}

	def eliminarDelCarrito(Entrada entrada) {
		entradas.remove(entrada)
	}

	def vaciarCarrito() {
		entradas.clear
	}

	def getTotal() {
		if (carritoEstaVacio)
			return new BigDecimal("0")
		else
			new BigDecimal(entradas.fold(0d, [acum, entrada|acum + entrada.getPrecioEntrada()]))
	}

	def Integer cantidadEntradas() {
		return entradas.size
	}

	def getCarritoEstaVacio() {
		entradas.isNullOrEmpty()
	}

	def setPreciosEntradas() {
		entradas.forEach(entrada|entrada.setPrecioEntrada())
	}
}
