package ui

import appModel.CompraEntradas
import appModel.UsuarioPanel
import domain.Funcion
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

	new(WindowOwner owner, Usuario usuarioSeleccionado) {
		super(owner, new CompraEntradas(usuarioSeleccionado))
		title = "Joits - Compra de tickets"
		taskDescription = "Seleccione una pelicula y una funcion"
		modelObject.search()
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			new Panel(mainPanel) => [
				layout = new ColumnLayout(2)
				this.crearPanelIzquierdo(it)
				this.crearPanelDerecho(it)
			]
			new Panel(mainPanel) => [
				this.crearPanelBotones(it)
			]
		]
	}

	def crearPanelBotones(Panel panel) {
		new Button(panel) => [
			caption = "Agregar al carrito"
			width = 900
			alignCenter
			enabled <=> "puedeAgregarItem"
			onClick[|modelObject.agregarItemCarrito()]

		]
		new Panel(panel) => [
			layout = new ColumnLayout(4)
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it).text = "Items en el carrito:"
				new Label(it) => [
					value <=> "itemsEnElCarrito"
				]
			]
			new Button(it) => [
				caption = "Finalizar compra"
				width = 150
				onClick[|new FinalizarCompraWindow(this, modelObject.usuario).open]
			]
			new Label(it).text = ""
			new Button(it) => [
				caption = "Panel de control"
				width = 150
				onClick(|new UsuarioPanelSimpleWindow(this, new UsuarioPanel(modelObject.usuario)).open)
			]
		]
	}

	def crearPanelDerecho(Panel panel) {
		val panelDer = new Panel(panel)
		new Panel(panelDer) => [
			new Panel(it) => [
				layout = new HorizontalLayout
				new Label(it).text = "Fecha: "
				new Label(it) => [
					value <=> "fechaActual"
				]
			]
			new Label(it).text = "Funciones"
		]
		new Panel(panelDer) => [
			val tablaFunciones = new Table<Funcion>(it, typeof(Funcion)) => [
				items <=> "peliculaSeleccionada.funcionesDisponibles"
				value <=> "funcionSeleccionada"
				numberVisibleRows = 9
				width = 400
			]
			this.agregarColumnasTablaFunciones(tablaFunciones)
		]
		new Panel(panelDer) => [
			layout = new HorizontalLayout
			new Label(it).text = "Importe de la entrada seleccionada: "
			new Label(it) => [
				value <=> "importeEntrada"
			]
		]
	}

	def agregarColumnasTablaFunciones(Table<Funcion> table) {
		new Column<Funcion>(table) => [
			title = "Fecha"
			fixedSize = 150
			bindContentsToProperty("fecha")
		]

		new Column<Funcion>(table) => [
			title = "Hora"
			fixedSize = 100
			bindContentsToProperty("hora")
		]

		new Column<Funcion>(table) => [
			title = "Sala"
			fixedSize = 150
			bindContentsToProperty("nombreSala")
		]
	}

	def crearPanelIzquierdo(Panel panel) {
		val panelIzq = new Panel(panel)
		new Panel(panelIzq) => [
			layout = new HorizontalLayout()
			new Label(it).text = "Usuario logueado:"
			new Label(it) => [
				value <=> "usuario.username"
			]
		]
		panelBusqueda(panelIzq)

		new Panel(panelIzq) => [
			val tablaPelicula = new Table<Pelicula>(it, typeof(Pelicula)) => [
				items <=> "cartelera"
				value <=> "peliculaSeleccionada"
				numberVisibleRows = 6
			]
			this.agregarColumnas(tablaPelicula)
			val tablaRecomendadas = new Table<Pelicula>(it, typeof(Pelicula)) => [
				items <=> "peliculasRecomendadas"
				numberVisibleRows = 6
				value <=> "peliculaSeleccionada"
			]
			this.agregarColumnas(tablaRecomendadas)
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
			fixedSize = 50
			bindContentsToProperty("anio")
		]
		new Column<Pelicula>(table) => [
			title = "Rating"
			fixedSize = 50
			bindContentsToProperty("puntaje")
		]
		new Column<Pelicula>(table) => [
			title = "Genero"
			fixedSize = 100
			bindContentsToProperty("genero")
		]
	}

	def Panel panelBusqueda(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it) => [
				text = "Buscar pelicula"
				width = 80
			]
			new TextBox(it) => [
				value <=> "peliculaABuscar"
				width = 200
			]
			new Button(it) => [
				caption = "Buscar"
				width = 100
				onClick[|modelObject.search()]
				disableOnError
			]
		]
	}

}
