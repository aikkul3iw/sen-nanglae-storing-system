package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Polution;
import com.proj.ejb.face.PolutionService;

@Stateless
@Remote(PolutionService.class)
public class PolutionServiceBean implements PolutionService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Polution act) {
		// TODO Auto-generated method stub
		this.em.persist(act);
	}

	@Override
	public void update(Polution act) {
		// TODO Auto-generated method stub
		this.em.merge(act);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Polution act = findPolutionById(id);
		if (act != null) {
			em.remove(act);
		}
	}

	@Override
	public Polution findPolutionById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Polution.class, id);
	}

	@Override
	public List<Polution> listAllPolution() {
		// TODO Auto-generated method stub
		List<Polution> list = em.createQuery("SELECT act FROM Polution act").getResultList();
		return list;
	}

}
