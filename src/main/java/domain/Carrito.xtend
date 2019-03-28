package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Carrito {

	List<Entrada> entradas = new ArrayList<Entrada> // List de peliculas?

	def agregarAlCarrito(Entrada entrada) {
		entradas.add(entrada)
	}

	def eliminarDelCarrito(Entrada entrada) {
		entradas.remove(entrada)
	}

	def vaciarCarrito() {
		entradas.clear
	}

	def total() {
		new BigDecimal(entradas.fold(0d, [acum, entrada|acum + entrada.precioEntrada]))
	}

	@Dependencies("entradas")
	def Integer cantidadEntradas() {
		return entradas.size
	}
}
