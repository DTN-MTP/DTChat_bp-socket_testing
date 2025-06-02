# for GUI login
echo 'root:root' | chpasswd

cd /vagrant/DTChat
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
apt install -y protobuf-compiler libxkbcommon-x11-0
