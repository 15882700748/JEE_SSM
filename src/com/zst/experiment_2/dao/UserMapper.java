package com.zst.experiment_2.dao;

import com.zst.experiment_2.annotation.MyBatis;
import com.zst.experiment_2.entity.User;

import java.util.List;

@MyBatis
public interface UserMapper {
    int deleteByPrimaryKey(Long id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //获取用户
    List<User> selectUser(User user);
}