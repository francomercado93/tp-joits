package repos

import domain.Pelicula

interface RepoPeliculasInterface {

	def void create(Pelicula pelicula)

	def Pelicula searchByName(String titulo)

}
