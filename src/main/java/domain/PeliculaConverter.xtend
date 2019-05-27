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
//		else
//			return pelicula.genero
//	if (pelicula instanceof Saga)
//
//		return "asdasd"
}

	override convertToEntityAttribute(String titulo) {
		val peliculaABuscar = new Pelicula(titulo)
		RepoPeliculas.instance.searchByExample(peliculaABuscar).head
	}

}
