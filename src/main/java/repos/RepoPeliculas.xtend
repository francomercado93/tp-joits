package repos

import domain.Pelicula
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

@Accessors
@Observable
class RepoPeliculas extends RepoDefault<Pelicula> {

	static final Integer PUNTAJE_RECOMENDABLE = 7
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

	def getPeliculasRecomendadas() {
		// consulta a la bd o datos cargados en memoria?
		val pelisRecomendadas = allInstances.takeWhile[pelicula|pelicula.puntaje.doubleValue() >= PUNTAJE_RECOMENDABLE]
		return pelisRecomendadas.take(3).toSet
	}

	override getEntityType() {
		Pelicula
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Pelicula> query, Root<Pelicula> camposPelicula,
		Pelicula pelicula) {
		if (pelicula.titulo !== null) {
			query.where(criteria.equal(camposPelicula.get("titulo"), pelicula.titulo))
		}
	}

	// select p.*  from pelicula p
	// where p.id = id
	// inner join pelicula_funcion pf
	// on pf.id = p.id
	// inner join funcion f
	// on f.id =pf.id
	def Pelicula searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val camposPelicula = query.from(entityType)
			camposPelicula.fetch("funcionesDisponibles")
			query.select(camposPelicula)
			query.where(criteria.equal(camposPelicula.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}
}
