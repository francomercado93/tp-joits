package domain

import java.math.BigDecimal
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Entity
@Observable
@Accessors
class Usuario {

	@javax.persistence.Id
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
//	@Relationship(type="ES_AMIGO", direction=Relationship.INCOMING)
//averiguar porque rompe, falta alguna anottation en clase usuario para cambiar el nombre de la relacion en el grafo=?
	Set<Usuario> amigos

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumn(name="usuario_id")
	@Relationship(type="MIRO")
	Set<Entrada> entradasCompradas

	@Column(nullable=false, columnDefinition="decimal(19,2) default 0")
	BigDecimal saldo

	new() {
		saldo = new BigDecimal("0")
		amigos = new HashSet<Usuario>
		entradasCompradas = new HashSet<Entrada>
	}

	def agregarAmigo(Usuario usuario) {
		amigos.add(usuario)
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

	def comprarEntradas(Carrito carrito) {
		carrito.validarEntradas(this)
		carrito.entradas.forEach(
			entrada |
				print(
					"Pelicula:" + entrada.pelicula.titulo + "\n nombreSala: " + entrada.funcion.nombreSala +
						"\n FechaHora: " + entrada.funcion.fechaHora + "\n Usuario: " + entrada.usuario.username)
		)
		if (!this.tieneSaldoSuficiente(carrito))
			throw new UserException("No tiene saldo suficiente")
		this.finalizarCompra(carrito)
	}

	def finalizarCompra(Carrito carrito) {
		this.descontarSaldo(carrito)
		this.agregarEntradasCompradas(carrito.entradas)
		carrito.vaciarCarrito()
	}

	def descontarSaldo(Carrito carrito) {
		saldo = saldo - carrito.total
	}

	def Boolean tieneSaldoSuficiente(Carrito carrito) {
		return 1 == saldo.compareTo(carrito.total) || 0 == saldo.compareTo(carrito.total) // saldo >= carrito.total()
	}

	def agregarEntradasCompradas(List<Entrada> entradas) {
		entradasCompradas.addAll(entradas) // devuelve boolean
	}

	def validarPassword(String pass) {
		if (pass === null)
			throw new UserException("Ingrese contraseña")
		if (!password.equals(pass))
			throw new UserException("Contraseña no valida")
	}

	def totalCarrito(Carrito carrito) {
		carrito.total
	}

	def esAmigo(Usuario usuario) {
		amigos.contains(usuario)
	}

	// se cargan los amigos del usuario en el usuarioPanel y luego en el buscador de amigos se obtenian del repo
	// los usuarios que no son amigos de usuario, pero no filtraba bien la lista de no amigos porque los tomaba como usuarios diferentes
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

	def void setEdad(Integer unaEdad) {
		if (unaEdad === null || unaEdad <= 0 || unaEdad > 150) {
			throw new UserException("Debe ingresar una edad valida")
		}
		this.edad = unaEdad
	}
}
