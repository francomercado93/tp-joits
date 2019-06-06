package domain

//import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule
import java.util.List
import redis.clients.jedis.Jedis
import repos.RepoPeliculas

class CarritoFactory {
	Jedis jedis
	// var JedisPool jedisPool //TODO: Implementar jedisPool con todas las funciones.
	static CarritoFactory instance = null
	public static val LOCALHOST = "localhost"
	val mapper = new ObjectMapper()

	private new() {
		// jedisPool = new JedisPool(new JedisPoolConfig, LOCALHOST)
		jedis = new Jedis("LOCALHOST")
		mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false)
		mapper.registerModule(new JavaTimeModule())
		mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
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
		var carrito = new Carrito()
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
		mapper.writeValueAsString(entrada)
	}

	def convertEntrada(String json) {
		val Entrada entrada = mapper.readValue(json, typeof(Entrada))
		entrada.pelicula = RepoPeliculas.instance.searchByName(entrada.pelicula.toString)
		return entrada
	}
}
