package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.AIDSpatients;
import com.proj.ejb.face.AIDSpatientsService;

@Stateless
@Remote(AIDSpatientsService.class)
public class AIDSpatientsServiceBean implements AIDSpatientsService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(AIDSpatients aid) {
		// TODO Auto-generated method stub
		this.em.persist(aid);
	}

	@Override
	public void update(AIDSpatients aid) {
		// TODO Auto-generated method stub
		this.em.merge(aid);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		AIDSpatients aid = findAIDSpatientsById(id);
		if (aid != null) {
			em.remove(aid);
		}
	}

	@Override
	public AIDSpatients findAIDSpatientsById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(AIDSpatients.class, id);
	}

	@Override
	public List<AIDSpatients> listAllAIDSpatients() {
		// TODO Auto-generated method stub
		List<AIDSpatients> list = em.createQuery("SELECT aid FROM AIDSpatients aid").getResultList();
		return list;
	}

}
