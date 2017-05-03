package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Religion;
import com.proj.ejb.face.ReligionService;

@Stateless
@Remote(ReligionService.class)
public class ReligionServiceBean implements ReligionService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Religion rel) {
		// TODO Auto-generated method stub
		this.em.persist(rel);
	}

	@Override
	public void update(Religion rel) {
		// TODO Auto-generated method stub
		this.em.merge(rel);
	}

	@Override
	public void delete(long rel_id) {
		// TODO Auto-generated method stub
		Religion rel = findReligionById(rel_id);
		if (rel != null) {
			em.remove(rel);
		}
	}

	@Override
	public Religion findReligionById(long rel_id) {
		// TODO Auto-generated method stub
		return this.em.find(Religion.class, rel_id);
	}

	@Override
	public List<Religion> listAllReligion() {
		// TODO Auto-generated method stub
		List<Religion> list = em.createQuery("SELECT rel FROM Religion rel ORDER BY rel.rel_year DESC").getResultList();
		return list;
	}

}
