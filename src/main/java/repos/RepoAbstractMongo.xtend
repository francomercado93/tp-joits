package repos

import com.mongodb.MongoClient
import domain.Pelicula
import domain.Saga
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia

abstract class RepoAbstractMongo<T> {

	static protected Datastore ds

	new() {
		if (ds === null) {
//			val mongo = new MongoClient("localhost", 27017)
			val mongo = new MongoClient("localhost", 28001)
			new Morphia => [
				map(Pelicula).map(Saga)
				ds = createDatastore(mongo, "joits")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

	def T getByExample(T example) {
		val result = searchByExample(example)
		if (result.isEmpty) {
			return null
		} else {
			return result.get(0)
		}
	}

	def List<T> searchByExample(T t)

	def T create(T t) { // createIfNotExists
		val entidadAModificar = getByExample(t)
		if (entidadAModificar !== null) {
			return entidadAModificar
		}
		doCreate(t)
	}

	def T doCreate(T t) {
		ds.save(t)
		t
	}

	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
