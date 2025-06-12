# sending to ipn:10.2 

cd /home/vagrant/ud3tn/
source .venv/bin/activate
python3 tools/aap2/aap2_send.py --agentid 2 --socket ./ud3tn.aap2.socket.2 ipn:10.2 "Hello from ud3tn!" -v

# sending to ipn:30.2

cd /home/vagrant/ud3tn/
source .venv/bin/activate
python3 tools/aap2/aap2_send.py --agentid 2 --socket ./ud3tn.aap2.socket.2 ipn:30.2 "Hello from ud3tn!" -v
