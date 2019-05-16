package repos

import com.mongodb.MongoClient
import domain.Pelicula
import java.util.List
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia

abstract class RepoAbstractMongo<T> {

	static protected Datastore ds

	new() {
		if (ds === null) {
			// Conexión al puerto default de mongo
			val mongo = new MongoClient("localhost", 27017)
			// Conexión a un ReplicaSet con 1 master y 2 slave
//			val mongo = new MongoClient(#[new ServerAddress("localhost", 27058),
//					new ServerAddress("localhost", 27059),
//					new ServerAddress("localhost", 27060)])
			new Morphia => [
				map(Pelicula)
				ds = createDatastore(mongo, "joits")
				ds.ensureIndexes
			]
			println("Conectado a MongoDB. Bases: " + ds.getDB.collectionNames)
		}
	}

//	def T getByExample(T example) {
//		val result = searchByExample(example)
//		if (result.isEmpty) {
//			return null
//		} else {
//			return result.get(0)
//		}
//	}

	def List<T> searchByExample(T t)

//	def T createIfNotExists(T t) {
//		val entidadAModificar = getByExample(t)
//		if (entidadAModificar !== null) {
//			return entidadAModificar
//		}
//		create(t)
//	}

	def T create(T t) {
		ds.save(t)
		t
	}


	def List<T> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	abstract def Class<T> getEntityType()

}
