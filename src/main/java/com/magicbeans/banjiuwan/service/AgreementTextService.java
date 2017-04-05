package com.magicbeans.banjiuwan.service;

import com.magicbeans.banjiuwan.beans.AgreementText;
import com.magicbeans.banjiuwan.mapper.IAgreementTextMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Eric Xie on 2017/3/24 0024.
 */
@Service
public class AgreementTextService {

    @Resource
    private IAgreementTextMapper agreementTextMapper;

    public void updateAgreementText( AgreementText agreementText){
        agreementTextMapper.updateAgreementText(agreementText);
    }


    public List<AgreementText> queryAgreementTextList(){
        return agreementTextMapper.queryAgreementTextList();
    }


    public  AgreementText queryAgreementTextById(Integer id){
        return agreementTextMapper.queryAgreementTextById(id);
    }


}
