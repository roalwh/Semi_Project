package com.mini.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mini.mapper.CommunityMapper;
import com.mini.model.Cbrd;
import com.mini.model.Cmre;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	CommunityMapper communityMapper;
	
	//커뮤니티 게시판 목록
	@Override
	public HashMap<String, Object> searchCbrdList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cnt", communityMapper.selectCbrdListCnt(map));
		resultMap.put("list", communityMapper.selectCbrdList(map));
		return resultMap;
	}
	
	//카테고리 전체 리스트
		@Override
		public HashMap<String, Object> searchCbrdCateList(HashMap<String, Object> map) {
			HashMap<String,Object> resultMap = new HashMap<String,Object>();
			resultMap.put("listcate", communityMapper.selectCbrdListcate(map));
			resultMap.put("listcate1", communityMapper.selectCbrdListcate1(map));
			resultMap.put("listcate2", communityMapper.selectCbrdListcate2(map));
			return resultMap;
		
		}
	
	//카테고리 리스트 1
	@Override
	public HashMap<String, Object> searchCbrdCate1List(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("listcate1", communityMapper.selectCbrdListcate1(map));
		return resultMap;
	
	}
	
	//카테고리 리스트 2
	@Override
	public HashMap<String, Object> searchCbrdCate2List(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("listcate2", communityMapper.selectCbrdListcate2(map));
		return resultMap;
	}

	//게시글 추가
	@Override
	public void addCbrd(HashMap<String, Object> map) {
		communityMapper.insertCbrd(map);
	}
	
	//게시글 이미지 등록
	public void CommImgInsert(HashMap<String, Object> map){
		communityMapper.CommImgAdd(map);
	}
	
	//게시글 삭제
	@Override
	public void removeCbrd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		communityMapper.deleteCbrd(map);
	}
	
	//게시글 상세
	@Override
	public HashMap<String, Object> searchCbrd(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Cbrd cbrd = communityMapper.getCbrd(map);
		List<Cmre> commentList = communityMapper.selectCommentList(map);
		
		if(cbrd != null) {
			communityMapper.updateCbrdCnt(map);
		}
		resultMap.put("info", cbrd);
		resultMap.put("commentList", commentList);
		return resultMap;
	}
	
	//게시글 수정
	@Override
	public void editCbrd(HashMap<String, Object> map) {
		communityMapper.updateCbrd(map);
	}
	
	//게시글 댓글 리스트
	@Override
	public HashMap<String, Object> selectCommentList(HashMap<String, Object> map) {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("commlist", communityMapper.selectCommentList(map));
		resultMap.put("ccnt", communityMapper.selectsumcnt(map));
		return resultMap;
	}

	@Override
	public void addCbrdComment(HashMap<String, Object> map) {
		communityMapper.insertCbrdComment(map);
	}

	@Override
	public void removeComment(HashMap<String, Object> map) {
		communityMapper.deleteComment(map);
	}

	@Override
	public void editComment(HashMap<String, Object> map) {
		communityMapper.updateComment(map);
	}

	



}
