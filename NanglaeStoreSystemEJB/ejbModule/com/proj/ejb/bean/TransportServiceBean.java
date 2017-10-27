package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Transport;
import com.proj.ejb.face.TransportService;

@Stateless
@Remote(TransportService.class)
public class TransportServiceBean implements TransportService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Transport tsp) {
		// TODO Auto-generated method stub
		this.em.persist(tsp);
	}

	@Override
	public void update(Transport tsp) {
		// TODO Auto-generated method stub
		this.em.merge(tsp);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Transport tsp = findTransportById(id);
		if (tsp != null) {
			em.remove(tsp);
		}
	}

	@Override
	public Transport findTransportById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Transport.class, id);
	}

	@Override
	public List<Transport> listAllTransport() {
		List<Transport> list = em.createQuery("SELECT tsp FROM Transport tsp").getResultList();
		return list;
	}

}
