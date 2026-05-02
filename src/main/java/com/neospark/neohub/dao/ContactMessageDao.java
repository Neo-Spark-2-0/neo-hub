package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.ContactMessage;

public interface ContactMessageDao {
    boolean saveMessage(ContactMessage message);
    ContactMessage getMessageById(int id);
    List<ContactMessage> getAllMessages();
    boolean updateStatus(int messageId, String status);
    boolean deleteMessage(int messageId);
}
