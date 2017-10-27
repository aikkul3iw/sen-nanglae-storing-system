package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Water;
import com.proj.ejb.face.WaterService;

@Stateless
@Remote(WaterService.class)
public class WaterServiceBean implements WaterService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Water wt) {
		// TODO Auto-generated method stub
		this.em.persist(wt);
	}

	@Override
	public void update(Water wt) {
		// TODO Auto-generated method stub
		this.em.merge(wt);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Water wt = findWaterById(id);
		if (wt != null) {
			em.remove(wt);
		}
	}

	@Override
	public Water findWaterById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Water.class, id);
	}

	@Override
	public List<Water> listAllWater() {
		// TODO Auto-generated method stub
		List<Water> list = em.createQuery("SELECT wt FROM Water wt").getResultList();
		return list;
	}

}
