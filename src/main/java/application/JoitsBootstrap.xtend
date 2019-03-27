package application

import org.uqbar.arena.bootstrap.Bootstrap
import domain.Usuario
import repos.RepoUsuarios

class JoitsBootstrap implements Bootstrap {

	Usuario franco
	Usuario fabian
	Usuario test
	Usuario otto
	Usuario ruggeri
	Usuario lazy

	override isPending() {
		true
	}

	override run() {
		initUsuario()
	}

	def initUsuario() {
		franco = new Usuario => [
			username = "Franco"
			password = "123"
		]

		fabian = new Usuario => [
			username = "Fabian"
			password = "123"
		]

		test = new Usuario => [
			username = "Test"
			password = "123"
		]

		otto = new Usuario => [
			username = "Otto"
			password = "123"
		]

		ruggeri = new Usuario => [
			username = "Cabezon"
			password = "123"
		]

		lazy = new Usuario => [
			username = "q"
			password = "q"
		]

		crearUsuario(franco)
		crearUsuario(fabian)
		crearUsuario(test)
		crearUsuario(otto)
		crearUsuario(ruggeri)
		crearUsuario(lazy)
	}

	def void crearUsuario(Usuario usuario) {
		val repoUsuarios = RepoUsuarios.instance
		repoUsuarios.create(usuario)
	}

}
