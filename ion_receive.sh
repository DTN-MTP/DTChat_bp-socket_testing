# receiving from ipn:10.2

cd /vagrant/bp-socket/tools
gcc -o bp-demo-receiver bp-demo-receiver.c
./bp-demo-receiver ipn:10.2
