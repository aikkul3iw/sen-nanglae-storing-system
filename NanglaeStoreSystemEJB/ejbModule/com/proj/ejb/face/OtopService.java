package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Otop;

public interface OtopService {
	public void save(Otop otop);

	public void update(Otop otop);

	public void delete(long id);

	public Otop findOtopById(long id);

	public List<Otop> listAllOtop();
}
