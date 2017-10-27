package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Service;
import com.proj.ejb.face.ServiceService;

@Stateless
@Remote(ServiceService.class)
public class ServiceServiceBean implements ServiceService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Service s) {
		this.em.persist(s);
	}

	@Override
	public void update(Service s) {
		this.em.merge(s);
	}

	@Override
	public void delete(long id) {
		Service s = findServiceById(id);
		if (s != null) {
			this.em.remove(s);
		}
	}

	@Override
	public Service findServiceById(long id) {
		return this.em.find(Service.class, id);
	}

	@Override
	public List<Service> listAllService() {
		List<Service> list = em.createQuery("SELECT s FROM Service s").getResultList();
		return list;
	}

}
