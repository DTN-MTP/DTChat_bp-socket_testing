cd /home/vagrant/ud3tn/

# start ud3tn
build/posix/ud3tn \
    --allow-remote-config \
    --eid ipn:20.0 \
    --aap2-socket ./ud3tn.aap2.socket.2 \
    --cla "tcpclv3:*,4556" -L 4