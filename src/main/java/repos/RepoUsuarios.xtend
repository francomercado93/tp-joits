package repos

import domain.Usuario
import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.NoResultException
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Accessors
@Observable
class RepoUsuarios implements RepoUsrsInterface {

	static RepoUsuarios instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoUsuarios()
		}
		instance
	}

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Joits")

	override create(Usuario usuario) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(usuario)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	override update(Usuario usuario) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(usuario)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def List<Usuario> searchByName(String nombre) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			this.generateWhere(criteria, query, from, nombre)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}

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

	def getEntityType() {
		Usuario
	}

	def generateWhere(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		String nombre) {
		query.where(
			criteria.or(criteria.like(camposUsuario.get("nombre"), "%" + nombre + "%"),
				criteria.like(camposUsuario.get("apellido"), "%" + nombre + "%")))
	}

	def Usuario searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			camposUsuario.fetch("entradasCompradas", JoinType.LEFT) // si un usuario no tiene entradas o amigos los trae igual de la bd
			camposUsuario.fetch("amigos", JoinType.LEFT)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("id"), id))
			val usr = entityManager.createQuery(query).singleResult
			usr.entradasCompradas.forEach(entrada|entrada.setUsuario(usr))
			usr
		} finally {
			entityManager?.close
		}
	}

	def getUsuariosFiltrados(String busqueda, Usuario usuarioSeleccionado) {
		RepoUsuarios.instance.searchByName(busqueda).filter(usr|filtrarAmigosYUsuario(usr, usuarioSeleccionado)).toSet
	}

	def boolean filtrarAmigosYUsuario(Usuario usr, Usuario usuarioSeleccionado) {
		usuarioSeleccionado.id != usr.id && ! usuarioSeleccionado.esAmigo(usr)
	}

	override Usuario searchByUsername(String usrname) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposUsuario = query.from(entityType)
			query.select(camposUsuario)
			query.where(criteria.equal(camposUsuario.get("username"), usrname))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

}
