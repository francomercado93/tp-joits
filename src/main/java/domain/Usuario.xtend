package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.Set
import java.math.BigDecimal

@Observable
@Accessors
class Usuario {
	long id
	String username
	String password
	String nombre
	String apellido
	int edad
	Set<Usuario> amigos = newHashSet()
	BigDecimal saldo

	new() {
		saldo = new BigDecimal(0)
		id = -1
	}

	def agregarSaldo(BigDecimal numero) {
		saldo = saldo + numero
	}

	def validarse(String user, String pass) {
		return username == user && password == pass
	}

}
