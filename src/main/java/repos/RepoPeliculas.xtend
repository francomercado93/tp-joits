package repos

import domain.Pelicula
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoPeliculas extends RepoDefault<Pelicula> {

	static RepoPeliculas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPeliculas()
		}
		instance
	}

	override busquedaPorNombre(Pelicula pelicula, String nombre) {
		pelicula.titulo.equalsIgnoreCase(nombre) || pelicula.titulo.toLowerCase.indexOf(nombre.toLowerCase()) != -1
	}

	override getEntityType() {
		Pelicula
	}

	def getPeliculasRecomendadas() {
		return allInstances.take(3).toList
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Pelicula> query, Root<Pelicula> camposPelicula,
		String titulo) {
//		if (pelicula.titulo !== null) {
		query.where(criteria.like(camposPelicula.get("titulo"), "%" + titulo + "%"))
//		}
	}

	def Pelicula searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposPelicula = query.from(entityType)
			camposPelicula.fetch("funcionesDisponibles", JoinType.LEFT)
			query.select(camposPelicula)
			query.where(criteria.equal(camposPelicula.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
}
