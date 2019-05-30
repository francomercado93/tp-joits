package domain

import java.math.BigDecimal
import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Convert
import javax.persistence.Embedded
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalTime

@Entity
@Accessors
@Observable
class Entrada {

	@Id @GeneratedValue
	Long id

	@Column
	@Convert(converter=PeliculaConverter)
	Pelicula pelicula

	@Embedded
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

	def LocalTime horaFuncion() {
		return funcion.getHora
	}

}
