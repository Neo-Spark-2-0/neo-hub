package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.PromoCode;

public interface PromoCodeDao {
    boolean addPromoCode(PromoCode promoCode);

    PromoCode getPromoCodeById(int id);

    PromoCode getPromoCodeByCode(String code);

    List<PromoCode> getAllPromoCodes();

    boolean updatePromoCode(PromoCode promoCode);

    boolean updateStatus(int id, boolean isActive);

    boolean deletePromoCode(int id);
}
