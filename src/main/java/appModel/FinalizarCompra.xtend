package appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import domain.Usuario

@Accessors
@Observable
class FinalizarCompra {
	Usuario usuario

	new(Usuario usr) {
		usuario = usr
	}

}
