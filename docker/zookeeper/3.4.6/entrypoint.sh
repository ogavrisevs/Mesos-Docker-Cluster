#!/bin/sh

set +x

cat > /opt/zookeeper/conf/zoo.cfg <<EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/opt/zookeeper/data
clientPort=2181
EOF

IP="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"

aws --region eu-west-1 ec2 describe-instances | jq -r -S ".Reservations[].Instances[] | select(contains( {Tags: [{ \"Value\": \"Mesos\", \"Key\": \"Project\"}]} )) | select(contains( {State: { \"Code\": 16, \"Name\": \"running\" }} )) | .PrivateIpAddress " > /tmp/zk-nodes

while IFS='' read -r line || [[ -n "$line" ]]; do
    ID=`echo $line | cut -d \. -f 4`
    if [ "$IP" == "$line" ]; then
        echo "$ID" > /opt/zookeeper/data/myid
        echo "server.$ID=localhost:2888:3888" >> /opt/zookeeper/conf/zoo.cfg
    else
        echo "server.$ID=$line:2888:3888" >> /opt/zookeeper/conf/zoo.cfg
    fi
done < /tmp/zk-nodes

exec "$@"
