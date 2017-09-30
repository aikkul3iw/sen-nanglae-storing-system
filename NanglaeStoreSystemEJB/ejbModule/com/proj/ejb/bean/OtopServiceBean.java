package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Otop;
import com.proj.ejb.face.OtopService;

@Stateless
@Remote(OtopService.class)
public class OtopServiceBean implements OtopService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Otop otop) {
		// TODO Auto-generated method stub
		this.em.persist(otop);
	}

	@Override
	public void update(Otop otop) {
		// TODO Auto-generated method stub
		this.em.merge(otop);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Otop otop = findOtopById(id);
		if (otop != null) {
			em.remove(otop);
		}
	}

	@Override
	public Otop findOtopById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Otop.class, id);
	}

	@Override
	public List<Otop> listAllOtop() {
		// TODO Auto-generated method stub
		List<Otop> list = em.createQuery("SELECT otop FROM Otop otop").getResultList();
		return list;
	}

}
