package ui

import appModel.CompraEntradas
import domain.Pelicula
import domain.Usuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CompraEntradasWindow extends SimpleWindow<CompraEntradas> {

	new(WindowOwner parent, Usuario usuarioSeleccionado) {
		super(parent, new CompraEntradas(usuarioSeleccionado))
		modelObject.search()
	}

	override createContents(Panel mainPanel) {
		new Panel(mainPanel) => [
			this.panelInfo(it)
			this.panelBusqueda(it)
			new Panel(mainPanel) => [
				layout = new ColumnLayout(2)
				this.crearTablaPeliculas(it)
				new Label(it).text = "HOlis"
			]
		]
	}

	def crearTablaPeliculas(Panel panel) {
		new Panel(panel) => [
			val tabla = new Table<Pelicula>(it, typeof(Pelicula)) => [
				items <=> "cartelera"
				numberVisibleRows = 8
				value <=> "peliculaSeleccionada"
			]
			this.agregarColumnas(tabla)

		]

	}

	def agregarColumnas(Table<Pelicula> table) {
		new Column<Pelicula>(table) => [
			title = "Nombre"
			fixedSize = 200
			bindContentsToProperty("titulo")
		]
		new Column<Pelicula>(table) => [
			title = "Fecha"
			fixedSize = 200
			bindContentsToProperty("anio")
		]
		new Column<Pelicula>(table) => [
			title = "Rating"
			fixedSize = 200
			bindContentsToProperty("puntaje")
		]
		new Column<Pelicula>(table) => [
			title = "Genero"
			fixedSize = 200
			bindContentsToProperty("genero")
		]
	}

	def Panel panelBusqueda(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it).text = "Buscar pelicula"
			new TextBox(it) => [
				value <=> "peliculaABuscar"
			]
			new Button(it) => [
				caption = "Buscar"
			]
		]
	}

	def panelInfo(Panel panel) {
		panel.layout = new ColumnLayout(2)
		new Panel(panel) => [
			layout = new HorizontalLayout()
			new Label(it).text = "Usuario logueado:"
			new Label(it) => [
				value <=> "usuario.username"
			]
		]
		new Label(panel) => [
			value <=> "fechaActual"
			alignRight()
		]
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
	}

}
