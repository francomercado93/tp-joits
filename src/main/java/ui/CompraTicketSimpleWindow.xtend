package ui

import appModel.CompraEntradas
import appModel.UsuarioPanel
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.SimpleWindow

class CompraTicketSimpleWindow extends SimpleWindow<CompraEntradas> {

	new(LoginWindow window, CompraEntradas model) {
		super(window, model)
		title = "Compra Tickets"
	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Panel de Control"
			onClick [|
				new UsuarioPanelSimpleWindow(this, new UsuarioPanel(modelObject.usuario)).open
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
