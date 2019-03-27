package domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Carrito {

	List<Entrada> entradas = newArrayList // List de peliculas?

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
		entradas.fold(0d, [acum, entrada|acum + entrada.precioEntrada])
	}

	@Dependencies("peliculas")
	def cantidadEntradas() {
		if (entradas.nullOrEmpty)
			return 0
		else
			return entradas.length
	}

}
