# Bp-socket

Bp-socket is a project designed to tackle a core DTN problem: providing a clean, interoperable API to facilitate application developers in sending data using the Bundle Protocol (BP).

The core objective of this project is to extend the Linux networking stack by introducing a new address family specifically for BP communication. The new address family, `BP_AF`, offers a protocol abstraction that aligns with the **Interplanetary Networking (IPN) Scheme Naming and Addressing**.

Bp-socket consists of two key components:

1. **Kernel Module**: Provides a kernel-level abstraction for DTN communication with IPN scheme.
2. **User-Space Daemon**: Acts as a pass-through service, facilitating communication between the kernel and the ION (Interplanetary Overlay Network) daemon, which handles the actual BP processing.

# DTChat Bundle Protocol Testing

This project provides a comprehensive testing environment for the DTChat application using Bundle Protocol (BP) communication across multiple nodes. The setup demonstrates inter-node communication between ION-DTN and µD3TN implementations through a virtualized network infrastructure.

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

2. **Enable file synchronization (optional):**
```bash
vagrant rsync-auto
```

3. **Setup each VM with startup scripts:**

**ION Node:**
```bash
vagrant ssh ion
sudo -i
source /vagrant/start.ion.sh
```

**µD3TN Node:**
```bash
# Terminal 1 - Start µD3TN daemon
vagrant ssh ud3tn
sudo -i
source /vagrant/start.ud3tn_1.sh
```
And then execute:
```bash
source /vagrant/start.ud3tn_2.sh
```

**IPN30 Node:**
```bash
vagrant ssh ipn30
sudo -i
source /vagrant/start.ipn30.sh
```

4. **Install DTChat on ION and IPN30 nodes:**

**ION Node:**
```bash
source /vagrant/install-dtchat_ion.sh
```

**IPN30 Node:**
```bash
source /vagrant/install-dtchat_ipn30.sh
```

## Test Scenarios

Each test scenario requires starting receivers on target nodes first, then using DTChat to send messages from the sender node.

### Scenario 1: ION → Others (µD3TN & IPN30)

**µD3TN (Receiver):**
```bash
vagrant ssh ud3tn
sudo -i
source /vagrant/ud3tn_receive.sh
```

**IPN30 (Receiver):**
```bash
vagrant ssh ipn30
sudo -i
source /vagrant/ipn30_receive.sh
```

**ION (Sender to UD3TN):**
```bash
vagrant ssh ion
sudo -i
source /vagrant/ion_send_to_ud3tn.sh
```

**ION (Sender to IPN30):**
```bash
vagrant ssh ion
sudo -i
source /vagrant/ion_send_to_ipn30.sh
```

**ION (Sender with DTChat):**
```bash
vagrant ssh ion
sudo -i
cd /vagrant/DTChat
cargo run
```

### Scenario 2: IPN30 → Others (ION & µD3TN)

**ION (Receiver):**
```bash
vagrant ssh ion
sudo -i
source /vagrant/ion_receive.sh
```

**µD3TN (Receiver):**
```bash
vagrant ssh ud3tn
sudo -i
source /vagrant/ud3tnn_receive.sh
```

**IPN30 (Sender to UD3TN):**
```bash
vagrant ssh ipn30
sudo -i
source /vagrant/ipn30_send_to_ud3tn.sh
```

**IPN30 (Sender to ION):**
```bash
vagrant ssh ipn30
sudo -i
source /vagrant/ipn30_send_to_ion.sh
```

**IPN30 (Sender with DTChat):**
```bash
vagrant ssh ipn30
sudo -i
cd /vagrant/DTChat
cargo run
```

### Scenario 3: µD3TN → Others (ION & IPN30)

**ION (Receiver):**
```bash
vagrant ssh ion
sudo -i
source /vagrant/ion_receive.sh
```

**IPN30 (Receiver):**
```bash
vagrant ssh ipn30
sudo -i
source /vagrant/ipn30_receive.sh
```

**µD3TN (Sender to ION):**
```bash
vagrant ssh ud3tn
sudo -i
source /vagrant/ud3tn_send_to_ion.sh
```

**µD3TN (Sender to IPN30):**
```bash
vagrant ssh ud3tn
sudo -i
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