package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.Cart;

/**
 * The interface Cart dao.
 */
public interface CartDao {
    /**
     * Add to cart boolean.
     *
     * @param cart the cart
     * @return the boolean
     */
    boolean addToCart(Cart cart);

    /**
     * Update quantity boolean.
     *
     * @param userId    the user id
     * @param productId the product id
     * @param quantity  the quantity
     * @return the boolean
     */
    boolean updateQuantity(int userId, int productId, int quantity);

    /**
     * Gets cart by user.
     *
     * @param userId the user id
     * @return the cart by user
     */
    List<Cart> getCartByUser(int userId);

    /**
     * Remove from cart boolean.
     *
     * @param userId    the user id
     * @param productId the product id
     * @return the boolean
     */
    boolean removeFromCart(int userId, int productId);

    /**
     * Clear cart boolean.
     *
     * @param userId the user id
     * @return the boolean
     */
    boolean clearCart(int userId);

    /**
     * Gets cart quantity.
     *
     * @param userId    the user id
     * @param productId the product id
     * @return the cart quantity
     */
    int getCartQuantity(int userId, int productId);
}
