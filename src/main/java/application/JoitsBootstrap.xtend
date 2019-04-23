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
import repos.RepoFunciones
import repos.RepoPeliculas
import repos.RepoUsuarios

class JoitsBootstrap implements Bootstrap {
	Usuario santos
	Usuario lamponne
	Usuario ruggeri
	Usuario marge
	Usuario lisa
	Usuario santiago
	Usuario pedro
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

	Funcion funcion1
	Funcion funcion2
	Entrada entradaMatrix
	Entrada entradaToyStory

	new() {
	}

	override isPending() {
		true
	}

	override run() {
		initUsuario()
		initFunciones()
		initPeliculas()
//		initJuegoDatos()
	}

	def initJuegoDatos() {

		// AGREGAR PELICULAS VISTAS A USUARIOS
		entradaMatrix = new Entrada() => [
			pelicula = matrix
			funcion = funcion1
		]
		entradaToyStory = new Entrada() => [
			pelicula = toyStory
			funcion = funcion2
		]
		val carritoTest = new Carrito

		carritoTest.agregarAlCarrito(entradaMatrix)
		carritoTest.agregarAlCarrito(entradaToyStory)
		santos.agregarSaldinho(new BigDecimal("600"))
		santos.carrito = carritoTest
		santos.comprarEntradas()
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
			hora = LocalTime.of(20, 30)
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

		// Peliculas vistas para mario santos
		funcion1 = new Funcion() => [
			fecha = LocalDate.of(2019, 03, 22)
			hora = LocalTime.of(18, 00)
			nombreSala = "Rivadavia"
		]
		funcion2 = new Funcion() => [
			fecha = LocalDate.of(2019, 03, 24)
			hora = LocalTime.of(18, 00)
			nombreSala = "Rivadavia"
		]

		this.crearFuncion(lunes1)
		this.crearFuncion(lunes2)
		this.crearFuncion(lunes3)
		this.crearFuncion(lunes4)
		this.crearFuncion(martes1)
		this.crearFuncion(martes2)
		this.crearFuncion(martes3)
		this.crearFuncion(miercoles)
		this.crearFuncion(miercoles2)
		this.crearFuncion(miercoles3)
		this.crearFuncion(miercoles4)
		this.crearFuncion(jueves1)
		this.crearFuncion(jueves2)
		this.crearFuncion(jueves3)
		this.crearFuncion(jueves4)
		this.crearFuncion(jueves5)
		this.crearFuncion(viernes1)
		this.crearFuncion(viernes2)
		this.crearFuncion(viernes3)
		this.crearFuncion(sabado1)
		this.crearFuncion(sabado2)
		this.crearFuncion(sabado3)
		this.crearFuncion(sabado4)
		this.crearFuncion(sabado5)
		this.crearFuncion(sabado6)
		this.crearFuncion(domingo1)
		this.crearFuncion(domingo2)
		this.crearFuncion(domingo3)
		this.crearFuncion(domingo4)
		this.crearFuncion(domingo5)
		this.crearFuncion(domingo6)
		this.crearFuncion(domingo7)
		this.crearFuncion(funcion1)
		this.crearFuncion(funcion2)
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
			// batman y el maquinista tienen las misma funcion
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
//			agregarFuncion(jueves4)
//			agregarFuncion(sabado1) 
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
		// se agregan dos veces las peliculas de la saga?
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

		santos.agregarAmigo(pedro)
		santos.agregarAmigo(riquelme)
		santos.agregarAmigo(zanetti)
// Esta pinchando, hay que revisar por qué.
//		this.crearUsuario(santos)
//		this.crearUsuario(lamponne)
//		this.crearUsuario(ruggeri)
//		this.crearUsuario(marge)
//		this.crearUsuario(lisa)
//		this.crearUsuario(santiago)
//		this.crearUsuario(pedro)
//		this.crearUsuario(riquelme)
//		this.crearUsuario(zanetti)
	// AGREGAR MAS AMIGOS
	}

	def void crearUsuario(Usuario usuario) {
		val repoUsuarios = RepoUsuarios.instance
		repoUsuarios.create(usuario)
	}

	def crearPelicula(Pelicula pelicula) {
		val repoPeliculas = RepoPeliculas.instance
//		val listaPeliculas = repoPeliculas.searchByExample(pelicula)
//		if (listaPeliculas.isEmpty) {
		repoPeliculas.create(pelicula)
//			println("Pelicula " + pelicula.titulo + " creado")
//		} else {
//			val peliculaBD = listaPeliculas.head
//			pelicula.id = peliculaBD.id
//			repoPeliculas.update(pelicula)
//	}
	}

	def crearFuncion(Funcion funcion) {
		val repoFunciones = RepoFunciones.instance
//		val listaFunciones = REPOFUNCIONES.SEARCHBYEXAMPLE(FUNCION)
//		IF (LISTAFUNCIONES.ISEMPTY) {
		repoFunciones.create(funcion)
//		println("Funcion " + funcion.fecha + " " + funcion.hora + " creada")
//		} else {
//			val funcionBD = listaFunciones.head
//			funcion.id = funcionBD.id
//			repoFunciones.update(funcion)
//		}
	}

}
