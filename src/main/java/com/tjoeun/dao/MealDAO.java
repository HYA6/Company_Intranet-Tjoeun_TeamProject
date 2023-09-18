package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.vo.Board_MealVO;

public interface MealDAO {

	void mealinsert(Board_MealVO bmo);
	int selectMealCount();
	ArrayList<Board_MealVO> selectMealList(HashMap<String, Integer> hmap);
	Board_MealVO selectMealbyIdx(int idx);
	void mealdelete(int idx);
	ArrayList<Board_MealVO> selectMealTopList();
	void mealupdate(Board_MealVO bmo);
	
}
