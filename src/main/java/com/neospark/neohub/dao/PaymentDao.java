<<<<<<< HEAD
package com.neospark.neohub.dao;
=======

>>>>>>> 4f7aa674cb1581259ff33c42c79259d35283c3b6
import java.util.List;

import com.neospark.neohub.model.Payment;

public interface PaymentDao {
    boolean createPayment(Payment payment);
 
    Payment getPaymentByOrderId(int orderId);
    List<Payment> getAllPayments();
 
    boolean updatePaymentStatus(int orderId, String status, String transactionId);
}
