package ui

import appModel.BuscadorAmigos
import domain.Usuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BuscadorAmigoSimpleWindow extends SimpleWindow<BuscadorAmigos> {

	new(WindowOwner parent, BuscadorAmigos model) {
		super(parent, model)
		title = "Buscar amigos!"
	}

	override protected addActions(Panel actionsPanel) {

		new Button(actionsPanel) => [
			caption = "Agregar amigo"
			onClick [|
				
			]
		]
		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick [|
				this.close
			]
		]

	}

	override protected createFormPanel(Panel mainPanel) {

		val panelBuscador = new Panel(mainPanel)
		customizarPanelBuscador(panelBuscador)
		val panelDatos = new Panel(mainPanel)
		customizarPanelDatos(panelDatos)

	}

	def customizarPanelDatos(Panel panel) {

		new Panel(panel) => [
			new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "usuarios"
				numberVisibleRows = 3

				new Column<Usuario>(it) => [
					title = "Nombre"
					bindContentsToProperty("username")
				]
				new Column<Usuario>(it) => [
					title = "Apellido"
					bindContentsToProperty("apellido")
				]
			]
		]

		new Panel(panel) => [
			new Label(it) => [
				setText = "Amigos sugeridos"
			]
		]

		new Panel(panel) => [
			new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "amigosSugeridos"
				numberVisibleRows = 3

				new Column<Usuario>(it) => [
					title = "Nombre"
					bindContentsToProperty("username")
				]
				new Column<Usuario>(it) => [
					title = "Apellido"
					bindContentsToProperty("apellido")
				]
			]
		]

	}

	def customizarPanelBuscador(Panel panel) {

		new Panel(panel) => [
			it.layout = new ColumnLayout(3)

			new Label(it) => [
				setText = "Buscar Persona"
			]
			new TextBox(it) => []
			new Button(it) => [
				caption = "Buscar"
				onClick [|
				
				]
			]
		]

	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

}
