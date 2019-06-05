package repos

import com.mongodb.MongoClient
import domain.Pelicula
import domain.Saga
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class RepoPeliculas {

	static RepoPeliculas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoPeliculas()
		}
		instance
	}

	static protected Datastore ds

	new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 27017)
			// val mongo = new MongoClient("localhost", 28001)
			new Morphia => [
				map(Pelicula).map(Saga)
				ds = createDatastore(mongo, "joits")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	def getEntityType() {
		Pelicula
	}

	def getPeliculasRecomendadas() {
		return allInstances.take(3).toList
	}

//	def Pelicula searchByName(String nombre)
	def searchByExample(Pelicula example) {
		val query = ds.createQuery(entityType)
		if (example.titulo !== null) {
			query.field("titulo").containsIgnoreCase(example.titulo ?: "")
		}
		query.asList
	}

	def Pelicula searchByName(String nombre) {
		val query = ds.createQuery(entityType)
		if (nombre !== null) {
			query.field("titulo").containsIgnoreCase(nombre ?: "")
		}
		query.asList.head
	}

	def Pelicula getByExample(Pelicula example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.head
		}
	}

	def Pelicula create(Pelicula pelicula) { // createIfNotExists
		val entidadAModificar = getByExample(pelicula)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		doCreate(pelicula)
	}

	def Pelicula doCreate(Pelicula pelicula) {
		ds.save(pelicula)
		pelicula
	}

	def List<Pelicula> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

}
