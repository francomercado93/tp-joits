package domain

import java.math.BigDecimal
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalDate

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
	List<Entrada> entradasCompradas = newArrayList()

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

	@Dependencies("saldo")
	def String getMiSaldo() {
		return "$".concat(saldo.setScale(2, BigDecimal.ROUND_HALF_EVEN).toString)
	}

	def agregarSaldinho(BigDecimal cargaSaldo) {
		saldo = saldo + cargaSaldo
	}

	def agregarAmego(Usuario amigo) {
		amigos.add(amigo)
	}

	def agregarEntrada(Entrada entrada) {
		entradasCompradas.add(entrada)
	}

	@Dependencies("entradasCompradas")
	def List<Pelicula> getPeliculasVistas() {
		return entradasCompradas.filter[entrada|entrada.fechaFuncion() < LocalDate.now()].toList.map[pelicula]
	// return entradasCompradas.map[pelicula]
	}

	def buscarAmigo(String busqueda) {
		// Me parece que el contains evalua todo el string?.
		var String nombreApellido = nombre + apellido
		var String busquedaRegex = busqueda.replaceAll("[^a-zA-Z]", "");
		return nombreApellido.contains(busquedaRegex)
	}

}
