package ui

import appModel.BuscadorAmigos
import domain.Usuario
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BuscadorAmigoSimpleWindow extends TransactionalDialog<BuscadorAmigos> {

	new(WindowOwner parent, BuscadorAmigos model) {
		super(parent, model)
		title = "Buscar amigos!"
		this.modelObject.search()
	}

	override protected addActions(Panel actionsPanel) {

		new Button(actionsPanel) => [
			caption = "Agregar amigo"
			onClick [|
				this.modelObject.agregarAmigo()
				this.accept
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
			it.layout = new HorizontalLayout
			new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "usuarios"
				value <=> "amigoSeleccionado"
				numberVisibleRows = 4

				new Column<Usuario>(it) => [
					fixedSize = 150
					title = "Nombre"
					bindContentsToProperty("username")
				]
				new Column<Usuario>(it) => [
					fixedSize = 150
					title = "Apellido"
					bindContentsToProperty("apellido")
				]
			]
		]

		new Panel(panel) => [
			it.layout = new HorizontalLayout
			new Label(it) => [
				setText = "Amigos sugeridos"
			]
		]

		new Panel(panel) => [
			it.layout = new HorizontalLayout
			new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "amigosSugeridos"
				value <=> "amigoSeleccionado"
				numberVisibleRows = 4

				new Column<Usuario>(it) => [
					fixedSize = 150
					title = "Nombre"
					bindContentsToProperty("username")
				]
				new Column<Usuario>(it) => [
					fixedSize = 150
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
				width = 100
				alignLeft
				setText = "Buscar Persona:"
			]
			new TextBox(it) => [
				width = 90
			]
			new Button(it) => [
				// width = 102 TODO: Por qué se ven mal las columnas?
				width = 101
				caption = "Buscar"
				onClick [|
				
				]
			]
		]

	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

}
