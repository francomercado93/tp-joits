package repos

import domain.Usuario
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoUsuarios extends RepoDefault<Usuario> {
	// INSTANCIA REPO
	static RepoUsuarios instance

	// INICIALIZACION REPO
	static def getInstance() {
		if (instance === null) {
			instance = new RepoUsuarios()
		}
		instance
	}

//	override create(Usuario usuario) {
//		super.create(usuario)
//	}
	// Si necesitamos mantener la posición del elemento en la lista, por lo pronto creo que no.
	// override update(Usuario usuario) {
	// var indice = lista.indexOf(searchById(usuario.id))
	// lista.set(indice, usuario)
	// }
	def Usuario getUsuario(String usrname, String pass) {
		// Delego al usuario la validación o el repo debería validar? A quién le corresponde?
		// return lista.findFirst(usuario|usuario.username == usrname && usuario.password == pass)
		return allInstances.findFirst(usuario|usuario.validarse(usrname, pass))
	}

	def List<Usuario> getAll() {
		return allInstances
	}

	def List<Usuario> searchAmigo(String busqueda) {
		return allInstances.filter[usuario|usuario.buscarAmigo(busqueda)].toList
	}

	override busquedaPorNombre(Usuario usuario, String nombre) {
		usuario.username.equalsIgnoreCase(nombre)
	}

	def getAmigosSugeridos(Usuario usuario) {
		return allInstances.filter[usrRepo|usrRepo.edad <= usuario.edad && usrRepo !== usuario].toList
	}

	override getEntityType() {
		Usuario
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Usuario usuario) {
		if (usuario.username !== null) {
			query.where(criteria.equal(camposUsuario.get("username"), usuario.username))
		}
	}

	// se obtienen las entradas compradas y el usuario completo con un solo query
	def Usuario searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("entradasCompradas", JoinType.LEFT)
			camposUsuario.fetch("amigos", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
}
