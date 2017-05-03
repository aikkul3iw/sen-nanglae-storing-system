package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Electricity;
import com.proj.ejb.face.ElectricityService;

@Stateless
@Remote(ElectricityService.class)
public class ElectricityServiceBean implements ElectricityService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Electricity e) {
		em.persist(e);
	}

	@Override
	public void update(Electricity e) {
		em.merge(e);
	}

	@Override
	public void delete(long id) {
		Electricity e = findElectricityById(id);
		if (e != null) {
			em.remove(e);
		}
	}

	@Override
	public Electricity findElectricityById(long id) {
		return this.em.find(Electricity.class, id);
	}

	@Override
	public List<Electricity> listAllElectricity() {
		List<Electricity> list = em.createQuery("SELECT e FROM Electricity e ORDER BY e.elec_year DESC, e.location.vil_number").getResultList();
		return list;
	}
}
