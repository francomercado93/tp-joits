package repos

import domain.Usuario

interface RepoUsrsInterface {

	def void create(Usuario usuario)

	def void update(Usuario usuario)

	def Usuario searchByUsername(String username)

}
