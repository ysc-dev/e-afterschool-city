package com.ysc.afterschool.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.Invitation;
import com.ysc.afterschool.repository.InvitationRepository;

import reactor.core.publisher.Flux;

@Service
public class InvitationService {
	
	@Autowired
	private InvitationRepository invitationRepository;
	
	@Cacheable("invitation.getList")
	public Flux<Invitation> getList(int cityId) {
		return Flux.fromIterable(invitationRepository.findByCityIdOrderByDeadlineDateDesc(cityId));
	}

	@Cacheable("invitation.get")
	public Invitation get(int id) {
		return invitationRepository.findById(id).get();
	}
}
