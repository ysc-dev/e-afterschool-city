package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.repository.StudentRepository;
import com.ysc.afterschool.service.StudentService;

/**
 * 학생 관리
 * 
 * @author hgko
 *
 */
@Transactional
@Service
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentRepository studentRepository;

	@Transactional(readOnly = true)
	@Override
	public Student get(Integer id) {
		return studentRepository.findById(id).get();
	}

	@Transactional(readOnly = true)
	@Override
	public List<Student> getList() {
		return studentRepository.findAll();
	}

	@Override
	public boolean regist(Student domain) {
		if (isNew(domain)) {
			return studentRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean update(Student domain) {
		if (!isNew(domain)) {
			return studentRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Integer id) {
		studentRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Student domain) {
		return !studentRepository.existsById(domain.getId());
	}

	@Transactional(readOnly = true)
	@Override
	public boolean searchJumin(Student student) {
		return studentRepository.findByResidentNumber(student.getJumin1() + "-" + student.getJumin2()) != null;
	}

	@Transactional(readOnly = true)
	@Override
	public boolean search(Student student) {
		String tel = student.getTel();
		if (!tel.contains("-")) {
			tel = tel.substring(0, 4) + "-" + tel.substring(4, tel.length());
		}
		return studentRepository.findByNameAndTel(student.getName(), student.getService() + "-" + tel) != null;
	}

	@Transactional(readOnly = true)
	@Override
	public Student login(String name, String tel) {
		if (!tel.contains("-")) {
			tel = tel.substring(0, 3) + "-" + tel.substring(3, 7) + "-" + tel.substring(7, tel.length());
		}
		return studentRepository.findByNameAndTel(name, tel);
	}
}
