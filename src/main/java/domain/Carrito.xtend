package domain

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
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

	def BigDecimal total() {
		new BigDecimal(entradas.fold(0d, [acum, entrada|acum + entrada.valorEntrada()]))
	}

}
