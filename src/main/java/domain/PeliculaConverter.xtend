package domain

import javax.persistence.AttributeConverter
import javax.persistence.Converter
import repos.RepoPeliculas

@Converter
class PeliculaConverter implements AttributeConverter<Pelicula, String> {
	override convertToDatabaseColumn(Pelicula pelicula) {
		if (pelicula !== null) {
			return pelicula.titulo
		}
	}

	override convertToEntityAttribute(String titulo) {
		RepoPeliculas.instance.searchByName(titulo)
	}

}
