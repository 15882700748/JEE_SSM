package com.zst.experiment_1.dao;

import org.springframework.stereotype.Repository;

@Repository
public class TestDaoImpl implements TestDao {
    @Override
    public void save() {
        System.out.println("testDao save");
    }

    @Override
    public void modify() {
        System.out.println("testDao modify");
    }

    @Override
    public void delete() {
        System.out.println("testDao delete");
    }
}
