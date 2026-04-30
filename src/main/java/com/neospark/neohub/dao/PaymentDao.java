package com.neospark.neohub.dao;
import java.util.List;

import com.neospark.neohub.model.Payment;

public interface PaymentDao {
    boolean createPayment(Payment payment);
 
    Payment getPaymentByOrderId(int orderId);
    List<Payment> getAllPayments();
 
    boolean updatePaymentStatus(int orderId, String status, String transactionId);
}
