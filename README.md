# Bp-socket

Bp-socket is a project designed to tackle a core DTN problem: providing a clean, interoperable API to facilitate application developers in sending data using the Bundle Protocol (BP).

The core objective of this project is to extend the Linux networking stack by introducing a new address family specifically for BP communication. The new address family, `BP_AF`, offers a protocol abstraction that aligns with the **Interplanetary Networking (IPN) Scheme Naming and Addressing**.

Bp-socket consists of two key components:

1. **Kernel Module**: Provides a kernel-level abstraction for DTN communication with IPN scheme.
2. **User-Space Daemon**: Acts as a pass-through service, facilitating communication between the kernel and the ION (Interplanetary Overlay Network) daemon, which handles the actual BP processing.

# DTChat Bundle Protocol Testing

This project provides a comprehensive testing environment for the DTChat application using Bundle Protocol (BP) communication across multiple nodes. The setup demonstrates inter-node communication between ION-DTN and IPN30-DTN implementations through a virtualized network infrastructure.Each node has a GUI for DTChat.

## Presentation

DTChat is a distributed chat application that leverages Bundle Protocol (BP) for communication in delay-tolerant networks. This testing environment creates a three-node network where each node runs different DTN implementations:

- **ION-DTN nodes** - NASA's Interplanetary Overlay Network implementation
- **µD3TN node** - Lightweight DTN implementation optimized for resource-constrained environments

The bp-socket component provides kernel-level Bundle Protocol socket support, enabling applications to communicate using BP as easily as traditional TCP/UDP sockets.

## Setup

### Prerequisites

- Vagrant with libvirt provider
- rsync for file synchronization
- Linux host system

### Initialize Environment

1. **Start all virtual machines:**
```bash
vagrant up
```

2. **Enable file synchronization (Optional):**
Enable automatic file synchronization on `ion-node`
```bash
vagrant rsync-auto
```
> Make sure to keep this process running in a separate terminal during development.


3. **Setup each VM with startup scripts:**

**ION Node:**
```bash
vagrant ssh -c "sudo -i" ion
source /vagrant/start.ion.sh
```

**IPN30 Node:**
```bash
vagrant ssh -c "sudo -i" ipn30
source /vagrant/start.ipn30.sh
```

**µD3TN Node (Optional):**
```bash
# Terminal 1 - Start µD3TN daemon
vagrant ssh ud3tn
sudo -i
source /vagrant/start.ud3tn_1.sh
```
Then, in another terminal, add an outgoing contact to the ION and IPN30 nodes:
```bash
source /vagrant/start.ud3tn_2.sh
```

4. **Install DTChat on ION and IPN30 nodes:**
Install

**ION Node:**
```bash
source /vagrant/install-dtchat_ion.sh
```

**IPN30 Node:**
```bash
source /vagrant/install-dtchat_ipn30.sh
```

## Test Scenarios

Each test scenario demonstrates bidirectional communication between nodes using DTChat GUI applications. The tests are built to add artificial delays in order to test the Predicted Bundle Arrival Time calculation with A-SABR (initialized with the hostrc contact plans).

### Main Scenario : ION(DTChat) ↔ IPN30(DTChat)
Launch DTChat on both nodes to send and receive messages bidirectionally via DTChat GUI

**ION (Launch DTChat):**
```bash
# vagrant ssh -c "sudo -i" ion
cd /vagrant/DTChat
DTCHAT_ACK_DELAY_MS=3000 cargo run --features delayed_ack
```

**IPN30 (Launch DTChat):**
```bash
# vagrant ssh -c "sudo -i" ipn30
cd /vagrant/DTChat
DTCHAT_ACK_DELAY_MS=5000 cargo run --features delayed_ack
```

## For Troubleshooting via Terminal
The following scenarios use command-line tools instead of DTChat for debugging and testing individual communication paths between nodes.


### Scenario 1: ION → Others (IPN30 & µD3TN(Optional))

**IPN30 (Receiver):**
```bash
# vagrant ssh -c "sudo -i" ipn30
source /vagrant/ipn30_receive.sh
```

**ION (Sender to IPN30):**
```bash
# vagrant ssh -c "sudo -i" ion
source /vagrant/ion_send_to_ipn30.sh
```

**µD3TN (Receiver):**
```bash
# vagrant ssh -c "sudo -i" ud3tn
source /vagrant/ud3tn_receive.sh
```

**ION (Sender to UD3TN):**
```bash
# vagrant ssh -c "sudo -i" ion
source /vagrant/ion_send_to_ud3tn.sh
```

### Scenario 2: IPN30 → Others (ION & µD3TN(Optional))

**ION (Receiver):**
```bash
# vagrant ssh -c "sudo -i" ion
source /vagrant/ion_receive.sh
```

**IPN30 (Sender to ION):**
```bash
# vagrant ssh -c "sudo -i" ipn30
source /vagrant/ipn30_send_to_ion.sh
```

**µD3TN (Receiver):**
```bash
# vagrant ssh -c "sudo -i" ud3tn
source /vagrant/ud3tnn_receive.sh
```

**IPN30 (Sender to µD3TN):**
```bash
# vagrant ssh -c "sudo -i" ipn30
source /vagrant/ipn30_send_to_ud3tn.sh
```

### Scenario 3 (Optional): µD3TN → Others (ION & IPN30)

**ION (Receiver):**
```bash
# vagrant ssh -c "sudo -i" ion
source /vagrant/ion_receive.sh
```

**µD3TN (Sender to ION):**
```bash
# vagrant ssh -c "sudo -i" ud3tn
source /vagrant/ud3tn_send_to_ion.sh
```

**IPN30 (Receiver):**
```bash
# vagrant ssh -c "sudo -i" ipn30
source /vagrant/ipn30_receive.sh
```

**µD3TN (Sender to IPN30):**
```bash
# vagrant ssh -c "sudo -i" ud3tn
source /vagrant/ud3tn_send_to_ipn30.sh
```

*Note: µD3TN uses command-line tools for sending since DTChat is not installed on this node.*

## DTChat Usage

After starting DTChat with `cargo run`, you can:

1. **Select a peer** from the configured list (ipn30, alice, bob, etc.)
2. **Type your message** in the text input field
3. **Send messages** using Bundle Protocol to the configured endpoints
4. **View received messages** in the chat interface

DTChat will automatically use the BP addresses configured during installation:
- **ION Node**: `ipn:10.2`
- **IPN30 Node**: `ipn:30.2`

## Network Architecture

- **ION Node**: 192.168.50.10 (EID: ipn:10.0, DTChat: ipn:10.2)
- **µD3TN Node**: 192.168.50.20 (EID: ipn:20.0, Receiver: ipn:20.2)
- **IPN30 Node**: 192.168.50.30 (EID: ipn:30.0, DTChat: ipn:30.2)

All nodes communicate via Bundle Protocol over TCP on port 4556.

## Troubleshooting

- **Check BP module**: `lsmod | grep bp`
- **Monitor network**: `tcpdump -i any port 4556`
- **Verify services**: Check if ION/µD3TN services are running
- **VM connectivity**: Ensure all VMs can ping each other
- **DTChat dependencies**: Ensure Rust toolchain and protobuf-compiler are installed

To stop receivers, use `Ctrl+C` in the terminal where they are running.