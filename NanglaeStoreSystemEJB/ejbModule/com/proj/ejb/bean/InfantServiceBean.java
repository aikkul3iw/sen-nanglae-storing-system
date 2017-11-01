package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Infant;
import com.proj.ejb.face.InfantService;

@Stateless
@Remote(InfantService.class)
public class InfantServiceBean implements InfantService{
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;
	
	@Override
	public void save(Infant ins) {
		this.em.persist(ins);

	}

	@Override
	public void update(Infant ins) {
		this.em.merge(ins);

	}

	@Override
	public void delete(long ins_id) {
		Infant ins = findInfantById(ins_id);
		if (ins != null) {
			em.remove(ins);
			;
		}

	}

	@Override
	public Infant findInfantById(long ins_id) {
		return this.em.find(Infant.class, ins_id);
	}

	@Override
	public List<Infant> listAllInfant() {
		List<Infant> list = em.createQuery("SELECT i FROM Infant i").getResultList();
		return list;
	}
}
