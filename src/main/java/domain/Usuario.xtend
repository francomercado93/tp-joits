package domain

import java.math.BigDecimal
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class Usuario {
	//ddddsdsd
	Long id
	String username
	String password
	String nombre
	String apellido
	Integer edad
	Set<Usuario> amigos = new HashSet<Usuario>
	Carrito carrito
	Set<Entrada> entradasCompradas = new HashSet<Entrada>
	BigDecimal saldo

	new() {
		saldo = new BigDecimal("0")
		carrito = new Carrito
	}

	def agregarAmigo(Usuario usuario) {
		amigos.add(usuario)
	}

	def validarse(String user, String pass) {
		return username == user && password == pass
	}

	def String getMiSaldo() {
		return "$".concat(saldo.setScale(2, BigDecimal.ROUND_HALF_EVEN).toString)
	}

	def agregarSaldinho(BigDecimal cargaSaldo) {
		saldo = saldo + cargaSaldo
	}

	def Set<Pelicula> getPeliculasVistas() {
		return entradasCompradas.map[pelicula].toSet
	}

	def buscarAmigo(String busqueda) {
		// Me parece que el contains evalua todo el string?.
		var String nombreApellido = nombre + apellido
		var String busquedaRegex = busqueda.replaceAll("[^a-zA-Z]", "");
		return nombreApellido.contains(busquedaRegex)
	}

	def comprarEntradas() {
		if (!this.tieneSaldoSuficiente())
			throw new UserException("No tiene saldo suficiente")
		this.finalizarCompra()
	}

	def finalizarCompra() {
		this.descontarSaldo()
		this.agregarEntradasCompradas(carrito.entradas)
		carrito.vaciarCarrito()
	}

	def descontarSaldo() {
		saldo = saldo - carrito.total
	}

	def Boolean tieneSaldoSuficiente() {
		return 1 == saldo.compareTo(carrito.total) || 0 == saldo.compareTo(carrito.total) // saldo >= carrito.total()
	}

	def agregarEntradasCompradas(List<Entrada> entradas) {
		entradasCompradas.addAll(entradas) // devuelve boolean
	}

	def validarPassword(String pass) {
		if (!password.equals(pass))
			throw new UserException("Contraseña no valida")
	}

	def totalCarrito() {
		carrito.total
	}

}
