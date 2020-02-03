package com.xoolibeut.gainde.cassandra.repository;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;

public class GaindeSession {
	private Session session;
	private Cluster cluster;

	public GaindeSession(Cluster cluster, Session session) {
		this.cluster = cluster;
		this.session = session;
	}

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	public Cluster getCluster() {
		return cluster;
	}

	public void setCluster(Cluster cluster) {
		this.cluster = cluster;
	}
}
