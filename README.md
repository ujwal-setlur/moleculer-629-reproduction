# moleculer-629-reproduction
Reproduction repository for https://github.com/moleculerjs/moleculer/issues/629

# What is this?
This a repository to reproduce [moleculer-629](https://github.com/moleculerjs/moleculer/issues/629)

# Requirements
1. Docker >= 19.03.5
2. Docker Compose >= 1.24.1

# Steps

Clone this repository, build/pull the docker images, and run the containers:

```bash
docker-compose pull kafka zookeeper
docker-compose build moleculer
docker-comopse up -d
```

Output:
```bash
~/P/G/moleculer-629-reproduction ❯❯❯ docker-compose up -d                                                                                                                                                                                                                                                                                                                                                                                                                          master ✱ ◼
Creating network "moleculer-629-reproduction_kafka-network" with the default driver
Creating zookeeper ... done
Creating moleculer ... done
Creating kafka     ... done
```

Then enter the moleculer container and run the service:

```bash
docker exec -it moleculer bash
npm install
npm run dev
```

On the first run, the service should register with kafka correctly:

```bash
root@moleculer:/app# npm run dev

> moleculer-kafka@1.0.0 dev /app
> ts-node ./node_modules/moleculer/bin/moleculer-runner.js --hot --repl --config moleculer.config.ts services/**/*.service.ts

[2019-12-24T00:56:08.302Z] INFO  moleculer-kafka/BROKER: Moleculer v0.14.0-beta6 is starting...
[2019-12-24T00:56:08.306Z] INFO  moleculer-kafka/BROKER: Namespace: <not defined>
[2019-12-24T00:56:08.306Z] INFO  moleculer-kafka/BROKER: Node ID: moleculer-kafka
[2019-12-24T00:56:08.307Z] INFO  moleculer-kafka/METRICS: Metrics: Enabled
[2019-12-24T00:56:08.318Z] INFO  moleculer-kafka/REGISTRY: Strategy: RoundRobinStrategy
[2019-12-24T00:56:08.320Z] INFO  moleculer-kafka/BROKER: Serializer: JSONSerializer
[2019-12-24T00:56:08.328Z] INFO  moleculer-kafka/BROKER: Registered 14 internal middleware(s).
[2019-12-24T00:56:08.331Z] INFO  moleculer-kafka/BROKER: Transporter: KafkaTransporter
[2019-12-24T00:56:08.331Z] WARN  moleculer-kafka/BROKER: The KafkaTransporter has no built-in balancer. Broker balancer is ENABLED.
[2019-12-24T00:56:08.456Z] INFO  moleculer-kafka/API: API Gateway server created.
[2019-12-24T00:56:08.457Z] INFO  moleculer-kafka/API: Register route to '/api'
[2019-12-24T00:56:08.467Z] INFO  moleculer-kafka/API:
[2019-12-24T00:56:08.469Z] INFO  moleculer-kafka/TRANSIT: Connecting to the transporter...
[2019-12-24T00:56:08.561Z] INFO  moleculer-kafka/TRANSPORTER: Kafka client is connected.
[2019-12-24T00:56:11.340Z] INFO  moleculer-kafka/REGISTRY: '$node' service is registered.
[2019-12-24T00:56:11.343Z] INFO  moleculer-kafka/API: API Gateway listening on http://0.0.0.0:3000
[2019-12-24T00:56:11.345Z] INFO  moleculer-kafka/REGISTRY: 'api' service is registered.
[2019-12-24T00:56:11.347Z] INFO  moleculer-kafka/BROKER: ✔ ServiceBroker with 2 service(s) is started successfully.
[2019-12-24T00:56:11.362Z] INFO  moleculer-kafka/BROKER: Hot-reload is ACTIVE.
mol $
```

Quit the moleculer service and run it again. There will be a node conflict error after about 15-20 seconds:

```bash
mol $ quit
[2019-12-24T00:57:21.205Z] INFO  moleculer-kafka/BROKER: Stopping '$node' service...
[2019-12-24T00:57:21.207Z] INFO  moleculer-kafka/BROKER: Stopping 'api' service...
[2019-12-24T00:57:21.210Z] INFO  moleculer-kafka/API: API Gateway stopped!
[2019-12-24T00:57:21.225Z] INFO  moleculer-kafka/BROKER: ServiceBroker is stopped. Good bye.
root@moleculer:/app# npm run dev

> moleculer-kafka@1.0.0 dev /app
> ts-node ./node_modules/moleculer/bin/moleculer-runner.js --hot --repl --config moleculer.config.ts services/**/*.service.ts

[2019-12-24T00:57:25.554Z] INFO  moleculer-kafka/BROKER: Moleculer v0.14.0-beta6 is starting...
[2019-12-24T00:57:25.557Z] INFO  moleculer-kafka/BROKER: Namespace: <not defined>
[2019-12-24T00:57:25.557Z] INFO  moleculer-kafka/BROKER: Node ID: moleculer-kafka
[2019-12-24T00:57:25.559Z] INFO  moleculer-kafka/METRICS: Metrics: Enabled
[2019-12-24T00:57:25.568Z] INFO  moleculer-kafka/REGISTRY: Strategy: RoundRobinStrategy
[2019-12-24T00:57:25.570Z] INFO  moleculer-kafka/BROKER: Serializer: JSONSerializer
[2019-12-24T00:57:25.577Z] INFO  moleculer-kafka/BROKER: Registered 14 internal middleware(s).
[2019-12-24T00:57:25.579Z] INFO  moleculer-kafka/BROKER: Transporter: KafkaTransporter
[2019-12-24T00:57:25.580Z] WARN  moleculer-kafka/BROKER: The KafkaTransporter has no built-in balancer. Broker balancer is ENABLED.
[2019-12-24T00:57:25.705Z] INFO  moleculer-kafka/API: API Gateway server created.
[2019-12-24T00:57:25.706Z] INFO  moleculer-kafka/API: Register route to '/api'
[2019-12-24T00:57:25.717Z] INFO  moleculer-kafka/API:
[2019-12-24T00:57:25.720Z] INFO  moleculer-kafka/TRANSIT: Connecting to the transporter...
[2019-12-24T00:57:25.810Z] INFO  moleculer-kafka/TRANSPORTER: Kafka client is connected.
[2019-12-24T00:57:50.726Z] FATAL moleculer-kafka/BROKER: ServiceBroker has detected a nodeID conflict, use unique nodeIDs. ServiceBroker stopped. undefined
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! moleculer-kafka@1.0.0 dev: `ts-node ./node_modules/moleculer/bin/moleculer-runner.js --hot --repl --config moleculer.config.ts services/**/*.service.ts`
npm ERR! Exit status 1
npm ERR!
npm ERR! Failed at the moleculer-kafka@1.0.0 dev script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

npm ERR! A complete log of this run can be found in:
npm ERR!     /root/.npm/_logs/2019-12-24T00_57_50_754Z-debug.log
root@moleculer:/app#
```

