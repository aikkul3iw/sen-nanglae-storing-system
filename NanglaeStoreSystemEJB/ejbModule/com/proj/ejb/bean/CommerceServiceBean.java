package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Commerce;
import com.proj.ejb.face.CommerceService;

@Stateless
@Remote(CommerceService.class)
public class CommerceServiceBean implements CommerceService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Commerce cm) {
		// TODO Auto-generated method stub
		this.em.persist(cm);
	}

	@Override
	public void update(Commerce cm) {
		// TODO Auto-generated method stub
		this.em.merge(cm);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Commerce cm = findCommerceById(id);
		if (cm != null) {
			em.remove(cm);
		}
	}

	@Override
	public Commerce findCommerceById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Commerce.class, id);
	}

	@Override
	public List<Commerce> listAllCommerce() {
		// TODO Auto-generated method stub
		List<Commerce> list = em.createQuery("SELECT cm FROM Commerce cm ORDER BY cm.com_year DESC").getResultList();
		return list;
	}

}
