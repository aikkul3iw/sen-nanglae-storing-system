package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Industry;
import com.proj.ejb.face.IndustryService;

@Stateless
@Remote(IndustryService.class)
public class IndustryServiceBean implements IndustryService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Industry ins) {
		this.em.persist(ins);

	}

	@Override
	public void update(Industry ins) {
		this.em.merge(ins);

	}

	@Override
	public void delete(long ins_id) {
		Industry ins = findIndustryById(ins_id);
		if (ins != null) {
			em.remove(ins);
			;
		}

	}

	@Override
	public Industry findIndustryById(long ins_id) {
		return this.em.find(Industry.class, ins_id);
	}

	@Override
	public List<Industry> listAllIndustry() {
		List<Industry> list = em.createQuery("SELECT i FROM Industry i ORDER BY i.ins_year DESC").getResultList();
		return list;
	}

}
