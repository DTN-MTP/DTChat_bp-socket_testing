# cd /vagrant/configs
cd /vagrant/
export LD_LIBRARY_PATH="/usr/local/lib"
ionstart -I ./host10.rc

# c) Build and insert the Bundle Protocol (BP) kernel module:

cd /vagrant/bp-socket/
make
insmod /vagrant/bp-socket/bp_socket/bp.ko
# d) Build and launch the userspace daemon:

/vagrant/bp-socket/daemon/bp_daemon

