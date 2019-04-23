package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import javax.persistence.FetchType

@Entity
@Accessors
@Observable
class Carrito {

	@Id @GeneratedValue
	Long id
	@OneToMany(fetch=FetchType.LAZY)
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

	def getTotal() {
		if (carritoEstaVacio)
			return new BigDecimal("0")
		else
			new BigDecimal(entradas.fold(0d, [acum, entrada|acum + entrada.precioEntrada]))
	}

	def Integer cantidadEntradas() {
		return entradas.size
	}

	def getCarritoEstaVacio() {
		entradas.isNullOrEmpty()
	}

}
