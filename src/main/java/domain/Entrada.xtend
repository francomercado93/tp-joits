package domain

import java.math.BigDecimal
import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Entrada {

	@Id @GeneratedValue
	Long id

	@Transient
	Pelicula pelicula

	@Transient
	Funcion funcion

	@Column
	BigDecimal precioEntrada

	new() {
	}

	def setPrecioEntrada() {
		precioEntrada = pelicula.precioBase + funcion.valorPorDiaFuncion
	}

	def getPrecioEntrada() {
		precioEntrada
	}

	def LocalDate fechaFuncion() {
		return funcion.getFecha
	}

}
