package repos

import domain.Usuario
import java.util.List

class RepoUsuariosGeneral {

	List<RepoUsrsInterface> repos = newArrayList

	static RepoUsuariosGeneral instance

	def static RepoUsuariosGeneral getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosGeneral
		}
		instance
	}

	def void create(Usuario usuario) {
		repos.forEach(repo|repo.create(usuario))
	}

	def agregarRepo(RepoUsrsInterface repo) {
		repos.add(repo)
	}

	def void update(Usuario usuario) {
		repos.forEach(repo|repo.update(usuario))
	}
}
