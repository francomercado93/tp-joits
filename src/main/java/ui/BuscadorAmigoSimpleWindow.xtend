package ui

import appModel.BuscadorAmigos
import domain.Usuario
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
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

//class BuscadorAmigoSimpleWindow extends TransactionalDialog<BuscadorAmigos> {
//con transactional no se actualiza correctamente, no se agrega el amigo y llega un usuario vacio 
class BuscadorAmigoSimpleWindow extends SimpleWindow<BuscadorAmigos> {

	new(WindowOwner parent, Usuario usuario) {
		super(parent, new BuscadorAmigos(usuario))
		title = "Buscar amigos!"
		modelObject.search()
	}

	override protected addActions(Panel actionsPanel) {
		val elementSelected = new NotNullObservable("amigoSeleccionado")

		new Button(actionsPanel) => [
			caption = "Aceptar"
			onClick [|
				this.modelObject.actualizarUsuario()
				this.close
			]
		]
		new Button(actionsPanel) => [
			caption = "Agregar amigo"
			onClick [|
				this.modelObject.agregarAmigo()
//				this.accept
			]
			bindEnabled(elementSelected)
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
			val tablaAmigos = new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "usuariosFiltrados"
				value <=> "amigoSeleccionado"
				numberVisibleRows = 4
			]
			this.llenarGridAmigos(tablaAmigos)
		]

		new Panel(panel) => [
			it.layout = new HorizontalLayout
			new Label(it) => [
				setText = "Amigos sugeridos"
			]
		]

		new Panel(panel) => [
			it.layout = new HorizontalLayout
			val tablaSuegeridos = new Table<Usuario>(it, typeof(Usuario)) => [
				items <=> "amigosSugeridos"
				value <=> "amigoSeleccionado"
				numberVisibleRows = 4
			]
			this.llenarGridAmigos(tablaSuegeridos)
		]

	}

	def llenarGridAmigos(Table<Usuario> table) {
		new Column<Usuario>(table) => [
			fixedSize = 150
			title = "Nombre"
			bindContentsToProperty("nombre")
		]
		new Column<Usuario>(table) => [
			fixedSize = 150
			title = "Apellido"
			bindContentsToProperty("apellido")
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
				value <=> "busqueda"
			]
			new Button(it) => [
				// width = 102 Por qué se ven mal las columnas? Porque si.
				width = 101
				caption = "Buscar"
				onClick [|
					this.modelObject.search
				]
			]
		]

	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

}
