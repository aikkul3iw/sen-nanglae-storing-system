package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Transport;

public interface TransportService {
	public void save(Transport tsp);

	public void update(Transport tsp);

	public void delete(long id);

	public Transport findTransportById(long id);

	public List<Transport> listAllTransport();
}
