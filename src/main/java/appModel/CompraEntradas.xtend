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
	Carrito carrito

	new(Usuario usuarioSeleccionado) {
		usuario = usuarioSeleccionado
		fechaActual = LocalDate.now
		carrito = usuarioSeleccionado.carrito // se carga de otra forma, a traves de un repo de carritos
//		carrito = new Carrito
		peliculaABuscar = ""
	}

	def void search() {
		cartelera = RepoPeliculas.instance.search(peliculaABuscar)
	}

	def getPeliculasRecomendadas() {
		RepoPeliculas.instance.getPeliculasRecomendadas()
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada") // Hace falta?
	def getImporteEntrada() { // muestra el valor si se seleccino una pelicula y una funcion
		if (puedeAgregarItem) {
			val entrada = this.crearEntrada()
			return "$".concat(entrada.precioEntrada.toString)
		}
	}

	def Entrada crearEntrada() {
		new Entrada() => [
			pelicula = peliculaSeleccionada
			funcion = funcionSeleccionada
		]
	}

	// no actualiza
	@Dependencies("carrito")
	def getItemsEnElCarrito() {
		carrito.cantidadEntradas()
	}

	def void agregarItemCarrito() {
		carrito.agregarAlCarrito(this.crearEntrada())
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
