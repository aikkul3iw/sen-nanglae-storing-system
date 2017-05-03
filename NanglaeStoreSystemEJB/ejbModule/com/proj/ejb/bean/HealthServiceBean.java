package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Health;
import com.proj.ejb.face.HealthService;

@Stateless
@Remote(HealthService.class)
public class HealthServiceBean implements HealthService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Health hlt) {
		this.em.persist(hlt);

	}

	@Override
	public void update(Health hlt) {
		this.em.merge(hlt);

	}

	@Override
	public void delete(long hlt_id) {
		Health hlt = findHealthById(hlt_id);
		if (hlt != null) {
			em.remove(hlt);
			
		}

	}

	@Override
	public Health findHealthById(long hlt_id) {
		return this.em.find(Health.class, hlt_id);
	}

	@Override
	public List<Health> listAllHealth() {
		List<Health> list = em.createQuery("SELECT h FROM Health h ORDER BY h.hlt_year DESC").getResultList();
		return list;
	}

}
