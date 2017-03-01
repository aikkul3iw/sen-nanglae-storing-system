package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Inventory;
import com.proj.ejb.face.InventoryService;

@Stateless
@Remote(InventoryService.class)
public class InventoryServiceBean implements InventoryService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Inventory inven) {
		// TODO Auto-generated method stub
		this.em.persist(inven);
	}

	@Override
	public void update(Inventory inven) {
		// TODO Auto-generated method stub
		this.em.merge(inven);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Inventory inven = findInventoryById(id);
		if (inven != null) {
			em.remove(inven);
		}
	}

	@Override
	public Inventory findInventoryById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Inventory.class, id);
	}

	@Override
	public List<Inventory> listAllInventory() {
		// TODO Auto-generated method stub
		List<Inventory> list = em.createQuery("SELECT inven FROM Inventory inven").getResultList();
		return list;
	}

}
