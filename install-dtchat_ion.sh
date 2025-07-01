# for GUI login
echo 'root:root' | chpasswd

cd /vagrant/DTChat
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
apt install -y protobuf-compiler libxkbcommon-x11-0
rm database.yaml
cp ../database10.yaml database.yaml
echo -e "cd /vagrant/DTChat/\nDTCHAT_ACK_DELAY_MS=3000 cargo run --features delayed_ack" > /root/run_dtchat.sh
