package repos

import domain.Funcion
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepoFunciones extends RepoDefault<Funcion> {

	static RepoFunciones instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoFunciones()
		}
		instance
	}

	override getEntityType() {
		Funcion
	}

	// No se usa??
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Funcion> query, Root<Funcion> camposFuncion,
		Funcion funcion) {
	}

	override busquedaPorNombre(Funcion t, String nombre) {
	}

}
