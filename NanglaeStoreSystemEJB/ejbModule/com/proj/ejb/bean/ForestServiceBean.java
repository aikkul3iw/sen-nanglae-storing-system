package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Forest;
import com.proj.ejb.face.ForestService;

@Stateless
@Remote(ForestService.class)
public class ForestServiceBean implements ForestService{

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;
	
	@Override
	public void save(Forest frs) {
		this.em.persist(frs);
		
	}

	@Override
	public void update(Forest frs) {
		this.em.merge(frs);
		
	}

	@Override
	public void delete(long frs_id) {
		Forest frs = findForestById(frs_id);
		if(frs != null){
			em.remove(frs);;
		}
		
	}

	@Override
	public Forest findForestById(long frs_id) {
		return this.em.find(Forest.class, frs_id);
	}



	@Override
	public List<Forest> listAllForest() {
		List<Forest> list = em.createQuery("SELECT f FROM Forest f").getResultList();
		return list;
	}

}
