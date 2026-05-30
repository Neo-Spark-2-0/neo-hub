package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.PromoCode;

/**
 * The interface Promo code dao.
 */
public interface PromoCodeDao {
    /**
     * Add promo code boolean.
     *
     * @param promoCode the promo code
     * @return the boolean
     */
    boolean addPromoCode(PromoCode promoCode);

    /**
     * Gets promo code by id.
     *
     * @param id the id
     * @return the promo code by id
     */
    PromoCode getPromoCodeById(int id);

    /**
     * Gets promo code by code.
     *
     * @param code the code
     * @return the promo code by code
     */
    PromoCode getPromoCodeByCode(String code);

    /**
     * Gets all promo codes.
     *
     * @return the all promo codes
     */
    List<PromoCode> getAllPromoCodes();

    /**
     * Update promo code boolean.
     *
     * @param promoCode the promo code
     * @return the boolean
     */
    boolean updatePromoCode(PromoCode promoCode);

    /**
     * Update status boolean.
     *
     * @param id       the id
     * @param isActive the is active
     * @return the boolean
     */
    boolean updateStatus(int id, boolean isActive);

    /**
     * Delete promo code boolean.
     *
     * @param id the id
     * @return the boolean
     */
    boolean deletePromoCode(int id);
}
