# for GUI login
echo 'root:root' | chpasswd

# Update packages
apt update
apt install -y build-essential curl protobuf-compiler libxkbcommon-x11-0

# Install and configure DTChat
cd /vagrant/DTChat
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
sed -i 's/PLACEHOLDER_BP_ADDR/ipn:20.2/g' database.yaml