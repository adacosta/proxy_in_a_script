# Proxy in a Script

The type of proxy we're going to use is called a Socks proxy.

>SOCKS is an Internet protocol that exchanges network packets between a client and server through a proxy server. SOCKS5 additionally provides authentication so only authorized users may access a server. Practically, a SOCKS server proxies TCP connections to an arbitrary IP address, and provides a means for UDP packets to be forwarded. - [Wikipedia](https://en.wikipedia.org/wiki/SOCKS)

### How do you setup and use a proxy server?

To all the peeps out there with friends to impress,

It's easy to do just follow these steps.

1. Provision a proxy server with user data.
2. Put your proxy server endpoint info in that script.
3. Execute that script.

And that's the way you do it.

### Time to see the details

#### 1. Provision a server with user data

Create an Ubuntu 16.04 server with the following user data:

```
#!/bin/bash
wget --no-check-certificate https://raw.github.com/Lozy/danted/master/install.sh -O install.sh
sudo bash install.sh --port=2997 --user=USER --passwd=PASSWORD
sudo /etc/init.d/sockd start
```

Check if your server is ready with
```
telnet <IP> 2997
```

#### 2. Put your proxy server endpoint info in that script - OPTIONAL

Update that script directly or docker-compose.yml with any proxy user, password, port, or IP changes.

#### 3. Execute that script

The default URL in that script sends a GET to ipify, which reflects our source IP address.

The following will use our local machine for a GET from ipify (100.100.100.100 being our host public ip).

```
➥ docker-compose run app
code: 200
body: 100.100.100.100
```

Or set/override environment variables declared in docker-compose.yml with '-e' flags.

The following will use our proxy machine for a GET from ipify (123.123.123.123 being our proxy server public ip).

```
➥ docker-compose run -e IP=123.123.123.123 app
code: 200
body: 123.123.123.123
```