package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.OrderItem;

public interface OrderItemDao {
    boolean addOrderItem(OrderItem item);
    boolean addOrderItems(List<OrderItem> items);
    List<OrderItem> getItemsByOrderId(int orderId);
}
