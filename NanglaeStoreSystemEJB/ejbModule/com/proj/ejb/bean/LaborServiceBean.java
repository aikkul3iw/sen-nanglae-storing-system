package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Labor;
import com.proj.ejb.face.LaborService;

@Stateless
@Remote(LaborService.class)
public class LaborServiceBean implements LaborService{

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;
	
	@Override
	public void save(Labor lab) {
		this.em.persist(lab);
		
	}

	@Override
	public void update(Labor lab) {
		this.em.merge(lab);
		
	}

	@Override
	public void delete(long lab_id) {
		Labor lab = findLaborById(lab_id);
		if(lab != null){
			em.remove(lab);;
		}
		
	}

	@Override
	public Labor findLaborById(long lab_id) {
		return this.em.find(Labor.class, lab_id);
	}



	@Override
	public List<Labor> listAllLabor() {
		List<Labor> list = em.createQuery("SELECT l FROM Labor l").getResultList();
		return list;
	}

}
