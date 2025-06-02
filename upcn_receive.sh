cd /home/vagrant/ud3tn/
# start a receiver
source .venv/bin/activate
python3 tools/aap2/aap2_receive.py --agentid 2 --socket ./ud3tn.aap2.socket.2

