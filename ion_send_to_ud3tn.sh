# sending to ipn:2O.2

cd /vagrant/bp-socket/tools
gcc -o bp-demo-sender bp-demo-sender.c
./bp-demo-sender ipn:20.2

# sending to ipn:1O.2 ( if you are ipn:30.2)

cd /vagrant/bp-socket/tools
gcc -o bp-demo-sender bp-demo-sender.c
./bp-demo-sender ipn:10.2

# sending to ipn:3O.2 ( if you are ipn:10.2)

cd /vagrant/bp-socket/tools
gcc -o bp-demo-sender bp-demo-sender.c
./bp-demo-sender ipn:30.2
