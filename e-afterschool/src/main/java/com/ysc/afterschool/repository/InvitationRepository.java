package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.Invitation;

public interface InvitationRepository extends DefaultRepository<Invitation, Integer> {

	List<Invitation> findByCityId(int cityId);

}
