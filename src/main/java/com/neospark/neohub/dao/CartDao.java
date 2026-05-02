package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.Cart;

public interface CartDao {
    boolean addToCart(Cart cart);
    boolean updateQuantity(int userId, int productId, int quantity);
    List<Cart> getCartByUser(int userId);
    int getCartItemCount(int userId);
    boolean removeFromCart(int userId, int productId);
    boolean clearCart(int userId);
}
