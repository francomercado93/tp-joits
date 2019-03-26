package domain

import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Funcion {

	static final BigDecimal VALOR_MIERCOLES = new BigDecimal("50")
	static final BigDecimal VALOR_FINDE = new BigDecimal("120")
	static final BigDecimal VALOR_OTROS_DIAS = new BigDecimal("80")
	LocalDate fecha
	LocalTime hora
	String nombreSala

	def valorPorDiaFuncion() {
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
