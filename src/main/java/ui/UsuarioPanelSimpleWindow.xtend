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

class UsuarioPanelSimpleWindow extends SimpleWindow<UsuarioPanel> {

	new(WindowOwner parent, UsuarioPanel model) {
		super(parent, model)
		title = "Joits - Panel de control"
	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new HorizontalLayout

		val panelIzquierdo = new Panel(mainPanel)
		panelIzquierdo.layout = new VerticalLayout
		crearPanelAmigos(panelIzquierdo)
		val panelDerecho = new Panel(mainPanel)
		panelDerecho.layout = new VerticalLayout
	}

	def crearPanelAmigos(Panel panel) {
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
				setText = "Usuario"
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

	}

	def crearPanelInfoPersonal(Panel panel) {
		new Panel(panel) => [
			layout = new HorizontalLayout
			new Label(it) => [
				setText = "qwe"
			]
		]
	}

	override protected addActions(Panel actionsPanel) {
//		new Button(actionsPanel) => [
//			caption = "Buscar Amigos"
//			onClick [|
//				new UsuarioPanelSimpleWindow(this, new UsuarioPanel(modelObject.usuarioSeleccionado)).open
//			]
//		]
	}

}
