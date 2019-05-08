package domain

import java.math.BigDecimal
import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Entrada {

	@Id @GeneratedValue
	Long id
// necesito la pelicula y la funcion cuando recupero las entradas
	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="pelicula_id")
	Pelicula pelicula
//, referencedColumnName="id"
	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="funcion_id")
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
