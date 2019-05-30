// db.Pelicula.find(
//     { "funcionesDisponibles.nombreSala" : "Rivadavia" 
//     }
//  ).map(pelicula => pelicula.titulo)
// db.Pelicula.find(
//     { "funcionesDisponibles.nombreSala" : "Carlin Calvo" 
//     }
//  )
 db.Pelicula.find( [
    { $group: {
        _id: '$genero',
//         count: { $sum: 1}
        count: {$sum: '$puntaje'}
    }
}
])
        