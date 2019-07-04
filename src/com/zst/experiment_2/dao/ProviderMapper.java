package com.zst.experiment_2.dao;

import com.zst.experiment_2.annotation.MyBatis;
import com.zst.experiment_2.entity.Provider;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@MyBatis
public interface ProviderMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Provider record);

    int insertSelective(Provider record);

    Provider selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Provider record);

    int updateByPrimaryKey(Provider record);

    List<Provider> getBillListByProviderId(@Param("id") Integer providerId);

    List<String> getProviderNames(@Param("productName")String productName);
}