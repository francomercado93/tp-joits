package appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import domain.Usuario

@Observable
@Accessors
class CompraTicket {
	Usuario usuarioSeleccionado

	new(Usuario usuario) {
		this.usuarioSeleccionado = usuario
	}
}
