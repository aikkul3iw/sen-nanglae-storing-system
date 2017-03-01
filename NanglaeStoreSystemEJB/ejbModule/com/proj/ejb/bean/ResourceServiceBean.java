package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Localg;
import com.proj.ejb.entity.Resource;
import com.proj.ejb.face.ResourceService;

@Stateless
@Remote(ResourceService.class)
public class ResourceServiceBean implements ResourceService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Resource r) {
		this.em.persist(r);
	}

	@Override
	public void update(Resource r) {
		this.em.merge(r);
	}

	@Override
	public void delete(long id) {
		Resource r = findResourceById(id);
		if (r != null) {
			this.em.remove(r);
		}
	}

	@Override
	public Resource findResourceById(long id) {
		return this.em.find(Resource.class, id);
	}

	@Override
	public List<Resource> listAllResource() {
		List<Resource> list = em.createQuery("SELECT g FROM Resource g").getResultList();
		return list;
	}

}
