package repos

import domain.Pelicula
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoPeliculas extends RepoAbstractMongo<Pelicula> {

	static RepoPeliculas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPeliculas()
		}
		instance
	}

	override getEntityType() {
		Pelicula
	}

	def getPeliculasRecomendadas() {
		return allInstances.take(3).toList
	}

//	def Pelicula searchByName(String nombre)
	override searchByExample(Pelicula example) {
		val query = ds.createQuery(entityType)
		if (example.titulo !== null) {
			query.field("titulo").containsIgnoreCase(example.titulo ?: "")
		}
		query.asList
	}
}
