package com.neospark.neohub.model;

import java.sql.Timestamp;

/**
 * The type User.
 */
public class User {
    // Personal Information
    private int       id;
    private String    fullName;
    private String    email;
    private String    password;
    private String    phone;

    // User Address Details
    private String    province;
    private String    district;
    private String    city;
    private String    localLevel;
    private String    ward;
    private String    street;
    private String    landmark;

    // Profile Information
    private String    profileImage;
    private String    role;
    private boolean   isActive;
    private boolean   emailVerified;


    // Other Details
    private Timestamp createdAt;
    private Timestamp updatedAt;

    /**
     * Instantiates a new User.
     */
    public User() {}

    /**
     * Instantiates a new User.
     *
     * @param fullName the full name
     * @param email    the email
     * @param phone    the phone
     * @param password the password
     */
// Constructor for New User Registration
    public User(String fullName, String email,String phone, String password) {
        this.fullName = fullName;
        this.email    = email;
        this.phone    = phone;
        this.password = password;
    }

    /**
     * Instantiates a new User.
     *
     * @param id              the id
     * @param fullName        the full name
     * @param email           the email
     * @param password        the password
     * @param phone           the phone
     * @param province        the province
     * @param district        the district
     * @param city            the city
     * @param localLevel      the local level
     * @param ward            the ward
     * @param street          the street
     * @param landmark        the landmark
     * @param profileImage    the profile image
     * @param role            the role
     * @param isActive        the is active
     * @param isEmailVerified the is email verified
     * @param createdAt       the created at
     * @param updatedAt       the updated at
     */
// Full Table Mapping Constructor
    public User(int id, String fullName, String email, String password,
                String phone, String province, String district, String city, String localLevel, String ward, String street, String landmark,
                String profileImage, String role, boolean isActive, boolean isEmailVerified,
                Timestamp createdAt, Timestamp updatedAt) {
        this.id           = id;
        this.fullName     = fullName;
        this.email        = email;
        this.password     = password;
        this.phone        = phone;
        this.province     = province;
        this.district     = district;
        this.city         = city;
        this.localLevel  = localLevel;
        this.ward         = ward;
        this.street       = street;
        this.landmark     = landmark;
        this.profileImage = profileImage;
        this.role         = role;
        this.isActive     = isActive;
        this.emailVerified = isEmailVerified;
        this.createdAt    = createdAt;
        this.updatedAt    = updatedAt;
    }


    /**
     * Gets id.
     *
     * @return the id
     */
    public int getId() {
        return id; 
    }

    /**
     * Sets id.
     *
     * @param id the id
     */
    public void setId(int id) {
        this.id = id; 
    }

    /**
     * Gets full name.
     *
     * @return the full name
     */
    public String getFullName() {
        return fullName; 
    }

    /**
     * Sets full name.
     *
     * @param fullName the full name
     */
    public void setFullName(String fullName) {
        this.fullName = fullName; 
    }

    /**
     * Gets email.
     *
     * @return the email
     */
    public String getEmail() {
        return email; 
    }

    /**
     * Sets email.
     *
     * @param email the email
     */
    public void setEmail(String email) {
        this.email = email; 
    }

    /**
     * Gets password.
     *
     * @return the password
     */
    public String getPassword() {
        return password; 
    }

    /**
     * Sets password.
     *
     * @param password the password
     */
    public void setPassword(String password) {
        this.password = password; 
    }

    /**
     * Gets phone.
     *
     * @return the phone
     */
    public String getPhone() {
        return phone; 
        }

    /**
     * Sets phone.
     *
     * @param phone the phone
     */
    public void setPhone(String phone) {
        this.phone = phone; 
    }

    /**
     * Gets province.
     *
     * @return the province
     */
    public String getProvince() {
        return province; 
    }

    /**
     * Sets province.
     *
     * @param province the province
     */
    public void setProvince(String province) {
        this.province = province; 
    }

    /**
     * Gets district.
     *
     * @return the district
     */
    public String getDistrict() {
        return district; 
    }

    /**
     * Sets district.
     *
     * @param district the district
     */
    public void setDistrict(String district) {
        this.district = district; 
    }

    /**
     * Gets city.
     *
     * @return the city
     */
    public String getCity() {
        return city; 
    }

    /**
     * Sets city.
     *
     * @param city the city
     */
    public void setCity(String city) {
        this.city = city; 
    }

    /**
     * Gets local level.
     *
     * @return the local level
     */
    public String getLocalLevel() {
        return localLevel;
    }

    /**
     * Sets local level.
     *
     * @param local_level the local level
     */
    public void setLocalLevel(String local_level) {
        this.localLevel = local_level;
    }

    /**
     * Gets ward.
     *
     * @return the ward
     */
    public String getWard() {
        return ward; 
    }

    /**
     * Sets ward.
     *
     * @param ward the ward
     */
    public void setWard(String ward) {
        this.ward = ward; 
    }

    /**
     * Gets street.
     *
     * @return the street
     */
    public String getStreet() {
        return street; 
    }

    /**
     * Sets street.
     *
     * @param street the street
     */
    public void setStreet(String street) {
        this.street = street; 
    }

    /**
     * Gets landmark.
     *
     * @return the landmark
     */
    public String getLandmark() {
        return landmark; 
    }

    /**
     * Sets landmark.
     *
     * @param landmark the landmark
     */
    public void setLandmark(String landmark) {
        this.landmark = landmark; 
    }

    /**
     * Gets profile image.
     *
     * @return the profile image
     */
    public String getProfileImage() {
        return profileImage; 
    }

    /**
     * Sets profile image.
     *
     * @param profileImage the profile image
     */
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage; 
    }

    /**
     * Gets role.
     *
     * @return the role
     */
    public String getRole() {
        return role; 
    }

    /**
     * Sets role.
     *
     * @param role the role
     */
    public void setRole(String role) {
        this.role = role; 
    }

    /**
     * Is active boolean.
     *
     * @return the boolean
     */
    public boolean isActive() {
        return isActive; 
    }

    /**
     * Sets active.
     *
     * @param active the active
     */
    public void setActive(boolean active) {
        isActive = active; 
    }

    /**
     * Gets email verified.
     *
     * @return the email verified
     */
    public boolean getEmailVerified() {
        return emailVerified;
    }

    /**
     * Sets email verified.
     *
     * @param emailVerified the email verified
     */
    public void setEmailVerified(boolean emailVerified) {
        this.emailVerified = emailVerified;
    }

    /**
     * Gets created at.
     *
     * @return the created at
     */
    public Timestamp getCreatedAt() {
        return createdAt; 
    }

    /**
     * Sets created at.
     *
     * @param createdAt the created at
     */
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    /**
     * Gets updated at.
     *
     * @return the updated at
     */
    public Timestamp getUpdatedAt() {
        return updatedAt; 
    }

    /**
     * Sets updated at.
     *
     * @param updatedAt the updated at
     */
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt; 
    }

    /**
     * Is admin boolean.
     *
     * @return the boolean
     */
//Added:check admin role
     public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(role);
        
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