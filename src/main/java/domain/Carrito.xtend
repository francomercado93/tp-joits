package domain

import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Carrito {

	List<Entrada> entradas = newArrayList

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
