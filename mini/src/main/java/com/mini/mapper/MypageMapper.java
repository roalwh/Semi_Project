package com.mini.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.mini.model.User;

@Mapper
public interface MypageMapper {

	// 프로필 아이디/주소 불러오기
	User selectUserInfo(HashMap<String, Object> map);
	
	//프로필 하단 정보 수정/업데이트
	void updateMyPage(HashMap<String, Object> map);
	
	//프로필 상단 업데이트
	void updateUppro(HashMap<String, Object> map);
	
	//프로필 상단(남김말/정보) 불러오기
	void selectUppro(HashMap<String, Object> map);
	 
	
}