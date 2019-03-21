package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.Set

@Observable
@Accessors
class Usuario {
	int id = -1
	String username
	String password
	String nombre
	String apellido
	int edad
	Set<Usuario> amigos = newHashSet()
}
