package ui

import appModel.FinalizarCompra
import domain.Entrada
import domain.Usuario
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class FinalizarCompraWindow extends SimpleWindow<FinalizarCompra> {

	new(WindowOwner parent, Usuario usuario) {
		super(parent, new FinalizarCompra(usuario))
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		val elementSelected = new NotNullObservable("entradaSeleccionada")
		new Label(mainPanel).text = "Pelis en el carrito"
		new Panel(mainPanel) => [
			val tabla = new Table<Entrada>(it, typeof(Entrada)) => [
				items <=> "usuario.carrito.entradas"
				value <=> "entradaSeleccionada"
				numberVisibleRows = 5
				width = 600
			]
			this.agregarColumnasTablaEntradas(tabla)
		]
		new Panel(mainPanel) => [
			layout = new ColumnLayout(5)
			new Label(it).text = ""
			new Label(it).text = ""
			new Label(it).text = ""
			new Label(it) => [
				value <=> "totalCarrito"
			]
			new Button(it) => [
				caption = "Eliminar item"
				width = 80
				onClick[|modelObject.eliminarItem()]
				bindEnabled(elementSelected)
			]
		]
		new Panel(mainPanel) => [
			layout = new ColumnLayout(5)
			new Button(it) => [
				caption = "Limpiar carrito"
				width = 90
				enabled <=> "carritoEstaVacio"
				onClick[|modelObject.limpiarCarrito()]
			]
			new Label(it).text = ""
			new Label(it).text = ""

			new Button(it) => [
				caption = "Comprar"
				width = 80
				enabled <=> "carritoEstaVacio"
				onClick[|
					modelObject.comprarEntradas()
					showInfo("Compra realizada con exito!")
				]
			]
			new Button(it) => [
				caption = "Volver atras"
				width = 80
				onClick[|this.close]
				enabled <=> "botonVolver" // Desaparecia el boton volver por alguna razon
				setAsDefault
			]

		]
	}

	def agregarColumnasTablaEntradas(Table<Entrada> table) {
		new Column<Entrada>(table) => [
			title = "Nombre"
			fixedSize = 150
			bindContentsToProperty("pelicula.titulo")
		]
		new Column<Entrada>(table) => [
			title = "Rating"
			fixedSize = 50
			bindContentsToProperty("pelicula.puntaje")
		]
		new Column<Entrada>(table) => [
			title = "Genero"
			fixedSize = 150
			bindContentsToProperty("pelicula.genero")
		]
		new Column<Entrada>(table) => [
			title = "Precio"
			fixedSize = 150
			bindContentsToProperty("precioEntrada")
		]
	}

}
