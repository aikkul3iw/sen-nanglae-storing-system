package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Pipeline;
import com.proj.ejb.face.PipelineService;

@Stateless
@Remote(PipelineService.class)
public class PipelineServiceBean implements PipelineService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Pipeline ppl) {
		// TODO Auto-generated method stub
		this.em.persist(ppl);
	}

	@Override
	public void update(Pipeline ppl) {
		// TODO Auto-generated method stub
		this.em.merge(ppl);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Pipeline ppl = findPipelineById(id);
		if (ppl != null) {
			em.remove(ppl);
		}
	}

	@Override
	public Pipeline findPipelineById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Pipeline.class, id);
	}

	@Override
	public List<Pipeline> listAllPipeline() {
		// TODO Auto-generated method stub
		List<Pipeline> list = em.createQuery("SELECT ppl FROM Pipeline ppl ORDER BY ppl.location.vil_number").getResultList();
		return list;
	}

}
