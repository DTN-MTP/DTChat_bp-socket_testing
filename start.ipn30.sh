# cd /vagrant/configs
cd /vagrant/bp-socket/configs
export LD_LIBRARY_PATH="/usr/local/lib"
ionstart -I ./host2.rc

# c) Build and insert the Bundle Protocol (BP) kernel module:

cd /vagrant/bp-socket/src/kernel
make
insmod bp.ko

# d) Build and launch the userspace daemon:

cd /vagrant/bp-socket/src/daemon
make
./bp_daemon