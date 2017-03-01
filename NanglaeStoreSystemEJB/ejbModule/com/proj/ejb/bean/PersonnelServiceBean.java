package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Personnel;
import com.proj.ejb.face.PersonnelService;

@Stateless
@Remote(PersonnelService.class)
public class PersonnelServiceBean implements PersonnelService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Personnel psn) {
		// TODO Auto-generated method stub
		this.em.persist(psn);
	}

	@Override
	public Personnel findPersonnelById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Personnel.class, id);
	}

	@Override
	public void update(Personnel psn) {
		// TODO Auto-generated method stub
		this.em.merge(psn);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Personnel psn = findPersonnelById(id);
		if (psn != null) {
			em.remove(psn);
		}
	}

	@Override
	public List<Personnel> listAllPersonnel() {
		List<Personnel> list = em.createQuery("SELECT psn FROM Personnel psn").getResultList();
		return list;
	}

}
