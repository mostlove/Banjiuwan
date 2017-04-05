package com.magicbeans.banjiuwan.mapper;

import com.magicbeans.banjiuwan.beans.AgreementText;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */
public interface IAgreementTextMapper {


    Integer updateAgreementText(@Param("agreementText") AgreementText agreementText);


    List<AgreementText> queryAgreementTextList();


    AgreementText queryAgreementTextById(@Param("id") Integer id);
}
