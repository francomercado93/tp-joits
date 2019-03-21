package repos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import java.util.List

@Accessors
abstract class Repositorio<T> {

	int id = 0
	List<T> lista = new ArrayList<T>()

	def void create(T elemento) {
		lista.add(elemento)
	}

	def void update(T elemento)

	def void delete(T elemento) {
		lista.remove(elemento)
	}

	def void asignarId(T elemento)

	def T searchById(int id)
}
