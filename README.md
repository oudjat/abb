# Technical document

4  Networking << >>
                            1. Who you connect to the edge 
                                a. what ip range
                                b. what protocol you should use to connect
                                c. write the linux command or the connection string for this protocol 
                            2. Write 3 different things you should check
                            3. Write 5 different error that should happened

5 Documentation -Write a short recipe as a knowledge database solving one of the possible errors on the step 4.

## Answers                           
4
1 > 
a. Public ip 89.32.42.4
b. Connect with SSH protocol
c. ssh support@89.32.42.4

2 > 
 2.1 -> Check connection between edge/server and new ip. 
 2.2 -> Maybe the vpn is down. Check connection with ping or traceroute between edge/server, another device in 192.168.2.0/23 . Check status vpn
 2.3 -> Jump to monitoring tool server and check the connectivity between monitoring tool server and the new IP with ping, or traceroute command.

3 > 
 3.1 -> VPN is down. Check connection.
 3.2 -> edge/server can't access to new ip.
 3.3 -> In 192.168.2.0/23 can't access to 10.2.3.0/32. The route not has created in edge/server. 
 3.4 -> Human error. The new entry is wrong. 
 3.5 -> Net interface is down
 
5

Error: The monitoring tool is not storing any data even though the IP and database hostname have been added.

Steps to Resolve:

    Verify SSH Connection to the Edge Machine:
    ssh -v support@89.32.42.4

    Check Network Configuration:
    a. If connect, execute command <<ip a>> display all interfaces. Ensure that the interface connected to the factory has the correct IP (10.2.3.0/32) and is active. Command <<sudo ip link set "interface-factory" up>>
    b. Search interface network 192.168.2.0/23 with <<ip a>>. 
    c. Ping to other device in network 192.168.2.0/23. 
    d. VPN is up? check logs. Restart service. 
