package com.mini.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mini.model.User;

@Mapper
public interface TestMapper {
    // 게시판 리스트
    List<User> selectUserlist(HashMap<String, Object> map) throws Exception;
   
}
