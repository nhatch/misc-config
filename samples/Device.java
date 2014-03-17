package edu.uchicago.proprio.draggr.transfer;

import static edu.uchicago.proprio.draggr.transfer.Connector.Command.*;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.io.File;
import java.io.IOException;

import android.util.Log;


public class Device {
	private Connector conn;
	private String name;
	private int port;
	private Map<String,File> thumbnails;
	private Map<String,File> previews;
	private boolean connecting; /* whether we are in the process of connecting */
	private byte[] inetAddress; /* added in case we need to hard code the IPs */
	
	public Device (String name) {
		this(name, Server.defaultPort, null);
	}
	
	public Device (String name, byte[] inetAddress) {
		this(name, Server.defaultPort, inetAddress);
	}
	
	public Device (String name, int port) {
		this(name, port, null);
	}
	
	public Device (String name, int port, byte[] inetAddress) {
		super();
		this.name = name;
		this.port = port;
		thumbnails = new HashMap<String,File>();
		previews = new HashMap<String,File>();
		conn = new Connector();
		connecting = true;
		this.inetAddress = inetAddress;
	}
	
	public boolean isConnected() {
		return conn.isConnected();
	}
	
	public String getName() {
		return name;
	}
	
	public int getPort() {
		return port;
	}
	
    boolean hasInetAddress() {
    	return inetAddress != null;
    }
    
    byte[] getInetAddress() {
    	return inetAddress;
    }
	
	public synchronized boolean blockUntilConnected() {
		try {
			while (connecting)
				this.wait();
			return isConnected();
		} catch (InterruptedException e) {
			return false;
		}
	}
	
	/* Returns true if successful, false otherwise. */
	synchronized boolean tryConnect() {
		connecting = true;
		boolean success = false;
		boolean done = false;
		
if (inetAddress == null) {
		/* Search all interfaces for a site-local IPv4 address */
		Enumeration<NetworkInterface> e = null;
		try {
			e = NetworkInterface.getNetworkInterfaces();
		} catch (SocketException x) {
			done = true;
		}
		
if (!done) {
search:
		while (e.hasMoreElements()) {
			Enumeration<InetAddress> ee = e.nextElement().getInetAddresses();
			while (ee.hasMoreElements()) {
				InetAddress a = ee.nextElement();
				if (a instanceof Inet4Address && a.isSiteLocalAddress()) {
					
					/* Scan through the 256 closest addresses for a match */
					byte[] addr = a.getAddress();
					for (int i = 0; i < 256; i++) {
						addr[3] = (byte) i;
						//Log.d(name, "Attempt to connect to " + i);
						try {
							InetSocketAddress aa = new InetSocketAddress(
									InetAddress.getByAddress(addr), this.port);
							// TODO pick a good timeout
							if (conn.connect(aa, 20, this.name)) {
								success = true;
								break search;
							}
						} catch (UnknownHostException x) {
						}
					}
				}
			}
		}
}
} else /* inetAddress != null */ {
	try {
		InetSocketAddress aa = new InetSocketAddress(
				InetAddress.getByAddress(inetAddress), this.port);
		//Log.d(name, "Preset: " + inetAddress.toString());
		// TODO pick a good timeout
		if (conn.connect(aa, 2000, this.name)) {
			success = true;
		}
	} catch (UnknownHostException e) {
	}
}
		connecting = false;
		this.notifyAll();
		return success;
	}
	
	String motd() throws IOException {
		conn.sendCommand(MOTD);
		return conn.recvString();
	}
	
	void updateFiles(String filter) throws IOException {
		conn.sendCommand(LIST_FILES);
		conn.sendString(filter);
		String[] files = conn.recvString().split("\n");
		thumbnails.clear();
		for (String filename : files) {
			File f = File.createTempFile(name + "_", ".thumb");
			conn.recvFile(f);
			thumbnails.put(filename, f);
		}
	}
	
	public Set<String> listFiles() {
		return thumbnails.keySet();
	}
	
	void transfer(String filename, Device otherDevice)
			throws IOException {
		Connector.Command cmd = (otherDevice.hasInetAddress()) ? TRANSFER_IP : TRANSFER;
		conn.sendCommand(cmd);
		conn.sendString(otherDevice.getName());
		conn.sendInt(otherDevice.getPort());
		if (cmd == TRANSFER_IP) conn.sendIP(otherDevice.getInetAddress());
		conn.sendString(filename);
	}
	
	void upload(String filename, File f, File thumb, File preview)
			throws IOException {
		conn.sendCommand(UPLOAD);
		conn.sendString(filename);
		conn.sendFile(f);
		conn.sendFile(thumb);
		conn.sendFile(preview);
	}
	
	public File thumbnail(String filename) {
		return thumbnails.get(filename);
	}
	
	public File preview(String filename) throws IOException {
		File f = previews.get(filename);
		if (f == null) {
			f = File.createTempFile(name + "_", ".preview");
			conn.sendCommand(PREVIEW);
			conn.sendString(filename);
			conn.recvFile(f);
			previews.put(filename, f);
		}
		return f;
	}

	public void close() throws IOException {
		conn.sendCommand(CLOSE);
		conn.close();
		for (File f : thumbnails.values()) {
			f.delete();
		}
		for (File f : previews.values()) {
			f.delete();
		}
	}

	public String toString() {
		return "Device for " + conn;
	}
}
