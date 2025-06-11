cd /home/vagrant/ud3tn/

# add a contact
source .venv/bin/activate
python3 tools/aap2/aap2_config.py \
  --socket ./ud3tn.aap2.socket.2 \
  --schedule 1 86400 100000 \
  ipn:10.0 tcpclv3:192.168.50.10:4556


  # add a contact ipn30 (3rd VM)
source .venv/bin/activate
python3 tools/aap2/aap2_config.py \
  --socket ./ud3tn.aap2.socket.2 \
  --schedule 1 86400 100000 \
  ipn:30.0 tcpclv3:192.168.50.30:4556