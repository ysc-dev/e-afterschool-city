package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.Invitation;
import com.ysc.afterschool.repository.InvitationRepository;

@Service
public class InvitationService {
	
	@Autowired
	private InvitationRepository invitationRepository;
	
	public List<Invitation> getList() {
		return invitationRepository.findAll();
	}

	public List<Invitation> getList(int cityId) {
		return invitationRepository.findByCityId(cityId);
	}
}
