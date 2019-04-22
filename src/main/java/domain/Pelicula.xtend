package domain

import java.math.BigDecimal
import java.util.ArrayList
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
@Inheritance(strategy=InheritanceType.JOINED)
class Pelicula {
	static final BigDecimal PRECIO_BASE_PELICULA = new BigDecimal("30")

	@Id @GeneratedValue
	Long id

	@Column(length=255)
	String titulo

	@Column
	Integer anio

	@Column
	BigDecimal puntaje

	@Column(length=150)
	String genero

	@OneToMany(fetch=FetchType.LAZY)
	List<Funcion> funcionesDisponibles = new ArrayList<Funcion>

	@Column
	BigDecimal precioBase

	new() {
		precioBase = PRECIO_BASE_PELICULA
	}

	override toString() {
		return titulo
	}

	def agregarFuncion(Funcion funcion) {
		funcionesDisponibles.add(funcion)
	}

}
