package com.neospark.neohub.dao;

import com.neospark.neohub.model.Payment;

public interface PaymentDao {
    boolean createPayment(Payment payment);


    boolean updatePaymentStatus(int orderId, String status, String transactionId);
}
