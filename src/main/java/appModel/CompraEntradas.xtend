package appModel

import domain.Pelicula
import domain.Usuario
import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
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

	new(Usuario usuarioSeleccionado) {
		usuario = usuarioSeleccionado
		fechaActual = LocalDate.now
		peliculaABuscar = ""
	}

	def void search() {
		cartelera = RepoPeliculas.instance.lista
	}

}
