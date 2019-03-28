package ui

import appModel.CompraTicket
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import appModel.UsuarioPanel
import org.uqbar.arena.windows.ErrorsPanel

class CompraTicketSimpleWindow extends SimpleWindow<CompraTicket> {

	new(LoginWindow window, CompraTicket ticket) {
		super(window, ticket)
		title = "Compra Tickets"
	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Panel de Control"
			onClick [|
				new UsuarioPanelSimpleWindow(this, new UsuarioPanel(modelObject.usuarioSeleccionado)).open
			]
		]
	}

	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [

			new Label(it) => [
				setText = "Prueba pantalla"
			]
		]
	}

}
