package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.ContactMessage;

/**
 * The interface Contact message dao.
 */
public interface ContactMessageDao {
    /**
     * Save message boolean.
     *
     * @param message the message
     * @return the boolean
     */
    boolean saveMessage(ContactMessage message);

    /**
     * Gets all messages.
     *
     * @return the all messages
     */
    List<ContactMessage> getAllMessages();
}
