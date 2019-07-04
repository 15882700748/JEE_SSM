package com.zst.experiment_2.dao;

import com.zst.experiment_2.annotation.MyBatis;
import com.zst.experiment_2.entity.Bill;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@MyBatis
public interface BillMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Bill record);

    int insertSelective(Bill record);

    Bill selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Bill record);

    int updateByPrimaryKey(Bill record);

    List<Bill> getBillList(@Param("productName")String productName,@Param("proName")String proName,@Param("isPayment")Integer isPayment);

    int updateBill(Bill bill);
    int addBill(Bill bill);
}