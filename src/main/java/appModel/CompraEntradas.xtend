package appModel

import domain.Carrito
import domain.CarritoFactory
import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Usuario
import java.time.LocalDate
import java.util.List
//import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.utils.ObservableUtils
import repos.RepoPeliculas
import repos.RepoPeliculasNeo4j

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
		carritoUsr = CarritoFactory.instance.usuarioEntradasRedis(usuario.id)
		peliculaABuscar = ""
	}

	def void search() {
		cartelera = RepoPeliculas.instance.searchByExample(new Pelicula(peliculaABuscar))
	}

	def void setPeliculaSeleccionada(Pelicula pelicula) {
		if (pelicula !== null)
			peliculaSeleccionada = RepoPeliculas.instance.searchByName(pelicula.titulo)
	}

	@Dependencies("usuario")
	def getPeliculasRecomendadas() {
		RepoPeliculasNeo4j.instance.getRecomendadas(usuario)
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
		entrada.validar(usuario)
		entrada
	}

	@Dependencies("carrito")
	def getItemsEnElCarrito() {
		carritoUsr.cantidadEntradas()
	}

	def void agregarItemCarrito() {
		val entrada = this.crearEntrada()
		CarritoFactory.instance.agregarEntradaRedis(usuario.id, entrada)
		carritoUsr.agregarAlCarrito(entrada)
		this.actualizarCarrito()
	}

	def void actualizarCarrito() {
		carritoUsr = CarritoFactory.instance.usuarioEntradasRedis(usuario.id)
		ObservableUtils.firePropertyChanged(this, "itemsEnElCarrito")
		ObservableUtils.firePropertyChanged(this, "peliculasRecomendadas")
	}

	@Dependencies("peliculaSeleccionada", "funcionSeleccionada")
	def Boolean getPuedeAgregarItem() {
		peliculaSeleccionada !== null && funcionSeleccionada !== null
	}

}
