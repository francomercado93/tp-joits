
"C:\Program Files\MongoDB\Server\4.0\bin\mongos" --configdb rsConf/127.0.0.1:26050,127.0.0.1:26051 --logappend --logpath C:\data\mongodb\shardlog --port 28001 --bind_ip 127.0.0.1

17)abrir nuevo git bash o cmd(siempre como administrador) y abrir sesion cliente de mongo

"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 28001

18) Agregar los shards que creamos

sh.addShard("shard1/127.0.0.1:27000")
sh.addShard("shard2/127.0.0.1:27100")

Si todo anduvo ok, vas a ver los 2 shards y sus réplicas con este comando:

db.adminCommand( { listShards: 1 } )

**opcional
19) abrir eclipse y cambiar el puerto a 28001 para que se conecte al servicio de ruteo (mongos) en el RepoAbstractMongo y luego ejecutar la app

a partir de ahora se puede ver las colecciones

use joits
 db.Pelicula.find().pretty()
db.Pelicula.count()

las peliculas y sagas estan en el shard dos, esto se ve haciendo
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 27100

use joits
db.Pelicula.count()
****
20)volvemos a levantar el puerto 28001

"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 28001

use joits

-- creamos el índice de peliculas por hash del titulo 

db.Peliculas.ensureIndex({"titulo": "hashed"})

-- habilitamos el sharding para la database joits

sh.enableSharding("joits")

-- definimos la clave por el índice 

sh.shardCollection("joits.Peliculas", {"titulo": "hashed" }, false)

vemos los chunks que se generaron:

db.Peliculas.getShardDistribution()

otra forma

use config

db.chunks.find({},
{min:1,max:1,shard:1,_id:0,ns:1}).pretty()



 sh.startBalancer()

sh.status( { verbose : 1 } )

 sh.stopBalancer()
 sh.getBalancerState()








