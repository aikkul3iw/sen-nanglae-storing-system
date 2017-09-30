package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Disabled;
import com.proj.ejb.face.DisabledService;

@Stateless
@Remote(DisabledService.class)
public class DisabledServiceBean implements DisabledService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Disabled disabled) {
		// TODO Auto-generated method stub
		this.em.persist(disabled);
	}

	@Override
	public void update(Disabled disabled) {
		// TODO Auto-generated method stub
		this.em.merge(disabled);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Disabled disabled = findDisabledById(id);
		if (disabled != null) {
			em.remove(disabled);
		}
	}

	@Override
	public Disabled findDisabledById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Disabled.class, id);
	}

	@Override
	public List<Disabled> listAllDisabled() {
		// TODO Auto-generated method stub
		List<Disabled> list = em.createQuery("SELECT disabled FROM Disabled disabled").getResultList();
		return list;
	}

}
