package com.xoolibeut.gainde.cassandra.repository;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;

public class GaindeSessionConnection {

	private Map<String, GaindeSession> mapSessions = new ConcurrentHashMap<>();
	private static GaindeSessionConnection gaindeSession;

	public static GaindeSessionConnection getInstance() {

		if (gaindeSession == null) {
			gaindeSession = new GaindeSessionConnection();
		}
		return gaindeSession;
	}

	private GaindeSessionConnection() {

	}

	public Cluster getCluster(String name) {
		if (mapSessions.get(name) != null) {
			return mapSessions.get(name).getCluster();
		}
		return null;
	}

	public Session getSession(String name) {
		if (mapSessions.get(name) != null) {
			return mapSessions.get(name).getSession();
		}
		return null;
	}

	public void addSession(String name, Cluster cluster, Session session) {
		mapSessions.put(name, new GaindeSession(cluster, session));
	}

	public void closeGaindeSession(String name) {
		if (mapSessions.get(name).getSession() != null) {
			mapSessions.get(name).getSession().close();
		}
		if (mapSessions.get(name).getCluster() != null) {
			mapSessions.get(name).getCluster().close();
		}
	}
	public GaindeSession removeConnection(String name) {
		return mapSessions.remove(name);
	}
}
