package repos

import domain.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.config.Configuration
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.session.SessionFactory

@Accessors
abstract class RepoAbstractNeo4j<T> {

	static Configuration configuration = new Configuration.Builder().uri("bolt://localhost").credentials("neo4j",
		"123456").build()

	public static SessionFactory sessionFactory = new SessionFactory(configuration, "domain")

	protected def getSession() {
		sessionFactory.openSession
	}

	def Filter filtroNombre(String titulo)

	def void create(T t)

	def Set<T> getRecomendadas(Usuario usuario)

}
