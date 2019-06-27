package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.math.BigDecimal
import javax.persistence.Column
import javax.persistence.Convert
import javax.persistence.Embedded
import javax.persistence.Entity
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.EndNode
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.RelationshipEntity
import org.neo4j.ogm.annotation.StartNode
import org.uqbar.commons.model.annotations.Observable

@RelationshipEntity(type="MIRO")
@Entity
@Accessors
@Observable
@JsonIgnoreProperties(value=#["changeSupport"])
class Entrada {
	@javax.persistence.Id
	@Id @GeneratedValue
	@JsonIgnore
	Long id

	@Transient
	@StartNode
	@JsonIgnore
	Usuario usuario

	@Column
	@Convert(converter=PeliculaConverter)
	@EndNode
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

	def setUsuario(Usuario usr) {
		usuario = usr
	}

	def getUsuario() {
		usuario
	}

	def setFechaHora() {
		funcion.setFechaHora()
	}

	def validar(Usuario usr) {
		this.setUsuario(usr)
		this.setPrecioEntrada()
		this.setFechaHora()
	}

}
