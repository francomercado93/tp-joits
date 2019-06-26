package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.io.Serializable
import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime
import javax.persistence.Embeddable
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.Property
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Embedded
@Observable
@Embeddable
@JsonIgnoreProperties(value=#["changeSupport"])
class Funcion implements Serializable {

	@Id @GeneratedValue
	@Transient
	Long id

	static final BigDecimal VALOR_MIERCOLES = new BigDecimal("50")
	static final BigDecimal VALOR_FINDE = new BigDecimal("120")
	static final BigDecimal VALOR_OTROS_DIAS = new BigDecimal("80")

	@org.neo4j.ogm.annotation.Transient
	LocalDate fecha

	@Property(name="test")
	String pepe

	@org.neo4j.ogm.annotation.Transient
	String horitaString

//	@Transient
	@org.neo4j.ogm.annotation.Transient
	LocalTime hora

	LocalDateTime fechaHora

	String nombreSala

	new() {
		pepe = "PEPEP"
	}

	def setFechaHora() {
		fechaHora = LocalDateTime.of(fecha, hora)
	}

	def getFechaHora() {
		return fechaHora
	}

	def setHoritaString() {
		horitaString = hora.toString()
	}

	def getHoritaString() {
		return horitaString
	}

	@JsonIgnore
	def getValorPorDiaFuncion() {
		if (this.esMiercoles())
			return VALOR_MIERCOLES
		else if (esFinDeSemana())
			return VALOR_FINDE
		else
			return VALOR_OTROS_DIAS
	}

	def Boolean esFinDeSemana() {
		return fecha.dayOfWeek.toString.equalsIgnoreCase("SATURDAY") ||
			fecha.dayOfWeek.toString.equalsIgnoreCase("SUNDAY")
	}

	def Boolean esMiercoles() {
		return fecha.dayOfWeek.toString.equalsIgnoreCase("WEDNESDAY")
	}
}
