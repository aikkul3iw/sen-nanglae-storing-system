package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.AIDSpatients;

public interface AIDSpatientsService {
	public void save(AIDSpatients AID);

	public void update(AIDSpatients AID);

	public void delete(long id);

	public AIDSpatients findAIDSpatientsById(long id);

	public List<AIDSpatients> listAllAIDSpatients();
}
