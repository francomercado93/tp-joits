package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.io.Serializable
import java.math.BigDecimal
import java.time.LocalDate
//import java.time.LocalDateTime
import java.time.LocalTime
import javax.persistence.Embeddable
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.Transient
import org.uqbar.commons.model.annotations.Observable
import org.neo4j.ogm.annotation.typeconversion.DateString
import java.util.Date
import java.time.Instant
import java.time.ZoneId

@Accessors
@Embedded
@Observable
@Embeddable
@JsonIgnoreProperties(value=#["changeSupport"])
class Funcion implements Serializable {

	@Id @GeneratedValue
	@javax.persistence.Transient
	Long id

	static final BigDecimal VALOR_MIERCOLES = new BigDecimal("50")
	static final BigDecimal VALOR_FINDE = new BigDecimal("120")
	static final BigDecimal VALOR_OTROS_DIAS = new BigDecimal("80")

	LocalDate fecha

	@Transient
	LocalTime hora

	@DateString("HH:mm")
	Date fechaHora

	String nombreSala

	new() {
		fechaHora = new Date()
	}

	def setFechaHora() {
		val Instant instant = hora.atDate(LocalDate.of(1900, 1, 1)).atZone(ZoneId.systemDefault()).toInstant();
		fechaHora = Date.from(instant);
	}

	def getFechaHora() {
		return fechaHora
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
