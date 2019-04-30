package application

import domain.Carrito
import domain.Entrada
import domain.Funcion
import domain.Pelicula
import domain.Saga
import domain.Usuario
import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalTime
import org.uqbar.arena.bootstrap.Bootstrap
import repos.RepoPeliculas
import repos.RepoUsuarios

class JoitsBootstrap implements Bootstrap {
	Usuario santos
	Usuario lamponne
	Usuario ruggeri
	Usuario marge
	Usuario lisa
	Usuario santiago
	Usuario edna
	Usuario riquelme
	Usuario zanetti

	Funcion lunes1
	Funcion lunes2
	Funcion lunes3
	Funcion lunes4
	Funcion martes1
	Funcion martes2
	Funcion martes3
	Funcion miercoles
	Funcion miercoles2
	Funcion miercoles3
	Funcion miercoles4
	Funcion jueves1
	Funcion jueves2
	Funcion jueves3
	Funcion jueves4
	Funcion jueves5
	Funcion viernes1
	Funcion viernes2
	Funcion viernes3
	Funcion sabado1
	Funcion sabado2
	Funcion sabado3
	Funcion sabado4
	Funcion sabado5
	Funcion sabado6
	Funcion domingo1
	Funcion domingo2
	Funcion domingo3
	Funcion domingo4
	Funcion domingo5
	Funcion domingo6
	Funcion domingo7

	Pelicula matrix
	Pelicula vengadores
	Pelicula nueveReinas
	Pelicula maquinista
	Pelicula dragonBallSuper
	Pelicula batman1
	Pelicula batman2
	Pelicula batman3
	Pelicula toyStory
	Saga sagaBatman

	Entrada entradaMatrixLunes1
	Entrada entradaMatrixMartes1
	Entrada entradaMatrixMiercoles
	Entrada entradaVengadoreslunes2
	Entrada entradaVengadoresjueves1
	Entrada entradaNueveReinasDomingo1
	Entrada entradaBatman1Martes3
	Entrada entradaBatman2Sabado4
	Entrada entradaToyStoryJueves5
	Entrada entradaToyStorySabado6
	Entrada entradaSagaBatmanLunes4

	Usuario amigo1

	Usuario amigo2

	Usuario amigo3

	new() {
	}

	override isPending() {
		true
	}

	override run() {
		initUsuario()
		initFunciones()
		initPeliculas()
		initEntradas()
		initJuegoDatos()
	}

	def initJuegoDatos() {
		this.santosCompraEntradasYSeHaceAmigos()
		this.lisaCompraEntradasYHaceAmigos()
		this.ednaCompraEntradasYHaceAmigos()

	}

	def Entrada initEntradas() {
		entradaMatrixLunes1 = new Entrada() => [
			pelicula = matrix
			funcion = lunes1
		]

		entradaMatrixMartes1 = new Entrada() => [
			pelicula = matrix
			funcion = martes1
		]

		entradaMatrixMiercoles = new Entrada() => [
			pelicula = matrix
			funcion = miercoles
		]

		entradaVengadoreslunes2 = new Entrada() => [
			pelicula = vengadores
			funcion = lunes2
		]

		entradaVengadoresjueves1 = new Entrada() => [
			pelicula = vengadores
			funcion = jueves1
		]

		entradaVengadoresjueves1 = new Entrada() => [
			pelicula = vengadores
			funcion = domingo5
		]

		entradaNueveReinasDomingo1 = new Entrada() => [
			pelicula = nueveReinas
			funcion = domingo1
		]

		entradaBatman1Martes3 = new Entrada() => [
			pelicula = batman1
			funcion = martes3
		]

		entradaBatman2Sabado4 = new Entrada() => [
			pelicula = batman2
			funcion = sabado4
		]

		entradaBatman2Sabado4 = new Entrada() => [
			pelicula = batman2
			funcion = lunes3
		]
		entradaToyStoryJueves5 = new Entrada() => [
			pelicula = toyStory
			funcion = jueves5
		]

		entradaToyStorySabado6 = new Entrada() => [
			pelicula = toyStory
			funcion = sabado6
		]

		entradaSagaBatmanLunes4 = new Entrada() => [
			pelicula = sagaBatman
			funcion = lunes4
		]
	}

	def santosCompraEntradasYSeHaceAmigos() {
		val carritoTest = new Carrito
		carritoTest.agregarAlCarrito(entradaMatrixLunes1)
		carritoTest.agregarAlCarrito(entradaMatrixMiercoles)
		carritoTest.agregarAlCarrito(entradaToyStoryJueves5)
		santos.agregarSaldinho(new BigDecimal("980"))
		santos.carrito = carritoTest
		santos.comprarEntradas()
		santos.agregarAmigo(edna)
		santos.agregarAmigo(riquelme)
		santos.agregarAmigo(zanetti)
		RepoUsuarios.instance.update(santos)
	}

	def lisaCompraEntradasYHaceAmigos() {
		val carritoLisa = new Carrito
		carritoLisa.agregarAlCarrito(entradaMatrixMartes1)
		carritoLisa.agregarAlCarrito(entradaVengadoreslunes2)
		carritoLisa.agregarAlCarrito(entradaVengadoresjueves1)
		carritoLisa.agregarAlCarrito(entradaToyStorySabado6)
		carritoLisa.agregarAlCarrito(entradaSagaBatmanLunes4)
		carritoLisa.agregarAlCarrito(entradaBatman1Martes3)
		carritoLisa.agregarAlCarrito(entradaBatman2Sabado4)
		lisa.agregarSaldinho(new BigDecimal("5450"))
		lisa.carrito = carritoLisa
		lisa.comprarEntradas()
		lisa.agregarAmigo(marge)
		RepoUsuarios.instance.update(lisa)
	}

	def ednaCompraEntradasYHaceAmigos() {
		val carritoEdna = new Carrito
		carritoEdna.agregarAlCarrito(entradaBatman1Martes3)
		carritoEdna.agregarAlCarrito(entradaBatman2Sabado4)
		carritoEdna.agregarAlCarrito(entradaSagaBatmanLunes4)
		carritoEdna.agregarAlCarrito(entradaMatrixLunes1)
		carritoEdna.agregarAlCarrito(entradaNueveReinasDomingo1)
		edna.carrito = carritoEdna
		edna.agregarSaldinho(new BigDecimal("1200"))
		edna.comprarEntradas()
		edna.agregarAmigo(santos)
		edna.agregarAmigo(riquelme)
		RepoUsuarios.instance.update(edna)
	}

	def void initFunciones() {

		// funciones
		lunes1 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 01)
			hora = LocalTime.of(15, 30)
			nombreSala = "Rivadavia"
		]
		lunes2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 01)
			hora = LocalTime.of(17, 30)
			nombreSala = "Rivadavia"
		]

		lunes3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 01)
			hora = LocalTime.of(15, 30)
			nombreSala = "Multicenter"
		]

		lunes4 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 01)
			hora = LocalTime.of(17, 30)
			nombreSala = "Multicenter"
		]

		martes1 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 02)
			hora = LocalTime.of(17, 30)
			nombreSala = "Multicenter"
		]

		martes2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 02)
			hora = LocalTime.of(20, 30)
			nombreSala = "Multicenter"
		]

		martes3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 02)
			hora = LocalTime.of(21, 30)
			nombreSala = "Rivadavia"
		]

		miercoles = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 03)
			hora = LocalTime.of(19, 10)
			nombreSala = "Multicenter"
		]

		miercoles2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 03)
			hora = LocalTime.of(21, 10)
			nombreSala = "Multicenter"
		]

		miercoles3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 03)
			hora = LocalTime.of(17, 30)
			nombreSala = "Rivadavia"
		]
		miercoles4 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 03)
			hora = LocalTime.of(22, 00)
			nombreSala = "Rivadavia"
		]
		jueves1 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 04)
			hora = LocalTime.of(16, 50)
			nombreSala = "Rivadavia"
		]

		jueves2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 04)
			hora = LocalTime.of(16, 50)
			nombreSala = "Multicenter"
		]
		jueves3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 04)
			hora = LocalTime.of(18, 45)
			nombreSala = "Rivadavia"
		]

		jueves4 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 04)
			hora = LocalTime.of(18, 45)
			nombreSala = "Multicenter"
		]

		jueves5 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 04)
			hora = LocalTime.of(21, 10)
			nombreSala = "Rivadavia"
		]

		viernes1 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 05)
			hora = LocalTime.of(16, 20)
			nombreSala = "Rivadavia"
		]
		viernes2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 05)
			hora = LocalTime.of(18, 20)
			nombreSala = "Rivadavia"
		]

		viernes3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 05)
			hora = LocalTime.of(19, 40)
			nombreSala = "Multicenter"
		]

		sabado1 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 06)
			hora = LocalTime.of(15, 40)
			nombreSala = "Multicenter"
		]

		sabado2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 06)
			hora = LocalTime.of(19, 40)
			nombreSala = "Multicenter"
		]

		sabado3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 06)
			hora = LocalTime.of(22, 10)
			nombreSala = "Multicenter"
		]

		sabado4 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 06)
			hora = LocalTime.of(15, 40)
			nombreSala = "Rivadavia"
		]
		sabado5 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 06)
			hora = LocalTime.of(19, 40)
			nombreSala = "Rivadavia"
		]

		sabado6 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 06)
			hora = LocalTime.of(23, 00)
			nombreSala = "Rivadavia"
		]

		domingo1 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(17, 35)
			nombreSala = "Rivadavia"
		]

		domingo2 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(19, 35)
			nombreSala = "Rivadavia"
		]

		domingo3 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(21, 35)
			nombreSala = "Rivadavia"
		]

		domingo4 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(17, 35)
			nombreSala = "Multicenter"
		]

		domingo5 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(19, 35)
			nombreSala = "Multicenter"
		]

		domingo6 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(21, 35)
			nombreSala = "Multicenter"
		]

		domingo7 = new Funcion() => [
			fecha = LocalDate.of(2019, 04, 07)
			hora = LocalTime.of(23, 35)
			nombreSala = "Rivadavia"
		]
	}

	def void initPeliculas() {
		matrix = new Pelicula() => [
			titulo = "Matrix"
			anio = 1999
			puntaje = new BigDecimal("8.7")
			genero = "Ciencia ficcion"
			agregarFuncion(lunes1)
			agregarFuncion(martes1)
			agregarFuncion(miercoles)
		]

		vengadores = new Pelicula() => [
			titulo = "Los vengadores"
			anio = 2012
			puntaje = new BigDecimal("8.1")
			genero = "Ciencia ficcion"
			agregarFuncion(lunes2)
			agregarFuncion(jueves1)
			agregarFuncion(viernes1)
			agregarFuncion(viernes3)
			agregarFuncion(domingo5)
		]

		nueveReinas = new Pelicula() => [
			titulo = "Nueve reinas"
			anio = 2000
			puntaje = new BigDecimal("7.7")
			genero = "Drama"
			agregarFuncion(martes2)
			agregarFuncion(viernes2)
			agregarFuncion(domingo1)
		]

		maquinista = new Pelicula() => [
			titulo = "El maquinista"
			anio = 2004
			puntaje = new BigDecimal("7.1")
			genero = "Drama"
			agregarFuncion(jueves3)
			agregarFuncion(jueves4)
			agregarFuncion(sabado1)
		]

		dragonBallSuper = new Pelicula() => [
			titulo = "La resurrecion de Freezer"
			anio = 2015
			puntaje = new BigDecimal("7.4")
			genero = "Animacion"
			agregarFuncion(sabado2)
			agregarFuncion(domingo2)
			agregarFuncion(domingo3)
		]

		batman1 = new Pelicula() => [
			titulo = "Batman inicia"
			anio = 2005
			puntaje = new BigDecimal("7.4")
			genero = "Accion"
			agregarFuncion(sabado3)
			agregarFuncion(martes3)
			agregarFuncion(domingo4)
		]

		batman2 = new Pelicula() => [
			titulo = "Batman: El caballero de la noche"
			anio = 2008
			puntaje = new BigDecimal("9")
			genero = "Accion"
			agregarFuncion(lunes3)
			agregarFuncion(miercoles2)
			agregarFuncion(sabado4)
		]

		batman3 = new Pelicula() => [
			titulo = "Batman: el caballero de la noche asciende"
			anio = 2012
			puntaje = new BigDecimal("8.4")
			genero = "Accion"
			agregarFuncion(miercoles3)
			agregarFuncion(jueves2)
			agregarFuncion(sabado5)
		]

		toyStory = new Pelicula() => [
			titulo = "Toy story"
			anio = 1995
			puntaje = new BigDecimal("8.3")
			genero = "Animacion	"
			agregarFuncion(jueves5)
			agregarFuncion(sabado6)
			agregarFuncion(domingo6)
		]

		sagaBatman = new Saga() => [
			titulo = "Trilogia batman"
			anio = 2019
			puntaje = new BigDecimal("8")
			genero = "Accion"
			agregarPeliculaSaga(batman1)
			agregarPeliculaSaga(batman2)
			agregarPeliculaSaga(batman3)
			agregarFuncion(lunes4)
			agregarFuncion(miercoles4)
			agregarFuncion(domingo7)
		]

		this.crearPelicula(matrix)
		this.crearPelicula(vengadores)
		this.crearPelicula(nueveReinas)
		this.crearPelicula(maquinista)
		this.crearPelicula(dragonBallSuper)
		this.crearPelicula(batman1)
		this.crearPelicula(batman2)
		this.crearPelicula(batman3)
		this.crearPelicula(toyStory)
		this.crearPelicula(sagaBatman)
	}

	def void initUsuario() {
		santos = new Usuario() => [
			username = "MarioSantos"
			password = "milazzo"
			nombre = "Mario"
			apellido = "Santos"
			edad = 38
		]
		lamponne = new Usuario() => [
			username = "Pabluchis"
			password = "betun"
			nombre = "Pablo"
			apellido = "Lamponne"
			edad = 42
		]
		ruggeri = new Usuario() => [
			username = "CabezonRuggeri"
			password = "alfredo"
			nombre = "Oscar"
			apellido = "Ruggeri"
			edad = 57
		]

		marge = new Usuario() => [
			username = "Marge"
			password = "mmmm"
			nombre = "Marge"
			apellido = "Simpson"
			edad = 38
		]
		lisa = new Usuario() => [
			username = "LisaSimpson"
			password = "54547575"
			nombre = "Lisa"
			apellido = "Simpson"
			edad = 8
		]
		// Amigos de usuarios
		santiago = new Usuario => [
			username = "Santiago"
			password = "123"
			nombre = "Santi"
			apellido = "Rugratz"
			edad = 21
		]
		edna = new Usuario => [
			username = "EdnaK"
			password = "123"
			nombre = "Edna"
			apellido = "Klavados"
			edad = 22
		]
		riquelme = new Usuario => [
			username = "JR10"
			password = "123"
			nombre = "Juan Roman"
			apellido = "Riquelme"
			edad = 23
		]
		zanetti = new Usuario => [
			username = "PupiZanetti"
			password = "123"
			nombre = "Javier"
			apellido = "Zanetti"
			edad = 24
		]

		amigo1 = new Usuario() => [
			username = "MoeSzyslak"
			password = "nofuneral"
			nombre = "MoeAmigo"
			apellido = "Szyslak"
			edad = 37
		]
		amigo2 = new Usuario() => [
			username = "CerseiLannister"
			password = "jaime"
			nombre = "CerseiAmigo"
			apellido = "Lannister"
			edad = 45
		]
		amigo3 = new Usuario() => [
			username = "TucoSalamanca"
			password = "tuco"
			nombre = "TucoAmigo"
			apellido = "Salamanca"
			edad = 41
		]
		this.crearUsuario(santos)
		this.crearUsuario(lamponne)
		this.crearUsuario(ruggeri)
		this.crearUsuario(marge)
		this.crearUsuario(lisa)
		this.crearUsuario(santiago)
		this.crearUsuario(edna)
		this.crearUsuario(riquelme)
		this.crearUsuario(zanetti)
		this.crearUsuario(amigo1)
		this.crearUsuario(amigo2)
		this.crearUsuario(amigo3)
	}

	def void crearUsuario(Usuario usuario) {
		val repoUsuarios = RepoUsuarios.instance
		repoUsuarios.create(usuario)
	}

	def crearPelicula(Pelicula pelicula) {
		val repoPeliculas = RepoPeliculas.instance
		repoPeliculas.create(pelicula)
	}
}
