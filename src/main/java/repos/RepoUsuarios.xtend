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

//buscar en bd por username y pass o buscar por username y luego validar en clase usuario?
//query.where(criteria.equal(camposUsuario.get("password"), pass))
	def Usuario getUsuario(String usrname, String pass) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("username"), usrname))
			val usuarioBd = entityManager.createQuery(query).singleResult
			usuarioBd.validarPassword(pass)
			usuarioBd
		} catch (NoResultException e) {
			throw new UserException("Error: usuario " + usrname + " no registrado.", e)
		} finally {
			entityManager?.close
		}
	}

	override getEntityType() {
		Usuario
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		String nombre) {
		query.where(
			criteria.or(criteria.like(camposUsuario.get("nombre"), "%" + nombre + "%"),
				criteria.like(camposUsuario.get("apellido"), "%" + nombre + "%")))
	}

	override Usuario searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("entradasCompradas", JoinType.LEFT) // si un usuario no tiene entradas o amigos los trae igual de la bd
			camposUsuario.fetch("amigos", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	def getAmigosSugeridos(Usuario usuario) {
		searchByName("amigo")
	}

}
