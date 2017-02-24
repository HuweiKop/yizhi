package com.ideabinder.test.activemq_test.test;

public class UserService {

	public UserDb getUserById(Integer id){
		System.out.println("invoke getUserById:"+id);
		UserDb user = new UserDb();
		user.setId(id);
		user.setName("user1");
		return user;
	}
}
