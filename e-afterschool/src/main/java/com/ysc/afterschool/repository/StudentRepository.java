package com.ysc.afterschool.repository;

import com.ysc.afterschool.domain.db.Student;

public interface StudentRepository extends DefaultRepository<Student, Integer> {

	Student findByResidentNumber(String number);

	Student findByNameAndTel(String name, String tel);

}
