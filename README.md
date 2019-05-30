# Pasos para crear shards
* Crear carpeta data y mongodb.
* Ejecutar como administrador cmd o git bash
* Levantar
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongod.exe" --dbpath C:\data\mongodb
```

* Crear carpeta sharding en mongodb

* Pararse en el directorio sharding y crear las carpetas
```
mkdir cfg1 cfg2 shard1 shard2 repl1 repl2

"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --replSet rsConf --configsvr --port 26050 --logpath C:\data\mongodb\sharding\log.cfg1 --logappend --dbpath C:\data\mongodb\sharding\cfg1
```

* Abrir nueva terminal
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --replSet rsConf --configsvr --port 26051 --logpath C:\data\mongodb\sharding\log.cfg2 --logappend --dbpath C:\data\mongodb\sharding\cfg2
```
*Para cambiar a carpeta sharding*
```
cd C:\data\mongodb\sharding
```
* Se deberian creardos archivos log en la carpeta sharding y otro archivos en la carpeta cfg1 y cfg2
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard1 --dbpath C:\data\mongodb\sharding\shard1 --logpath C:\data\mongodb\sharding\log.shard1 --port 27000 --logappend --smallfiles --oplogSize 50


"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard1 --dbpath C:\data\mongodb\sharding\repl1 --logpath C:\data\mongodb\sharding\log.repl1 --port 27001 --logappend --smallfiles --oplogSize 50


"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard2 --dbpath C:\data\mongodb\sharding\shard2 --logpath C:\data\mongodb\sharding\log.shard2 --port 27100 --logappend --smallfiles --oplogSize 50


"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard2 --dbpath C:\data\mongodb\sharding\repl2 --logpath C:\data\mongodb\sharding\log.repl2 --port 27101 --logappend --smallfiles --oplogSize 50
```
* Levantar instancia de mongo en puerto 26050:
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 26050


cfg={_id:"rsConf",members:[{_id:0 ,host: "127.0.0.1:26050"}, {_id: 1, host: "127.0.0.1:26051" }]}

rs.initiate(cfg) 
//deberia tirar un ok: 1
exit
```
* Levantar una instancia de mongo en el puerto 27000 y configurar master y slave
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 27000

cfg={_id:"shard1", members:[{_id:0 ,host: "127.0.0.1:27000"}, {_id:1 ,host: "127.0.0.1:27001" }]}

rs.initiate(cfg)

rs.status()

exit
```

* Lo mismo para el otro shard
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 27100

cfg={_id:"shard2", members:[{_id:0 ,host: "127.0.0.1:27100"}, {_id:1 ,host: "127.0.0.1:27101" }]}

rs.initiate(cfg)

rs.status()

exit
```
* Iniciar servicios de ruteo
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongos" --configdb rsConf/127.0.0.1:26050,127.0.0.1:26051 --logappend --logpath C:\data\mongodb\shardlog --port 28001 --bind_ip 127.0.0.1
```
* Abrir nuevo git bash o cmd(siempre como administrador) y abrir sesion cliente de mongo
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 28001
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
## Opcional
Abrir eclipse y cambiar el puerto a 28001 para que se conecte al servicio de ruteo (mongos) en el RepoAbstractMongo y luego ejecutar la app.

A partir de ahora se puede ver las colecciones
```
use joits
 db.Pelicula.find().pretty()
db.Pelicula.count()
```

* Las peliculas y sagas estan en el shard dos, esto se ve haciendo:
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 27100

use joits
db.Pelicula.count()
```
## Creamos las shardkeys con indices hash.

Volvemos a levantar el puerto 28001:
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 28001

use joits

-- creamos el índice de peliculas por hash del titulo 

db.Peliculas.ensureIndex({"titulo": "hashed"})

-- habilitamos el sharding para la database joits

sh.enableSharding("joits")

-- definimos la clave por el índice 

sh.shardCollection("joits.Peliculas", {"titulo": "hashed" }, false)
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









