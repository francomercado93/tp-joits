package domain

import java.math.BigDecimal
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class Usuario {
	int id
	String username
	String password
	String nombre
	String apellido
	int edad
	Set<Usuario> amigos = newHashSet
	Carrito carrito
	List<Entrada> entradasCompradas = newArrayList
	BigDecimal saldo

	new() {
		saldo = new BigDecimal("0")
		id = -1
	}
	
	new(String nombreUsr, String contra) {
		username = nombreUsr
		password = contra
		saldo = new BigDecimal("0")
		id = -1
	}


	def agregarSaldo(BigDecimal numero) {
		saldo = saldo + numero
	}

	def comprarEntradas() {
		if (this.tieneSaldoSuficiente()) {
			this.finalizarCompra()
		} else
			print("No tiene saldo suficiente") // cambiar por un exception?
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
		return saldo >= carrito.total()
	}

	def agregarEntradasCompradas(List<Entrada> entradas) {
		entradasCompradas.addAll(entradas) // devuelve boolean
	}

	def validarPassword(String pass) {
		if (!password.equals(pass))
			throw new UserException("Contraseña no valida")
	}

}
