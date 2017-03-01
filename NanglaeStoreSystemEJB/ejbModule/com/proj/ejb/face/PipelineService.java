package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Pipeline;

public interface PipelineService {
	public void save(Pipeline ppl);

	public void update(Pipeline ppl);

	public void delete(long id);

	public Pipeline findPipelineById(long id);

	public List<Pipeline> listAllPipeline();
}
