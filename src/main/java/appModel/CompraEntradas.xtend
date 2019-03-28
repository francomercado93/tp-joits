package appModel

import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Usuario
import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import repos.RepoPeliculas

@Observable
@Accessors
class CompraEntradas {

	Usuario usuario
	LocalDate fechaActual
	String peliculaABuscar
	List<Pelicula> cartelera
	Pelicula peliculaSeleccionada
	Funcion funcionSeleccionada

	new(Usuario usuarioSeleccionado) {
		usuario = usuarioSeleccionado
		fechaActual = LocalDate.now
		peliculaABuscar = ""
	}

	def void search() {
		cartelera = RepoPeliculas.instance.lista
	}

	def getPeliculasRecomendadas() {
		RepoPeliculas.instance.getPeliculasRecomendadas()
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada")
	def getImporteEntrada() {
		if (puedeAgregarItem) {
			val entrada = this.crearEntrada()
			entrada.precioEntrada
		}
	}

	def crearEntrada() {
		new Entrada() => [
			pelicula = peliculaSeleccionada
			funcion = funcionSeleccionada
		]
	}
	//No actualiza 
	@Dependencies("usuario")
	def getItemsEnElCarrito() {
		usuario.cantidadEntradasCarrito()
	}

	def void agregarItemCarrito() {
		val entrada = this.crearEntrada()
		usuario.agregarItemCarrito(entrada)
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada")
	def Boolean getPuedeAgregarItem() {
		peliculaSeleccionada !== null && funcionSeleccionada !== null
	}

}
