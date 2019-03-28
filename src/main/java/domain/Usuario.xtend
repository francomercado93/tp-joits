package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class Usuario {
	Long id
	String username
	String password
	String nombre
	String apellido
	Integer edad
	Set<Usuario> amigos = new HashSet<Usuario>
	Carrito carrito
	List<Entrada> entradasCompradas = new ArrayList<Entrada>
	BigDecimal saldo

	new() {
		saldo = new BigDecimal("0")
		id = new Long(-1)
		carrito = new Carrito
	}

	new(String nombreUsr, String contra) {
		username = nombreUsr
		password = contra
		saldo = new BigDecimal("0")
		id = new Long(-1)
		carrito = new Carrito
	}

	def agregarSaldo(BigDecimal numero) {
		saldo = saldo + numero
	}

	def comprarEntradas() {
		if (this.tieneSaldoSuficiente()) {
			this.finalizarCompra()
		} else
			throw new UserException("No tiene saldo suficiente")
	}

	def finalizarCompra() {
		this.descontarSaldo()
		this.agregarEntradasCompradas(carrito.entradas)
		carrito.vaciarCarrito()
	}

	def descontarSaldo() {
		saldo = saldo - carrito.total()
	}

	def Boolean tieneSaldoSuficiente() {
		false
//		return saldo >= carrito.total() // revisar si compara bien
	}

	def agregarEntradasCompradas(List<Entrada> entradas) {
		entradasCompradas.addAll(entradas) // devuelve boolean
	}

	def validarPassword(String pass) {
		if (!password.equals(pass))
			throw new UserException("Contraseña no valida")
	}

	def agregarItemCarrito(Entrada entrada) {
		carrito.agregarAlCarrito(entrada)
	}

	@Dependencies("carrito")
	def Integer cantidadEntradasCarrito() {
		carrito.cantidadEntradas()
	}

	def totalCarrito() {
		carrito.total
	}

	def eliminarItemCarrito(Entrada entrada) {
		carrito.eliminarDelCarrito(entrada)
	}

	def vaciarCarrito() {
		carrito.vaciarCarrito()
	}

}
