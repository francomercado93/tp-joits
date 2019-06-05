package domain

//import org.uqbar.commons.model.exceptions.UserException

import com.eclipsesource.json.Json
import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.util.List
import org.uqbar.xtrest.json.JSONUtils
import redis.clients.jedis.Jedis
import repos.RepoPeliculas

class CarritoFactory {
	Jedis jedis
	extension JSONUtils = new JSONUtils
	// var JedisPool jedisPool //TODO: Implementar jedisPool con todas las funciones.
	static CarritoFactory instance = null
	public static val LOCALHOST = "localhost"

	private new() {
		// jedisPool = new JedisPool(new JedisPoolConfig, LOCALHOST)
		jedis = new Jedis("LOCALHOST")
	}

	static def getInstance() {
		if (instance === null) {
			instance = new CarritoFactory
		}
		instance
	}

	def Carrito usuarioEntradasRedis(Long usuarioId) {
		val List<Entrada> entradasAgregadas = jedis.lrange("usuario:" + usuarioId, 0, -1).map [ json |
			this.convertEntrada(json)
		].toList
		val carrito = new Carrito()
		carrito.entradas.addAll(entradasAgregadas)
		return carrito
	}

	def void agregarEntradaRedis(long usuarioId, Entrada entrada) {
		jedis.rpush("usuario:" + usuarioId, this.convertirToJson(entrada))
	}

	def void eliminarEntradaRedis(Long usuarioId, Entrada entrada) {
		jedis.lrem("usuario:" + usuarioId, 1, convertirToJson(entrada))
	}

	def void vaciarCarrito(Long usuarioId) {
		jedis.del("usuario:" + usuarioId)
	}

	def convertirToJson(Entrada entrada) {
		return entrada.toJson()
	}

	def convertEntrada(String json) {
		this.crearEntrada(json)
	}

	def crearEntrada(String json) {
		val entradaJson = Json.parse(json).asObject()
		return new Entrada() => [
			pelicula = RepoPeliculas.instance.searchByName(entradaJson.get("pelicula").asString())
			funcion = new Funcion() => [
				val fechaFuncion = entradaJson.get("fecha").asString()
				val DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
				fecha = LocalDate.parse(fechaFuncion, dateFormatter)
				val horaFuncion = entradaJson.get("hora").asString()
				val DateTimeFormatter timeFormatter = DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)
				hora = LocalTime.parse(horaFuncion, timeFormatter)
				nombreSala = entradaJson.get("nombreSala").asString()
			]
			precioEntrada = new BigDecimal(entradaJson.get("precioEntrada").asDouble())
		]
	}
}
