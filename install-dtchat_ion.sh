# for GUI login
echo 'root:root' | chpasswd

cd /vagrant/DTChat
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
apt install -y protobuf-compiler libxkbcommon-x11-0
sed -i 's/PLACEHOLDER_BP_ADDR/ipn:10.2/g' database.yaml
sed -i 's/host2.rc/host10.rc/g' database.yaml
