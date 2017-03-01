package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Commerce;

public interface CommerceService {
	public void save(Commerce cm);

	public void update(Commerce cm);

	public void delete(long id);

	public Commerce findCommerceById(long id);

	public List<Commerce> listAllCommerce();
}
