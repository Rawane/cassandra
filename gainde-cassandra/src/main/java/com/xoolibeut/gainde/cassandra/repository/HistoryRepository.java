package com.xoolibeut.gainde.cassandra.repository;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import com.xoolibeut.gainde.cassandra.controller.dtos.HistoryDTO;

public interface HistoryRepository {

	boolean createOrUpdateHistory(HistoryDTO historyDTO) throws IOException, NoSuchAlgorithmException;

	List<HistoryDTO> readlAllhystories() throws IOException;

	public boolean removeHistory(String id) throws IOException;
}
