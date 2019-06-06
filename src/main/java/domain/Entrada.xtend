package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty
import java.math.BigDecimal
import java.time.format.DateTimeFormatter
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
	static String DATE_PATTERN = "dd/MM/yyyy"
	static String TIME_PATTERN = "HH:mm"
	// comentario
	@Id @GeneratedValue
	@JsonIgnore
	Long id

	@Column
	@Convert(converter=PeliculaConverter)
	@JsonIgnore
//	@Transient
	Pelicula pelicula

	@Embedded
	@JsonIgnore
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

//	def setNombrePelicula() {
//		nombrePelicula = this.tituloPelicula
//	}
//
//	def getNombrePelicula() {
//		nombrePelicula
//	}
	@JsonProperty("pelicula")
	def String getTituloPelicula() {
		return pelicula.toString()
	}

	@JsonProperty("fecha")
	def String getFechaFuncionAsString() {
		formatter.format(funcion.fecha)
	}

	@JsonProperty("hora")
	def String getHoraFuncionAsStrin() {
		return timeFormatter.format(funcion.hora)
	}

	@JsonProperty("nombreSala")
	def String getNombreSala() {
		return funcion.nombreSala
	}

	def formatter() {
		DateTimeFormatter.ofPattern(DATE_PATTERN)
	}

	def timeFormatter() {
		DateTimeFormatter.ofPattern(TIME_PATTERN)
	}

}
