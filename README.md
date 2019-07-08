# Tp-joits
Aplicacion realizada con el framework Arena, que permite a un usuario loguearse, sacar entradas para el cine, obtener una lista de peliculas recomendadas, editar sus datos personales como cambiar su edad, cargar saldo, agregar amigos y obtener recomendaciones de amigos.
Es una aplicacion con persistencia poliglota:
* los usuarios, los amigos de los usuarios y sus entradas se guardan en una base relacional(MySQL).
* las peliculas y sus funciones disponibles se guardan en una base documental(MongoDB).
* las entradas agregadas al carrito se guardan en una base orientado a clave-valor(Redis).
* y las recomendaciones de peliculas y amigos se obtienen al guardar estos en una base orientado a grafos(Neo4j).
* tambien tenemos la opcion de conectarnos a un cluster donde podemos escalar horizontalmente mediante sharding.

# Pasos para crear shards en mongodb!
* Crear carpeta data, mongodb y sharding.
```
mkdir "C:\data\mongodb\sharding
```
* Crear carpetas de config, shards y replicas.
```
cd "C:\data\mongodb\sharding"
mkdir cfg1 cfg2 shard1 shard2 repl1 repl2
 ```
 * Levantamos los servers de configuracion
 ```
mongod --replSet rsConf --configsvr --port 26050 --logpath C:\data\mongodb\sharding\log.cfg1 --logappend --dbpath C:\data\mongodb\sharding\cfg1
```
//Abrir nueva terminal
 ```
mongod --replSet rsConf --configsvr --port 26051 --logpath C:\data\mongodb\sharding\log.cfg2 --logappend --dbpath C:\data\mongodb\sharding\cfg2
```
* Levantamos los shards
```
mongod --shardsvr --replSet shard1 --dbpath C:\data\mongodb\sharding\shard1 --logpath C:\data\mongodb\sharding\log.shard1 --port 27000 --logappend --smallfiles --oplogSize 50

mongod --shardsvr --replSet shard1 --dbpath C:\data\mongodb\sharding\repl1 --logpath C:\data\mongodb\sharding\log.repl1 --port 27001 --logappend --smallfiles --oplogSize 50

mongod --shardsvr --replSet shard2 --dbpath C:\data\mongodb\sharding\shard2 --logpath C:\data\mongodb\sharding\log.shard2 --port 27100 --logappend --smallfiles --oplogSize 50

mongod --shardsvr --replSet shard2 --dbpath C:\data\mongodb\sharding\repl2 --logpath C:\data\mongodb\sharding\log.repl2 --port 27101 --logappend --smallfiles --oplogSize 50
```
* Levantar cliente mongo en puerto 26050 y correr config:
```
mongo --port 26050

cfg={_id:"rsConf",members:[{_id:0 ,host: "127.0.0.1:26050"}, {_id: 1, host: "127.0.0.1:26051" }]}

rs.initiate(cfg) 
//deberia tirar un ok: 1
exit
```
* Levantar cliente mongo en puerto 27000 y configurar master/slave
```
mongo --port 27000

cfg={_id:"shard1", members:[{_id:0 ,host: "127.0.0.1:27000"}, {_id:1 ,host: "127.0.0.1:27001" }]}

rs.initiate(cfg)
rs.status()
exit
```
* Lo mismo para el otro shard
```
mongo --port 27100

cfg={_id:"shard2", members:[{_id:0 ,host: "127.0.0.1:27100"}, {_id:1 ,host: "127.0.0.1:27101" }]}

rs.initiate(cfg)

rs.status()

exit
```
* Iniciar servicios de ruteo
```
mongos --configdb rsConf/127.0.0.1:26050,127.0.0.1:26051 --logappend --logpath C:\data\mongodb\shardlog --port 28001 --bind_ip 127.0.0.1
```
* Abrir cliente mongo en puerto 28001
```
mongo --port 28001
```
* Agregar los shards que creamos
```
sh.addShard("shard1/127.0.0.1:27000")
sh.addShard("shard2/127.0.0.1:27100")
```
* Si todo anduvo ok, vas a ver los 2 shards y sus réplicas con este comando:
```
db.adminCommand( { listShards: 1 } )
```
## Creamos las shardkeys con indices hash.

* Abrir cliente mongo en puerto 28001:
```
mongo --port 28001

use joits 
```
No hay que cargar los datos a la bd todavia, si cargamos la bd y creamos la shard key nos sale este mensaje, debido a que la collection
no es vacia:
```
sh.shardCollection("joits.Peliculas", {"_id" :"hashed"}, false, opciones)
{
        "ok" : 0,
        "errmsg" : "numInitialChunks is not supported when the collection is not empty",
        "code" : 72,
        "codeName" : "InvalidOptions",
        "operationTime" : Timestamp(1559841831, 4),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1559841831, 4),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
```
-- creamos el índice de peliculas por hash del titulo 
```
db.Peliculas.ensureIndex({"_id": "hashed"})

-- habilitamos el sharding para la database joits

sh.enableSharding("joits")
```
*Definimos la clave por el índice 

Hay dos formas de crear la shard key:
1)Indicando la cantidad inicial de chunks para eso primero creamos el documento opciones indicando la cantidad inicial de chunks.
```
opciones = { numInitialChunks: 4}

sh.shardCollection("joits.Peliculas", {"_id" :"hashed"}, false, opciones)
```
2) Sin indicar la cantidad inicial y dejar al balancer que distribuya:
```
sh.shardCollection("joits.Peliculas", {"_id" :"hashed"}, false)
```
Vemos los chunks que se generaron:
```
db.Peliculas.getShardDistribution()

//otra forma

use config

db.chunks.find({},
{min:1,max:1,shard:1,_id:0,ns:1}).pretty()

```
## Algunas cosas que nos pueden servir
```
sh.startBalancer()

sh.status( { verbose : 1 } )

sh.stopBalancer()

sh.getBalancerState()
```

Usar db.collection.createIndex() en vez de db.collection.ensureIndex()

Creates an index on the specified field if the index does not already exist.
por id
 ```
db.Peliculas.createIndex( { _id : "hashed" } )

sh.enableSharding("joits")
 ```
Enables sharding on the specified database. This does not automatically shard any collections but makes it possible to begin sharding collections using sh.shardCollection().
 ```
sh.shardCollection(namespace, key, unique, options)¶
 ```
Shards a collection using the key as a the shard key. sh.shardCollection() takes the following arguments:
 ```
sh.shardCollection("joits.Peliculas", {"_id" :"hashed"}, false)
 ```
 
 * Levantar mongod en "C:\data\mongodb"
```
mongod --dbpath "C:\data\mongodb"
```
## Opcional
Abrir eclipse y cambiar el puerto a 28001 para que se conecte al servicio de ruteo (mongos) en el RepoAbstractMongo y luego ejecutar la app.

A partir de ahora se puede ver las colecciones
```
use joits
db.Peliculas.find().pretty()
db.Peliculas.count()
```

* Las peliculas y sagas estan en algun shard, esto se ve haciendo:
```
mongo --port 27100

use joits
db.Peliculas.count()
```








