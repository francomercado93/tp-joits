package domain

//import org.uqbar.commons.model.exceptions.UserException
import redis.clients.jedis.Jedis
//import redis.clients.jedis.JedisPool
//import redis.clients.jedis.JedisPoolConfig
//import redis.clients.jedis.exceptions.JedisConnectionException
import java.util.List
import com.google.gson.Gson
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalDate
import java.time.LocalTime
import repos.RepoPeliculas
import java.util.ArrayList
import java.math.BigDecimal

class CarritoFactory {
	Jedis jedis
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
		val List<EntradaRedis> entradas = jedis.lrange("usuario:" + usuarioId, 0, -1).map [ json |
			convertirToEntradaRedis(json)
		].toList
		val List<Entrada> entradasGuardadas = new ArrayList<Entrada>
		for (EntradaRedis entrada : entradas) {
			entradasGuardadas.add(crearEntrada(entrada))
		}
		return new Carrito() => [entradas = entradasGuardadas]
	}

	// Soy un boludo, cuando compra tendría que eliminar todo, está al revés.
//	def void agregarEntradaRedis(long usuarioId, List<Entrada> entradas) {
//		val List<EntradaRedis> redisEntradas = entradas.map[entrada|carritoToEntradaRedis(entrada)].toList
//		for (EntradaRedis entrada : redisEntradas) {
//  			jedis.rpush("usuario:" + usuarioId, convertirToJson(entrada))
//		}
//	}
//	
	def void agregarEntradaRedis(long usuarioId, Entrada entrada) {
		val EntradaRedis redis = crearEntradaRedis(entrada)
		jedis.rpush("usuario:" + usuarioId, convertirToJson(redis))
	}

	def void eliminarEntradaRedis(Long usuarioId, Entrada entrada) {
		val EntradaRedis redis = crearEntradaRedis(entrada)
		jedis.lrem("usuario:" + usuarioId, 1, convertirToJson(redis))
	}

	def void vaciarCarrito(Long usuarioId) {
		jedis.del("usuario:" + usuarioId)
	}

	def convertirToJson(EntradaRedis entrada) {
		val Gson gson = new Gson()
		return gson.toJson(entrada)
	}

	def convertirToEntradaRedis(String json) {
		var gson = new Gson()
		return gson.fromJson(json, EntradaRedis)
	}

	def crearEntradaRedis(Entrada entrada) {
		return new EntradaRedis() => [
			titulo = entrada.pelicula.titulo
			sala = entrada.funcion.nombreSala
			fecha = entrada.fechaFuncion()
			hora = entrada.horaFuncion()
			precioEntrada = entrada.precioEntrada
		]
	}

	def crearEntrada(EntradaRedis entrada) {
		return new Entrada() => [
			pelicula = RepoPeliculas.instance.searchByName(entrada.titulo)
			funcion = new Funcion() => [
				fecha = entrada.fecha
				hora = entrada.hora
				nombreSala = entrada.sala
			]
			precioEntrada = entrada.precioEntrada
		]
	}
}

@Accessors
@Observable
class EntradaRedis {
	String titulo
	String sala
	LocalDate fecha
	LocalTime hora
	BigDecimal precioEntrada

	new(String _titulo, String _sala, LocalDate _fecha, LocalTime _hora, BigDecimal _precioEntrada) {
		this.titulo = _titulo
		this.sala = _sala
		this.fecha = _fecha
		this.hora = _hora
		this.precioEntrada = _precioEntrada
	}

	new() {
	}
}
