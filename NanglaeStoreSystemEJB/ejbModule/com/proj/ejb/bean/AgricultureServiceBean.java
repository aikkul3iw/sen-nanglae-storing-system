package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Agriculture;
import com.proj.ejb.face.AgricultureService;

@Stateless
@Remote(AgricultureService.class)
public class AgricultureServiceBean implements AgricultureService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Agriculture act) {
		// TODO Auto-generated method stub
		this.em.persist(act);
	}

	@Override
	public void update(Agriculture act) {
		// TODO Auto-generated method stub
		this.em.merge(act);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Agriculture act = findAgricultureById(id);
		if (act != null) {
			em.remove(act);
		}
	}

	@Override
	public Agriculture findAgricultureById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Agriculture.class, id);
	}

	@Override
	public List<Agriculture> listAllAgriculture() {
		// TODO Auto-generated method stub
		List<Agriculture> list = em.createQuery("SELECT act FROM Agriculture act").getResultList();
		return list;
	}

}
