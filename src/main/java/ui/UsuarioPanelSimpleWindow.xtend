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
			layout = new ColumnLayout(2)
			new Label(it) => [
				setText = "Usuario"
			]
			new Label(it) => [
				setText = "Peperoni"
			]
			new Label(it) => [
				setText = "Edad"
			]
			new TextBox(it) => []

			new Label(it) => [
				setText = "Amigos"
			]
		]

		new Panel(panel) => [
			new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "amigos"
				numberVisibleRows = 3

				new Column<Usuario>(it) => [
					title = "Nombre"
					bindContentsToProperty("username")
				]
				new Column<Usuario>(it) => [
					title = "Apellido"
					bindContentsToProperty("password")
				]
			]
		]

		new Panel(panel) => [
			new Button(it) => [
				caption = "Buscar Amigos"
				onClick [|
//				new BuscadorAmigoSimpleWindow(this, new BuscadorAmigos(modelObject.usuarioSeleccionado) => [
//					onAccept[this.modelObject.crearCelular(celular)]
//					open
//				]
					new BuscadorAmigoSimpleWindow(this, new BuscadorAmigos(modelObject.usuarioSeleccionado)).open
				]
			]
		]
	}

	def customizarPanelDerecho(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it) => [
				setText = "Saldo:"
			]
			new Label(it) => [
				setText = "$1500"
			]
		]
		new Panel(panel) => [
			layout = new ColumnLayout(3)
			new Label(it) => [
				setText = "Cargar Saldo:"
			]
			new TextBox(it) => [
				// TODO: Modificar.
				value <=> "usuarioSeleccionado.username"
			]
			new Button(it) => [
				caption = "Cargar"
				onClick [|
				//new UsuarioPanelSimpleWindow(this, new UsuarioPanel(modelObject.usuarioSeleccionado)).open
				]
			]
		]
		new Panel(panel) => [
			new Label(it) => [
				setText = "Pelis Vistas"
			]
		]
		new Panel(panel) => [
			layout = new HorizontalLayout
			new List(it) => [
				allowNull(true)
				items <=> "amigos"
			// value <=> "usuarioSeleccionado" //TODO: Creo que no es necesario si solo sirve para visualizar una lista?
			]
		]
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Button(it) => [
				caption = "Aceptar"
				onClick [|
				
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
