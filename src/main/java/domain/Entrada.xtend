package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.math.BigDecimal
import javax.persistence.Column
import javax.persistence.Convert
import javax.persistence.Embedded
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.EndNode
import org.neo4j.ogm.annotation.RelationshipEntity
import org.neo4j.ogm.annotation.StartNode
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.GeneratedValue

@RelationshipEntity(type="MIRO")
@Entity
@Accessors
@Observable
@JsonIgnoreProperties(value=#["changeSupport"])
class Entrada {

//	@Id @GeneratedValue
//	@javax.persistence.Id
	@Id  @GeneratedValue
	@org.neo4j.ogm.annotation.Transient
	@JsonIgnore
	Long id

	@JsonIgnore
	@org.neo4j.ogm.annotation.Id
	@Transient
	@org.neo4j.ogm.annotation.GeneratedValue
	Long id_neo
	@Transient
	@StartNode
	@JsonIgnore
	Usuario usuario

	@Column
	@Convert(converter=PeliculaConverter)
	@EndNode
	/*Probar guardar pelicula sin converter */
	Pelicula pelicula

	@Embedded
	Funcion funcion

	@Column
	@org.neo4j.ogm.annotation.Transient
	BigDecimal precioEntrada

//	@Column
//	Long idPelicula
	new() {
	}

//	def setIdPelicula() {
//		idPelicula = pelicula.id
//	}
//
//	def getIdPelicula() {
//		idPelicula
//	}
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
//		this.setIdPelicula()
	}

}
