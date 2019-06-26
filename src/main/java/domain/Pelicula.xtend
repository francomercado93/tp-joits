package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import java.math.BigDecimal
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.uqbar.commons.model.annotations.Observable
import org.neo4j.ogm.annotation.Transient

@Entity(value="Peliculas", noClassnameStored=false)
@Accessors
@Observable
@JsonIgnoreProperties(value=#["changeSupport"])
class Pelicula {

	@org.mongodb.morphia.annotations.Id
	@JsonIgnore
	@Id @GeneratedValue
	Long id

	static final BigDecimal PRECIO_BASE_PELICULA = new BigDecimal("30")

	String titulo

	@JsonIgnore
	Integer anio

	BigDecimal puntaje

	String genero

	@Transient
	@JsonIgnore
	List<Funcion> funcionesDisponibles

	@JsonIgnore
	@Transient
	BigDecimal precioBase

	new() {
		precioBase = PRECIO_BASE_PELICULA
		funcionesDisponibles = newArrayList
	}

	new(String unTitulo) {
		titulo = unTitulo
		precioBase = PRECIO_BASE_PELICULA
		funcionesDisponibles = newArrayList
	}

	override toString() {
		return titulo
	}

	def agregarFuncion(Funcion funcion) {
		funcionesDisponibles.add(funcion)
	}

	override equals(Object obj) {
		try {
			val other = obj as Pelicula
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}

	override hashCode() {
		if(id !== null) id.hashCode else super.hashCode
	}
}
