package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.OrderItem;

/**
 * The interface Order item dao.
 */
public interface OrderItemDao {
    /**
     * Add order item boolean.
     *
     * @param item the item
     * @return the boolean
     */
    boolean addOrderItem(OrderItem item);

    /**
     * Add order items boolean.
     *
     * @param items the items
     * @return the boolean
     */
    boolean addOrderItems(List<OrderItem> items);

    /**
     * Gets items by order id.
     *
     * @param orderId the order id
     * @return the items by order id
     */
    List<OrderItem> getItemsByOrderId(int orderId);
}
