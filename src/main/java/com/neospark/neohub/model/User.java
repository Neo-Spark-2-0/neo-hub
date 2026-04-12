package com.neospark.neohub.model;

import java.sql.Timestamp;

public class User {
    // Personal Information
    private int       id;
    private String    fullName;
    private String    email;
    private String    password;
    private String    phone;

    // User Address
    private String    province;
    private String    district;
    private String    city;
    private String    ward;
    private String    street;
    private String    landmark;

    // Profile Information
    private String    profileImage;
    private String    role;
    private boolean   isActive;

    // Other Details
    private Timestamp createdAt;
    private Timestamp updatedAt;


    // Constructor for New User Registration
    public User(String fullName, String email, String password) {
        this.fullName = fullName;
        this.email    = email;
        this.password = password;
    }

    // Full Table Mapping Constructor
    public User(int id, String fullName, String email, String password,
                String phone, String province, String district, String city,
                String ward, String street, String landmark,
                String profileImage, String role, boolean isActive,
                Timestamp createdAt, Timestamp updatedAt) {
        this.id           = id;
        this.fullName     = fullName;
        this.email        = email;
        this.password     = password;
        this.phone        = phone;
        this.province     = province;
        this.district     = district;
        this.city         = city;
        this.ward         = ward;
        this.street       = street;
        this.landmark     = landmark;
        this.profileImage = profileImage;
        this.role         = role;
        this.isActive     = isActive;
        this.createdAt    = createdAt;
        this.updatedAt    = updatedAt;
    }


    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public String getFullName() { 
        return fullName; 
    }
    public void setFullName(String fullName) { 
        this.fullName = fullName; 
    }

    public String getEmail() { 
        return email; 
    }
    public void setEmail(String email) { 
        this.email = email; 
    }

    public String getPassword() { 
        return password; 
    }
    public void setPassword(String password) { 
        this.password = password; 
    }

    public String getPhone() {
        return phone; 
        }
    public void setPhone(String phone) { 
        this.phone = phone; 
    }

    public String getProvince() { 
        return province; 
    }
    public void setProvince(String province) { 
        this.province = province; 
    }

    public String getDistrict() { 
        return district; 
    }
    public void setDistrict(String district) { 
        this.district = district; 
    }

    public String getCity() { 
        return city; 
    }
    public void setCity(String city) { 
        this.city = city; 
    }

    public String getWard() { 
        return ward; 
    }
    public void setWard(String ward) { 
        this.ward = ward; 
    }

    public String getStreet() { 
        return street; 
    }
    public void setStreet(String street) { 
        this.street = street; 
    }

    public String getLandmark() { 
        return landmark; 
    }
    public void setLandmark(String landmark) { 
        this.landmark = landmark; 
    }

    public String getProfileImage() { 
        return profileImage; 
    }
    public void setProfileImage(String profileImage) { 
        this.profileImage = profileImage; 
    }

    public String getRole() { 
        return role; 
    }
    public void setRole(String role) { 
        this.role = role; 
    }

    public boolean isActive() { 
        return isActive; 
    }
    public void setActive(boolean active) { 
        isActive = active; 
    }

    public Timestamp getCreatedAt() { 
        return createdAt; 
    }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { 
        return updatedAt; 
    }
    public void setUpdatedAt(Timestamp updatedAt) { 
        this.updatedAt = updatedAt; 
    }

    @Override
    public String toString() {
        return "User Information {" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + province + ", " + district + ", " + city + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}