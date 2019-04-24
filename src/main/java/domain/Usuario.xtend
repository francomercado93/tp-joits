package domain

import java.math.BigDecimal
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.exceptions.UserException

@Entity
@Observable
@Accessors
@TransactionalAndObservable
class Usuario {
	@Id @GeneratedValue
	Long id

	@Column(length=150)
	String username

	@Column(length=150)
	String password

	@Column(length=150)
	String nombre

	@Column(length=150)
	String apellido

	@Column
	Integer edad

	@ManyToMany(fetch=FetchType.LAZY)
	Set<Usuario> amigos

	@Transient
	Carrito carrito

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumn(name="usuario_id")
	Set<Entrada> entradasCompradas

	@Column
	BigDecimal saldo

	new() {
		saldo = new BigDecimal("0")
		carrito = new Carrito
		amigos = new HashSet<Usuario>
		entradasCompradas = new HashSet<Entrada>
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

	def esAmigo(Usuario usuario) {
//		print("usuario repo" + usuario.nombre + usuario)
		amigos.contains(usuario)
	}

	override equals(Object obj) {
		try {
			val other = obj as Usuario
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}

	override hashCode() {
		if(id !== null) id.hashCode else super.hashCode
	}

}
