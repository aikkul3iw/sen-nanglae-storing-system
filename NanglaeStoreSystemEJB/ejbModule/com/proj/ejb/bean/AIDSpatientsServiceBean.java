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
	public void save(AIDSpatients AID) {
		// TODO Auto-generated method stub
		this.em.persist(AID);
	}

	@Override
	public void update(AIDSpatients AID) {
		// TODO Auto-generated method stub
		this.em.merge(AID);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		AIDSpatients AID = findAIDSpatientsById(id);
		if (AID != null) {
			em.remove(AID);
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
		List<AIDSpatients> list = em.createQuery("SELECT disabled FROM Disabled disabled").getResultList();
		return list;
	}

}
