package ui

import appModel.UsuarioPanel
import domain.Usuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.List
import appModel.BuscadorAmigos
import org.uqbar.arena.widgets.NumericField

class UsuarioPanelSimpleWindow extends SimpleWindow<UsuarioPanel> {

	new(WindowOwner parent, UsuarioPanel model) {
		super(parent, model)
		title = "Joits - Panel de control"
	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout
		// Panel izquierdo
		val panelIzquierdo = new Panel(mainPanel)
		panelIzquierdo.layout = new VerticalLayout
		customizarPanelIzquierdo(panelIzquierdo)
		// Panel derecho
		val panelDerecho = new Panel(mainPanel)
		panelDerecho.layout = new VerticalLayout
		customizarPanelDerecho(panelDerecho)
	}

	def customizarPanelIzquierdo(Panel panel) {
		new Panel(panel) => [
			it.layout = new ColumnLayout(2)
			new Label(it) => [
				setText = "Usuario"
				height = 30
			]
			new Label(it) => [
				value <=> "usuarioSeleccionado.nombre"
				height = 30
			]
			new Label(it) => [
				setText = "Edad"
			]
			new TextBox(it) => [
				value <=> "usuarioEdad"
				width = 75
			]
			new Label(it) => []
			new Label(it) => []
			new Label(it) => [
				setText = "Amigos"
			]
		]

		new Panel(panel) => [
			new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "usuarioSeleccionado.amigos"
				numberVisibleRows = 3

				new Column<Usuario>(it) => [
					fixedSize = 80
					title = "Nombre"
					bindContentsToProperty("nombre")
				]
				new Column<Usuario>(it) => [
					fixedSize = 80
					title = "Apellido"
					bindContentsToProperty("apellido")
				]
			]
		]

		new Panel(panel) => [
			new Button(it) => [
				caption = "Buscar Amigos"
				onClick([|
					new BuscadorAmigoSimpleWindow(this, new BuscadorAmigos(modelObject.usuarioSeleccionado)) => [
						onAccept[this.modelObject.actualizar()]
						open
					]
				])
			]
		]
	}

	def customizarPanelDerecho(Panel panel) {
		new Panel(panel) => [
			it.layout = new ColumnLayout(3)
			new Label(it) => [
				alignLeft
				setText = "Saldo:"
				height = 20
			]
			new Label(it) => [
				alignLeft
				value <=> "usuarioSeleccionado.miSaldo"
				height = 20
			]
		]
		new Panel(panel) => [
			it.layout = new ColumnLayout(3)
			new Label(it) => [
				alignLeft
				setText = "Cargar Saldo:"
				width = 75
			]
			new NumericField(it) => [
				value <=> "cargarSaldo"
				width = 50
			]
			new Button(it) => [
				caption = "Cargar"
				width = 75
				onClick [|
					modelObject.puedeAgregarSaldo
					modelObject.agregarSaldo
					showInfo("Saldo actualizado!")
				]
			]
		]
		new Panel(panel) => [
			it.layout = new VerticalLayout
			new Label(it) => [
				height = 10
			]
			new Label(it) => [
				setText = "Pelis Vistas"
			]
		]
		new Panel(panel) => [
			it.layout = new HorizontalLayout
			new List(it) => [
				width = 213
				height = 56
				allowNull(true)
				items <=> "usuarioSeleccionado.peliculasVistas"
			// value <=> "usuarioSeleccionado" //TODO: Creo que no es necesario ya que solo quiero visualizar una lista.
			]
		]
		new Panel(panel) => [
			it.layout = new HorizontalLayout
			new Button(it) => [
				caption = "Aceptar"
				onClick [|
					modelObject.actualizarUsuario()
					close
				]
			]
			new Button(it) => [
				caption = "Cancelar"
				onClick [|
					this.close
				]
			]
		]

	}

	override protected addActions(Panel actionsPanel) {
	}

}
