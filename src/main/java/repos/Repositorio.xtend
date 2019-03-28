package repos

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
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

	def search(String value) {
		lista.filter(elemento|this.busquedaPorNombre(elemento, value)).toList
	}

	def boolean busquedaPorNombre(T elemento, String value)

	def void asignarId(T elemento)

	def T searchById(int id)
}
