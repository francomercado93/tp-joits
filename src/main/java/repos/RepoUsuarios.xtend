package repos

import domain.Usuario
import javax.persistence.NoResultException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@Observable
class RepoUsuarios extends RepoDefault<Usuario> {

	static RepoUsuarios instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoUsuarios()
		}
		instance
	}

	def Usuario getUsuario(String usrname, String pass) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("username"), usrname))
//			buscar en bd por username y pass o buscar por username y luego validar en clase usuario?
//			query.where(criteria.equal(camposUsuario.get("password"), pass))
			val usuarioBd = entityManager.createQuery(query).singleResult
			usuarioBd.validarPassword(pass)
			usuarioBd
		} catch (NoResultException e) {
			throw new UserException("Error: usuario " + usrname + " no registrado.", e)
		} finally {
			entityManager?.close
		}
	}

	override busquedaPorNombre(Usuario usuario, String nombre) {
		matcheaNombre(usuario, nombre) || matcheaApellido(usuario, nombre)
	}

	def boolean matcheaApellido(Usuario usuario, String nombre) {
		usuario.apellido.toLowerCase.contains(nombre.toLowerCase)
	}

	def boolean matcheaNombre(Usuario usuario, String nombre) {
		usuario.nombre.toLowerCase.contains(nombre.toLowerCase)
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

	def Usuario searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("entradasCompradas", JoinType.LEFT)
			camposUsuario.fetch("amigos") // , JoinType.LEFT
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	def getAmigosSugeridos(Usuario usuario) {
//		val amigo1 = new Usuario() => [
//			username = "MoeSzyslak"
//			password = "nofuneral"
//			nombre = "Moe"
//			apellido = "Szyslak"
//			edad = 37
//		]
//		val amigo2 = new Usuario() => [
//			username = "CerseiLannister"
//			password = "jaime"
//			nombre = "Cersei"
//			apellido = "Lannister"
//			edad = 45
//		]
//		val amigo3 = new Usuario() => [
//			username = "TucoSalamanca"
//			password = "tuco"
//			nombre = "Tuco"
//			apellido = "Salamanca"
//			edad = 41
//		]
//		val amigosSugeridos = new ArrayList<Usuario>
//		amigosSugeridos.add(amigo1)
//		amigosSugeridos.add(amigo2)
//		amigosSugeridos.add(amigo3)
//		return amigosSugeridos
		return allInstances.take(3).toList
	}
}
