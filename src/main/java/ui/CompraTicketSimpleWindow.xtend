package ui

import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import appModel.CompraTicket
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel

class CompraTicketSimpleWindow extends SimpleWindow<CompraTicket> {

	new(LoginWindow window, CompraTicket ticket) {
		super(window, ticket)
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {
		title = "Compra Tickets"

		new Label(mainPanel) => [
			text = "Password"
		]
	}

}
