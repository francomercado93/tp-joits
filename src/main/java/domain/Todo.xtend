package domain

import java.util.List

class Todo {
	List <Pelicula> pepe
	def convertir (){
		pepe.map(pelicula | pelicula.titulo)
	}
}

// 1)Persistir en mongo peliculas con sus funciones embebidaas y
//entradas compradas con su pelicula y funcion(y saga con su lista de peliculas y funcion) <= repoEntradasCompradas?
// problema de persistir entradas compradas en mongo: como relacionar con usuario?
//posible solucion: guardar en mysql solo el id de la entrada guardada en mongo 
//RepoUsuarios:
//searchById()...
//camposUsuario.fetch("entradasCompradas", JoinType.LEFT) //en la base relacional solo se guarda el id 
//RepoEntradasCompradas.getEntradasUsuario(Usuario usuario)
//=> getEntradasUsuario(Usuario usuario){
//		usuario.entradasCompradas.map(entrada | getEntrada(entrada.id) //en la base mongo se recupera toda la info

// getEntrada(Long id)
// val query = ds.createQuery(entityType)
//			query.field("id").equal(id)
//		query.asList.head

//O persistir tambien los usuarios en relacional y mongo?
//----------------------------------------------------------------------------------------
//2)persistir en mysql entradas y hacer un converter de pelicula y funcion. guardando titulo de pelicula
// id de funcion, para esto es necesario hacer un repo de funciones para guardar en mongo, o embeber en la entrada
// todos los datos de la funcion y luego recontruir el objeto funcion con los datos de la tabla
//problema: no funciona con las sagas(NullPointerException en el metodo convertToDatabaseColumn(Pelicula pelicula)
//porque recibe un objeto Saga en vez de Pelicula     