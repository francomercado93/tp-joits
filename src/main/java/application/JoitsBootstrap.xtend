package application

import org.uqbar.arena.bootstrap.Bootstrap
import domain.Usuario
import repos.RepoUsuarios
import java.math.BigDecimal
import domain.Entrada
import domain.Pelicula
import domain.Funcion
import java.time.LocalDate
import java.time.temporal.ChronoUnit

class JoitsBootstrap implements Bootstrap {

	Usuario franco
	Usuario fabian
	Usuario test
	Usuario otto
	Usuario ruggeri
	Usuario lazy
	// Amigos de lazy
	Usuario santiago
	Usuario pedro
	Usuario riquelme
	Usuario zanetti
	// Entradas de lazy
	Entrada entrada1
	Entrada entrada2
	Entrada entrada3
	Entrada entrada4
	Pelicula pelicula1
	Pelicula pelicula2
	Pelicula pelicula3
	Pelicula pelicula4
	Funcion funcion1
	Funcion funcion2
	Funcion funcion3
	Funcion funcion4

	override isPending() {
		true
	}

	override run() {
		initUsuario()
	}

	def initUsuario() {
		// ***** CREACION USUARIOS ***** //
		franco = new Usuario => [
			username = "Franco"
			password = "123"
			nombre = "Pepe"
			apellido = "Boss"
			edad = 18
			saldo = new BigDecimal(400)
		]

		fabian = new Usuario => [
			username = "Fabian"
			password = "123"
			nombre = "Grillo"
			apellido = "Trax"
			edad = 30
			saldo = new BigDecimal(1400)
		]

		test = new Usuario => [
			username = "Test"
			password = "123"
			nombre = "Request"
			apellido = "Prix"
			edad = 25
		]

		otto = new Usuario => [
			username = "Otto"
			password = "123"
			nombre = "Await"
			apellido = "Waltz"
			edad = 28
		]

		ruggeri = new Usuario => [
			username = "Cabezon"
			password = "123"
			nombre = "Response"
			apellido = "Ruggeri"
			edad = 16
		]

		lazy = new Usuario => [
			username = "q"
			password = "q"
			nombre = "Test"
			apellido = "q"
			edad = 70
			saldo = new BigDecimal(2500.44)
		]

		// **** CREACION USUARIOS AMIGOS **** //
		santiago = new Usuario => [
			username = "Santiago"
			password = "123"
			nombre = "Santi"
			apellido = "Rugratz"
			edad = 21
		]
		pedro = new Usuario => [
			username = "Pedro"
			password = "123"
			nombre = "Pedro"
			apellido = "Sanchez"
			edad = 22
		]
		riquelme = new Usuario => [
			username = "Riquelme"
			password = "123"
			nombre = "Conejo"
			apellido = "Perez"
			edad = 23
		]
		zanetti = new Usuario => [
			username = "Zanetti"
			password = "123"
			nombre = "Pipi"
			apellido = "Vasquez"
			edad = 24
		]

		// **** CREACION FUNCION **** //
		funcion1 = new Funcion => [
			fecha = LocalDate.now().minusDays(5);
		]
		funcion2 = new Funcion => [
			fecha = LocalDate.now().minusDays(4);
		]
		funcion3 = new Funcion => [
			fecha = LocalDate.now().minusDays(3);
		]
		funcion4 = new Funcion => [
			fecha = LocalDate.now().plus(1, ChronoUnit.DAYS);
		]

		// **** CREACION ENTRADAS **** //
		pelicula1 = new Pelicula => [
			titulo = "Spiderman 3"
		]
		pelicula2 = new Pelicula => [
			titulo = "Avengers"
		]
		pelicula3 = new Pelicula => [
			titulo = "Hombres de Negro"
		]
		pelicula4 = new Pelicula => [
			titulo = "Armaggedon"
		]
		// **** CREACION ENTRADAS **** //
		entrada1 = new Entrada => [
			pelicula = pelicula1
			funcion = funcion1
		]
		entrada2 = new Entrada => [
			pelicula = pelicula2
			funcion = funcion2
		]
		entrada3 = new Entrada => [
			pelicula = pelicula3
			funcion = funcion3
		]
		entrada4 = new Entrada => [
			pelicula = pelicula4
			funcion = funcion4
		]

		crearUsuario(franco)
		crearUsuario(fabian)
		crearUsuario(test)
		crearUsuario(otto)
		crearUsuario(ruggeri)
		crearUsuario(lazy)

		crearUsuario(santiago)
		crearUsuario(pedro)
		crearUsuario(riquelme)
		crearUsuario(zanetti)

		agregarAmigo(lazy, santiago)
		agregarAmigo(lazy, pedro)
		agregarAmigo(lazy, riquelme)
		agregarAmigo(lazy, zanetti)
		comprarEntrada(lazy, entrada1)
		comprarEntrada(lazy, entrada2)
		comprarEntrada(lazy, entrada3)
		comprarEntrada(lazy, entrada4)
	}

	def void crearUsuario(Usuario usuario) {
		val repoUsuarios = RepoUsuarios.instance
		repoUsuarios.create(usuario)
	}

	def void agregarAmigo(Usuario usuario, Usuario amigo) {
		val repoUsuarios = RepoUsuarios.instance
		repoUsuarios.addAmigo(usuario, amigo)
	}

	def void comprarEntrada(Usuario usuario, Entrada entrada) {
		val repoUsuarios = RepoUsuarios.instance
		repoUsuarios.addEntrada(usuario, entrada)
	}

}
