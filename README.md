# Pasos para crear shards
1)Crear carpeta data y mongodb.
2)Ejecutar como administrador cmd o git bash
3)Levantar
```
"C:\Program Files\MongoDB\Server\4.0\bin\mongod.exe" --dbpath C:\data\mongodb
```

4)Crear carpeta sharding en mongodb

5)Pararse en el directorio sharding y crear las carpetas

mkdir cfg1 cfg2 shard1 shard2 repl1 repl2

6)
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --replSet rsConf --configsvr --port 26050 --logpath C:\data\mongodb\sharding\log.cfg1 --logappend --dbpath C:\data\mongodb\sharding\cfg1

7)
Abrir nueva terminal
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --replSet rsConf --configsvr --port 26051 --logpath C:\data\mongodb\sharding\log.cfg2 --logappend --dbpath C:\data\mongodb\sharding\cfg2

**Para cambiar a carpeta sharding**

cd C:\data\mongodb\sharding

8) Se deberian creardos archivos log en la carpeta sharding y otro archivos en la carpeta cfg1 y cfg2
9)
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard1 --dbpath C:\data\mongodb\sharding\shard1 --logpath C:\data\mongodb\sharding\log.shard1 --port 27000 --logappend --smallfiles --oplogSize 50

10)
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard1 --dbpath C:\data\mongodb\sharding\repl1 --logpath C:\data\mongodb\sharding\log.repl1 --port 27001 --logappend --smallfiles --oplogSize 50

11)
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard2 --dbpath C:\data\mongodb\sharding\shard2 --logpath C:\data\mongodb\sharding\log.shard2 --port 27100 --logappend --smallfiles --oplogSize 50

12)
"C:\Program Files\MongoDB\Server\4.0\bin\mongod" --shardsvr --replSet shard2 --dbpath C:\data\mongodb\sharding\repl2 --logpath C:\data\mongodb\sharding\log.repl2 --port 27101 --logappend --smallfiles --oplogSize 50

13)Levantar instancia de mongo en puerto 26050:

"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 26050


cfg={_id:"rsConf",members:[{_id:0 ,host: "127.0.0.1:26050"}, {_id: 1, host: "127.0.0.1:26051" }]}

rs.initiate(cfg) 
//deberia tirar un ok: 1
exit
15)
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 27000

cfg={_id:"shard1", members:[{_id:0 ,host: "127.0.0.1:27000"}, {_id:1 ,host: "127.0.0.1:27001" }]}


rs.initiate(cfg)

rs.status()

exit

16)
"C:\Program Files\MongoDB\Server\4.0\bin\mongo" --port 27100

cfg={_id:"shard2", members:[{_id:0 ,host: "127.0.0.1:27100"}, {_id:1 ,host: "127.0.0.1:27101" }]}

rs.initiate(cfg)

rs.status()

exit

16)iniciar servicios de ruteo

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









