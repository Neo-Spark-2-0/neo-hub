package com.neospark.neohub.dao;

import java.util.List;

import com.neospark.neohub.model.ContactMessage;

public interface ContactMessageDao {
    boolean saveMessage(ContactMessage message);

    List<ContactMessage> getAllMessages();
}
