package domain

import java.math.BigDecimal
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.model.annotations.Observable
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties

//sin asignar un nuevo nombre a la collection, se me generaban dos colecciones Pelicula y Saga en la base
@Entity(value="Peliculas", noClassnameStored=false)
@Accessors
@Observable
@JsonIgnoreProperties(value=#["changeSupport"])
class Pelicula {
	@JsonIgnore
	@Id ObjectId id

	static final BigDecimal PRECIO_BASE_PELICULA = new BigDecimal("30")

	String titulo
	@JsonIgnore
	Integer anio
	@JsonIgnore
	BigDecimal puntaje
	@JsonIgnore
	String genero
	@JsonIgnore
	List<Funcion> funcionesDisponibles
	@JsonIgnore
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
