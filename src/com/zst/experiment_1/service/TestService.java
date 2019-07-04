package com.zst.experiment_1.service;

import com.zst.experiment_1.dao.TestDao;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
public class TestService implements TestServiceDao{

    @Resource
    private TestDao testDao;
    @Override
    public void save() {
        testDao.save();
        System.out.println("testService save");
    }
}
