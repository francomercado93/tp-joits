package repos

import domain.Entrada
import domain.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoUsuarios extends Repositorio<Usuario> {
// INSTANCIA REPO
	static RepoUsuarios instance

// INICIALIZACION REPO
	static def getInstance() {
		if (instance === null) {
			instance = new RepoUsuarios()
		}
		instance
	}

	override void create(Usuario usuario) {
		this.asignarId(usuario)
		super.create(usuario)
	}

// Si necesitamos mantener la posición del elemento en la lista, por lo pronto creo que no.
//	override update(Usuario usuario) {
//		var indice = lista.indexOf(searchById(usuario.id))
//		lista.set(indice, usuario)
//	}
	override Usuario searchById(long id) {
		lista.findFirst(usuario|usuario.id == id)
	}

	def Usuario getUsuario(String usrname, String pass) {
		// Delego al usuario la validación o el repo debería validar? A quién le corresponde?
		// return lista.findFirst(usuario|usuario.username == usrname && usuario.password == pass)
		return lista.findFirst(usuario|usuario.validarse(usrname, pass))
	}

	def addEntrada(Usuario usuario, Entrada entrada) {
		searchById(usuario.id).agregarEntrada(entrada)
	}

	def List<Usuario> getAll() {
		return this.lista
	}

	def List<Usuario> searchAmigo(String busqueda) {
		return lista.filter[usuario|usuario.buscarAmigo(busqueda)].toList
	}

	override asignarId(Usuario usuario) {
		if (usuario.id == -1) {
			usuario.id = new Long(id)
			this.id = id + 1
		}
	}

	override busquedaPorNombre(Usuario usuario, String nombre) {
		usuario.username.equalsIgnoreCase(nombre)
	}
	
	def getAmigosSugeridos(Usuario usuario) {
		return lista.filter[usrRepo | usrRepo.edad  <= usuario.edad && usrRepo !== usuario].toList
	}

}
