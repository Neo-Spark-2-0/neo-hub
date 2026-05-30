package com.neospark.neohub.dao;

import com.neospark.neohub.model.Payment;

/**
 * The interface Payment dao.
 */
public interface PaymentDao {
    /**
     * Create payment boolean.
     *
     * @param payment the payment
     * @return the boolean
     */
    boolean createPayment(Payment payment);


    /**
     * Update payment status boolean.
     *
     * @param orderId       the order id
     * @param status        the status
     * @param transactionId the transaction id
     * @return the boolean
     */
    boolean updatePaymentStatus(int orderId, String status, String transactionId);
}
