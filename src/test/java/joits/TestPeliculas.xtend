package joits

import domain.Entrada
import java.math.BigDecimal
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
		Assert.assertEquals(340, santos.carrito.total(), 0.1) // .compareTo(valorEsperado), 0.1)
	}
}
