+ Crate swarm token.

      docker-machine create -d virtualbox local
      eval "$(docker-machine env local)"
      docker run swarm create
      TOKEN="51a30269d3f3aaa04f744280e3c118aea032f6df85b49819aee29d379ac313b5"

+ Create swarm master.

      docker-machine create \
        -d virtualbox \
        --virtualbox-memory=512 \
        --virtualbox-hostonly-cidr="192.168.100.1/24" \
        swarm-master

      eval $(docker-machine env swarm-master)

      docker run \
        -d \
        -e MYID=1 \
        -e SERVERS=192.168.100.100,192.168.100.101,192.168.100.102,192.168.100.103 \
        --name=zk \
        --net=host \
        --restart=always \
        -p 2181:2181 \
        -p 2888:2888 \
        -p 3888:3888 \
        mesoscloud/zookeeper:3.4.6-centos-7

        docker run \
          -d \
          --restart=always \
          --publish=2376:2376 \
          -H tcp://192.168.99.106:2376 \
          swarm manage \
          zk://192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103/zk

+ Create swarm agent 01.

      docker-machine create \
        -d virtualbox \
        --virtualbox-memory=512 \
        --virtualbox-hostonly-cidr="192.168.100.1/24" \
        swarm-agent-01

      eval $(docker-machine env swarm-agent-01)

      docker run \
        -d \
        -e MYID=2 \
        -e SERVERS=192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103 \
        --name=zk \
        --net=host \
        --restart=always \
        -p 2181:2181 \
        -p 2888:2888 \
        -p 3888:3888 \
        mesoscloud/zookeeper:3.4.6-centos-7

      docker run \
        -d \
        --name=swarm \
        swarm join \
        --advertise=192.168.99.101:2375 \
        zk://192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103/zk

+ Create swarm agent 02.

        docker-machine create \
          -d virtualbox \
          --virtualbox-memory=512 \
          --virtualbox-hostonly-cidr="192.168.100.1/24" \
          swarm-agent-02

        eval $(docker-machine env swarm-agent-02)

        docker run \
          -d \
          -e MYID=3 \
          -e SERVERS=192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103 \
          --name=zk \
          --net=host \
          --restart=always \
          --publish=2181:2181 \
          --publish=2888:2888 \
          --publish=3888:3888 \
          --publish=8080:8080 \
          mesoscloud/zookeeper:3.4.6-centos-7

        docker run \
          -d \
          --name=swarm \
          swarm join \
          --advertise=192.168.99.102:2375 \
          zk://192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103/zk

        docker run \
          -it \
          swarm list \
          zk://192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103/zk

+ Create swarm agent 03.

        docker-machine create \
          -d virtualbox \
          --virtualbox-memory=512 \
          --virtualbox-hostonly-cidr="192.168.100.1/24" \
          swarm-agent-03

        eval $(docker-machine env swarm-agent-03)

        docker run \
          -d \
          -e MYID=4 \
          -e SERVERS=192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103 \
          --name=zk \
          --net=host \
          --restart=always \
          --publish=2181:2181 \
          --publish=2888:2888 \
          --publish=3888:3888 \
          --publish=8080:8080 \
          mesoscloud/zookeeper:3.4.6-centos-7

        docker run \
          -d \
          --name=swarm \
          swarm join \
          --advertise=192.168.99.103:2375 \
          zk://192.168.99.100,192.168.99.101,192.168.99.102,192.168.100.103/zk

+ Deploy.

      eval $(docker-machine env --swarm swarm-master)
      docker info
      docker-compose up exhibitor
      docker-compose scale exhibitor=2
