package joits

import domain.Entrada
import domain.Funcion
import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalTime
import org.junit.Assert
import org.junit.Test

class TestPeliculas extends JuegoDatosTest {

	@Test
	def void pruebaDelPrecioDeUnaPeliculaQueSeProyectaUnDiaLunesMartesJuevesViernes() {
		val entrada = new Entrada() => [
			pelicula = matrix
			funcion = lunes1
		]
		val valorEsperado = new BigDecimal("110")
		Assert.assertEquals(0, entrada.precioEntrada().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void pruebaDelPrecioDeUnaPeliculaQueSeProyectaUnDiaMiercoles() {
		val entrada = new Entrada() => [
			pelicula = matrix
			funcion = miercoles
		]
		val valorEsperado = new BigDecimal("80")
		Assert.assertEquals(0, entrada.precioEntrada().compareTo(valorEsperado)) // esta bien comparar asi(?
	}

	@Test
	def void pruebaDelPrecioDeUnaPeliculaQueSeProyectaFinDeSemana() {
		val entrada = new Entrada() => [
			pelicula = nueveReinas
			funcion = domingo1
		]
		val valorEsperado = new BigDecimal("150")
		Assert.assertEquals(0, entrada.precioEntrada().compareTo(valorEsperado))
	}

	@Test
	def void pruebaDelPrecioBaseDeUnaSaga() {
		// nivel clasico = 8(promedio puntaje) * 5(mult)
		// Precio base = 10(precio base por pelicula) * 3 (cant peliculas)  +40
		val valorEsperado = new BigDecimal("70")
		Assert.assertEquals(0, sagaBatman.precioBase.compareTo(valorEsperado))
	}

	@Test
	def void pruebaDelPrecioDeUnaSagaQueSeProyectaUnDiaLunesMartesJuevesViernes() {
		val entrada = new Entrada() => [
			pelicula = sagaBatman
			funcion = lunes4
		]
		val valorEsperado = new BigDecimal("150")
		Assert.assertEquals(0, entrada.precioEntrada().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void pruebaDelPrecioDeUnaSagaQueSeProyectaUnMiercoles() {
		val entrada = new Entrada() => [
			pelicula = sagaBatman
			funcion = miercoles4
		]
		val valorEsperado = new BigDecimal("120")
		Assert.assertEquals(0, entrada.precioEntrada().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void pruebaDelPrecioDeUnaSagaQueSeProyectaUnFinDeSemana() {
		val entrada = new Entrada() => [
			pelicula = sagaBatman
			funcion = domingo7
		]
		val valorEsperado = new BigDecimal("190")
		Assert.assertEquals(0, entrada.precioEntrada().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void usuarioAgregaPeliculasAlCarritoLaCantidadEnCarritoEsperado() {
		val entrada1 = new Entrada() => [
			pelicula = matrix
			funcion = lunes1
		]
		val entrada2 = new Entrada() => [
			pelicula = nueveReinas
			funcion = domingo1
		]
		val entrada3 = new Entrada() => [
			pelicula = matrix
			funcion = miercoles
		]

		santos.agregarItemCarrito(entrada1)
		santos.agregarItemCarrito(entrada2)
		santos.agregarItemCarrito(entrada3)
		Assert.assertEquals(3, santos.cantidadEntradasCarrito(), 0.1)
	}

	@Test
	def void usuarioAgregaPeliculasAlCarritoElValorTotalEsEsperado() {
		val entrada1 = new Entrada() => [
			pelicula = matrix
			funcion = lunes1
		]
		val entrada2 = new Entrada() => [
			pelicula = nueveReinas
			funcion = domingo1
		]
		val entrada3 = new Entrada() => [
			pelicula = matrix
			funcion = miercoles
		]
		santos.agregarItemCarrito(entrada1)
		santos.agregarItemCarrito(entrada2)
		santos.agregarItemCarrito(entrada3)
		val valorEsperado = new BigDecimal("340")
		Assert.assertEquals(0, santos.totalCarrito().compareTo(valorEsperado), 0.1) // .compareTo(valorEsperado), 0.1)
	}

	@Test
	def void testComparacionBigDecimal() {
		val bd1 = new BigDecimal("80")
		val bd2 = new BigDecimal("50")
		Assert.assertEquals(1, bd1.compareTo(bd2), 0.1)
	}

	@Test
	def void testPeliculasVistas() {
		// funciones de peliculas vistas
		val funcion1 = new Funcion() => [
			fecha = LocalDate.of(2019, 03, 22)
			hora = LocalTime.of(18, 00)
			nombreSala = "Rivadavia"
		]
		val funcion2 = new Funcion() => [
			fecha = LocalDate.of(2019, 03, 24)
			hora = LocalTime.of(18, 00)
			nombreSala = "Rivadavia"
		]
		// AGREGAR PELICULAS VISTAS A USUARIOS
		val entradaMatrix = new Entrada() => [
			pelicula = matrix
			funcion = funcion1
		]
		val entradaToyStory = new Entrada() => [
			pelicula = toyStory
			funcion = funcion2
		]
		santos.agregarItemCarrito(entradaMatrix)
		santos.agregarItemCarrito(entradaToyStory)
		santos.agregarSaldinho(new BigDecimal("600"))
		santos.comprarEntradas()
		Assert.assertEquals(2, santos.peliculasVistas.size, 0.1)
	}
}
