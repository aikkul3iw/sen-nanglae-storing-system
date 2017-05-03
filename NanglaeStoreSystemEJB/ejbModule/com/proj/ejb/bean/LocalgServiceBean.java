package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Localg;
import com.proj.ejb.face.LocalgService;

@Stateless
@Remote(LocalgService.class)
public class LocalgServiceBean implements LocalgService{
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;
	
	@Override
	public void save(Localg g) {
		this.em.persist(g);
	}

	@Override
	public void update(Localg g) {
		this.em.merge(g);
	}

	@Override
	public void delete(long id) {
		Localg g = findLocalgById(id);
		if (g != null) {
			em.remove(g);
		}
	}

	@Override
	public Localg findLocalgById(long id) {
		return this.em.find(Localg.class, id);
	}

	@Override
	public List<Localg>listAllLocalg() {
		List<Localg> list = em.createQuery("SELECT g FROM Localg g ORDER BY g.grp_year DESC").getResultList();
		return list;
	}
	
}
	