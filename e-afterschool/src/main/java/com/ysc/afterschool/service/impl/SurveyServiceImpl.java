package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Survey;
import com.ysc.afterschool.repository.SurveyRepository;
import com.ysc.afterschool.service.SurveyService;

/**
 * 만족도 및 설문조사 관리
 * 
 * @author hgko
 *
 */
@Transactional
@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	private SurveyRepository surveyRepository;
	
	@Transactional(readOnly = true)
	@Override
	public Survey get(Long id) {
		return surveyRepository.findById(id).get();
	}
	
	@Transactional(readOnly = true)
	@Override
	public List<Survey> getList() {
		return surveyRepository.findAll();
	}

	@Override
	public boolean regist(Survey domain) {
		
		domain.setTotalScore(domain.getValue1().getScore() + domain.getValue2().getScore()
				+ domain.getValue3().getScore() + domain.getValue4().getScore()
				+ domain.getValue5().getScore() + domain.getValue6().getScore()
				+ domain.getValue7().getScore() + domain.getValue8().getScore()
				+ domain.getValue9().getScore() + domain.getValue10().getScore()); 
		
		if (isNew(domain)) {
			return surveyRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(Survey domain) {
		
		domain.setTotalScore(domain.getValue1().getScore() + domain.getValue2().getScore()
				+ domain.getValue3().getScore() + domain.getValue4().getScore()
				+ domain.getValue5().getScore() + domain.getValue6().getScore()
				+ domain.getValue7().getScore() + domain.getValue8().getScore()
				+ domain.getValue9().getScore() + domain.getValue10().getScore()); 
		
		if (!isNew(domain)) {
			return surveyRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Long id) {
		surveyRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Survey domain) {
		return !surveyRepository.existsById(domain.getId());
	}
}
