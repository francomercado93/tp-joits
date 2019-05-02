package appModel

import domain.Carrito
import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Usuario
import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
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
	Carrito carritoUsr

	new(Usuario usuarioSeleccionado) {
		usuario = usuarioSeleccionado
		fechaActual = LocalDate.now
		carritoUsr = usuario.carrito
		peliculaABuscar = ""
	}

	def void setPeliculaSeleccionada(Pelicula pelicula) {
		if (pelicula !== null)
			peliculaSeleccionada = RepoPeliculas.instance.searchById(pelicula.id)
	}

	def void search() {
		cartelera = RepoPeliculas.instance.searchByName(peliculaABuscar)
	}

	def getPeliculasRecomendadas() {
		RepoPeliculas.instance.getPeliculasRecomendadas()
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada")
	def getImporteEntrada() { // muestra el valor si se seleccino una pelicula y una funcion
		if (puedeAgregarItem) {
			val entrada = this.crearEntrada()
			return "$".concat(entrada.precioEntrada.toString)
		}
	}

	def Entrada crearEntrada() {
		val entrada = new Entrada() => [
			pelicula = peliculaSeleccionada
			funcion = funcionSeleccionada
		]
		entrada.setPrecioEntrada()
		entrada
	}

	@Dependencies("carrito")
	def getItemsEnElCarrito() {
		carritoUsr.cantidadEntradas()
	}

	def void agregarItemCarrito() {
		carritoUsr.agregarAlCarrito(this.crearEntrada())
		this.actualizarCarrito()
	}

	def void actualizarCarrito() {
		ObservableUtils.firePropertyChanged(this, "itemsEnElCarrito")
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada")
	def Boolean getPuedeAgregarItem() {
		peliculaSeleccionada !== null && funcionSeleccionada !== null
	}

}
