package com.ysc.afterschool.service;

import com.ysc.afterschool.domain.db.Student;

public interface StudentService extends CRUDService<Student, Integer> {

	boolean searchJumin(Student student);

	boolean search(Student student);

	Student login(String name, String tel);

}
