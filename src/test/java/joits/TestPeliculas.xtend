package joits

import java.math.BigDecimal
import org.junit.Assert
import org.junit.Test

class TestPeliculas extends JuegoDatosTest {

	@Test
	def void pruebaDelPrecioDeUnaPeliculaQueSeProyectaUnDiaLunesMartesJuevesViernes() {
		matrix.elegirFuncion(lunes1)
		val valorEsperado = new BigDecimal("110")
		Assert.assertEquals(0, matrix.precioTotal().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void pruebaDelPrecioDeUnaPeliculaQueSeProyectaUnDiaMiercoles() {
		matrix.elegirFuncion(miercoles)
		val valorEsperado = new BigDecimal("80")
		Assert.assertEquals(0, matrix.precioTotal().compareTo(valorEsperado)) // esta bien comparar asi(?
	}

	@Test
	def void pruebaDelPrecioDeUnaPeliculaQueSeProyectaFinDeSemana() {
		nueveReinas.elegirFuncion(domingo1)
		val valorEsperado = new BigDecimal("150")
		Assert.assertEquals(0, nueveReinas.precioTotal().compareTo(valorEsperado))
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
		sagaBatman.elegirFuncion(lunes4)
		val valorEsperado = new BigDecimal("150")
		Assert.assertEquals(0, sagaBatman.precioTotal().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void pruebaDelPrecioDeUnaSagaQueSeProyectaUnMiercoles() {
		sagaBatman.elegirFuncion(miercoles4)
		val valorEsperado = new BigDecimal("120")
		Assert.assertEquals(0, sagaBatman.precioTotal().compareTo(valorEsperado), 0.1)
	}

	@Test
	def void pruebaDelPrecioDeUnaSagaQueSeProyectaUnFinDeSemana() {
		sagaBatman.elegirFuncion(domingo7)
		val valorEsperado = new BigDecimal("190")
		Assert.assertEquals(0, sagaBatman.precioTotal().compareTo(valorEsperado), 0.1)
	}
}
