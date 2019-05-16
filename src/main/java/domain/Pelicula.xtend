package domain

import java.math.BigDecimal
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.model.annotations.Observable

@Entity
@Accessors
@Observable
class Pelicula {
	@Id ObjectId id

	static final BigDecimal PRECIO_BASE_PELICULA = new BigDecimal("30")


	String titulo

	Integer anio

	BigDecimal puntaje

	String genero

	List<Funcion> funcionesDisponibles

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
}
