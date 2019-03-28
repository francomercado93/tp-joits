package ui

import appModel.FinalizarCompra
import domain.Usuario
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class FinalizarCompraWindow extends SimpleWindow<FinalizarCompra> {

	new(WindowOwner parent, Usuario usuario) {
		super(parent, new FinalizarCompra(usuario))
	}

	override protected addActions(Panel actionsPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
