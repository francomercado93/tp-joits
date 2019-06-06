package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.math.BigDecimal
import javax.persistence.Column
import javax.persistence.Convert
import javax.persistence.Embedded
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
@JsonIgnoreProperties(value=#["changeSupport"])
class Entrada {
	// comentario
	@Id @GeneratedValue
	@JsonIgnore
	Long id

	@Column
	@Convert(converter=PeliculaConverter)
	//@JsonIgnore
//	@Transient
	Pelicula pelicula

	@Embedded
	// @JsonIgnore
	Funcion funcion

	@Column
	BigDecimal precioEntrada

//
//	@Column
//	String nombrePelicula
	new() {
	}

	def setPrecioEntrada() {
		precioEntrada = pelicula.precioBase + funcion.valorPorDiaFuncion
	}

	def getPrecioEntrada() {
		precioEntrada
	}
}
