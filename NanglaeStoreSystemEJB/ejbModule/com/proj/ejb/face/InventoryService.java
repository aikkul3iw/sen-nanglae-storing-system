package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Inventory;

public interface InventoryService {
	public void save(Inventory inven);
	public void update(Inventory inven);
	public void delete(long id);
	public Inventory findInventoryById(long id);
	public List<Inventory> listAllInventory();
	
	
}
