package repos

import java.util.List

class RepoUsuariosGeneral {

	List<RepoUsuariosGeneral> repos

	static RepoUsuariosGeneral instance

	def static RepoUsuariosGeneral getInstance() {
		if (instance === null) {
			instance = new RepoUsuariosGeneral
		}
		instance
	}

//	def void create(Usuario usuario) {
//		repos.forEach(repo|repo.create(usuario))
//	}
//
	def agregarRepo(RepoUsuariosGeneral repo) {
		repos.add(repo)
	}
}
