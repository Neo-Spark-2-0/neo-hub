<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="jakarta.tags.core" %> <%@ taglib prefix="fmt"
uri="jakarta.tags.fmt" %> <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>

<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="${user.fullName}'s Profile" />
    <jsp:param name="metaDescription" value="Profile page on NEO-HUB. View and manage account information." />
    <jsp:param name="metaKeywords" value="profile, NEO-HUB NEO-SPARK" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
</jsp:include>


  <body class="bg-secondary font-poppins">
    <!-- importing and using header  -->
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>


    <main class="w-[90vw] mx-auto my-10 md:my-20">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="bg-primary rounded-lg w-full md:w-1/4 border border-secondary p-5 flex flex-col items-center gap-1">
          <form
            action="${pageContext.request.contextPath}/profile"
            method="post"
            id="photoForm"
          >
            <input type="hidden" name="action" value="uploadPhoto" />
            <div class="w-14 h-14 rounded-full bg-blue-50 border-2 border-secondary overflow-hidden flex items-center justify-content-center cursor-pointer hover:border-blue-400 transition-colors mb-2" onclick="document.getElementById('photoInput').click()">
              <c:choose>
                <c:when test="${not empty user.profileImage}">
                  <img src="${pageContext.request.contextPath}/${user.profileImage}" alt="Photo" class="w-full h-full object-cover"/>
                </c:when>
                <c:otherwise>
                  <span class="text-base font-semibold text-blue-500 w-full h-full flex items-center justify-center">
                   <c:out value="${fn:substring(user.fullName, 0, 3)}" />
                  </span>
                </c:otherwise>
              </c:choose>
            </div>
            <input type="file" id="photoInput" name="profilePhoto" accept="image/*" class="hidden"
            onchange="document.getElementById('photoForm').submit()"/>
          </form>
          <p class="text-sm font-semibold text-gray-800 text-center"><c:out value="${user.fullName}" /></p>
            <span class="text-xs bg-gray-100 text-gray-500 px-3 py-0.5 rounded-full mb-4">
                ${user.role eq 'ADMIN' ? 'Admin' : 'Customer'}
            </span>
            <div class="w-full h-[0.5px] bg-gray-300 my-2 mb-[30px]"></div>

            <nav class="w-full flex flex-col gap-0.5 text-sm">
              <a href="${pageContext.request.contextPath}/profile"
                   class="px-3 py-2 rounded-lg font-medium bg-gray-900 text-white">Profile</a>
              <a href="${pageContext.request.contextPath}/orders"
                   class="px-3 py-2 rounded-lg text-gray-600 hover:bg-gray-100 transition-colors">Orders</a>

            <div class="w-full h-[0.5px] bg-gray-300 my-2"></div>

              <a href="#"
                onclick="confirmLogout()"
                class="px-3 py-2 rounded-lg text-red-500 hover:bg-red-50 transition-colors">Logout</a>
            </nav>
        </div>
        <div class="w-full md:w-3/4 rounded-lg flex flex-col bg-primary gap-y-4 p-4">
            
                
          <section class="bg-white border border-gray-200 rounded-2xl p-4 md:p-6">
            <form action="${pageContext.request.contextPath}/profile"
                method="post">
                <!-- keeping these hidden inputs to retain address info during profile updates,because servlet needs these parameters too -->
                <input type="hidden" name="action"   value="updateProfile"/>
                <input type="hidden" name="province" value="<c:out value="${user.province}" />"/>
                <input type="hidden" name="district" value="<c:out value="${user.district}" />"/>
                <input type="hidden" name="city"     value="<c:out value="${user.city}" />"/>
                <input type="hidden" name="local_evel" value="<c:out value="${user.localLevel}" />"/>
                <input type="hidden" name="ward"     value="<c:out value="${user.ward}" />"/>
                <input type="hidden" name="street"   value="<c:out value="${user.street}" />"/>
                <input type="hidden" name="landmark" value="<c:out value="${user.landmark}" />"/>
            <div class="flex flex-wrap items-center gap-2 justify-between sm:my-2 my-0">
                  <h1 class="text-base md:text-lg text-accent font-semibold my-2 w-full sm:w-auto">Personal Information</h1>
                  <button type="button"
                    class="bg-black text-white px-4 py-2 text-[12px] rounded-lg hover:opacity-80 transition" 
                    id="personalEditButton"
                    onclick="enablePersonalInformationEdit()">
                    Edit
                  </button>

              <div id="personalActionButtons" class="hidden flex gap-2">
                <button type="submit"
                        class="bg-green-600 text-white px-4 py-2 text-[12px] rounded-lg hover:opacity-80 transition">
                    Save
                </button>

                <button type="button"
                        onclick="cancelPersonalInformationEdit()"
                        class="bg-gray-400 text-white px-4 py-2 text-[12px] rounded-lg hover:opacity-80 transition">
                    Cancel
                </button>
            </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-4 mt-2">
                <%-- Name --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Full name</label>
                    <p class="text-sm text-gray-800 view-mode-personal" id="view-fullName"><c:out value="${user.fullName}" /></p>
                    <input type="text" name="fullName" value="<c:out value='${user.fullName}' />" class="hidden edit-mode-personal w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition" required/>
                </div>

                <%-- Phone --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Phone</label>
                    <p class="text-sm text-gray-800 view-mode-personal">+977 <c:out value="${user.phone}" /></p>
                    <input type="text" 
                        name="phone" 
                        value="<c:out value='${user.phone}' />" 
                        required 
                        class="hidden edit-mode-personal w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition" 
                        placeholder="98XXXXXXXX" />
                </div>

                <%-- Email --%>
                <div>
                    <label class="text-xs font-semibold uppercase text-gray-400 mb-2">Email</label>
                    <p class="text-sm text-gray-800 break-all"><c:out value="${user.email}" /></p>
                </div>

                <%-- Verification Status --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-2">Verified</label>
                    <c:choose>
                        <c:when test="${user.emailVerified}">
                            <span class="text-xs bg-green-100 text-green-700 px-2.5 py-0.5 rounded-full">Verified</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-xs bg-red-100 text-red-600 px-2.5 py-0.5 rounded-full">Not verified</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
          </form>
        </section>


        <section class="bg-primary border border-gray-200 rounded-2xl p-4 md:p-6">
            <form id="address-form" action="${pageContext.request.contextPath}/profile"
              method="post">
              <div class="flex flex-wrap items-center gap-2 justify-between mb-2">
                <h1 class="text-base md:text-lg text-accent font-semibold w-full sm:w-auto">Shipping Information</h1>
                <button type="button" class="bg-black text-white px-4 py-2 text-[12px] rounded-lg"
                onclick="enableAddressEdit()" id="addressEditButton">Edit</button>

              <div id="addressActionButtons" class="hidden flex gap-2">
                <button type="submit"
                        class="bg-green-600 text-white px-4 py-2 text-xs rounded-lg">
                    Save
                </button>

                <button type="button"
                        onclick="cancelAddressEdit()"
                        class="bg-gray-400 text-white px-4 py-2 text-xs rounded-lg">
                    Cancel
                </button>
            </div>
              </div>
             


              <!-- other input field kept because servlet needs these parameters during profile update, even if user is just updating address info. otherwise those fields will be overridden with null or empty values. -->
              <input type="hidden" name="action"   value="updateProfile"/>
              <input type="hidden" name="fullName" value="${user.fullName}"/>
              <input type="hidden" name="phone"    value="${user.phone}"/>
              
              
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-4">
                <!-- province  -->
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Province</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                        <c:out value="${user.province}" default="-"/>
                    </p>
                    <select name="province" class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition">
                        <option value="">Select</option>
                        <c:forEach var="p" items="${['Koshi','Madhesh','Bagmati','Gandaki','Lumbini','Karnali','Sudurpashchim']}">
                            <option value="${p}" ${user.province eq p ? 'selected' : ''}>${p}</option>
                        </c:forEach>
                    </select>
                </div>


                <%-- district --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">District</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                        <c:out value="${user.district}" default="-"/>
                    </p>
                    <input type="text" name="district" value="<c:out value='${user.district}' />"
                    placeholder="e.g. Kaski"
                    class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition"/>
                </div>

                <!-- city  -->
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">City</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                        <c:out value="${user.city}" default="-"/>
                    </p>
                    <input
                           type="text" name="city" value="<c:out value='${user.city}' />"
                           placeholder="e.g. Pokhara"
                           class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition"/>
                </div>


                <!-- local level  -->
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Local Level</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                        <c:out value="${user.localLevel}" default="-"/>
                    </p>
                    <input
                        type="text" name="localLevel" value="<c:out value='${user.localLevel}' />"
                        placeholder="e.g. Pokhara Metropolitan City"
                        class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition"/>
                </div>

                <%-- ward --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Ward no.</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                        <c:out value="${user.ward}" default="-"/>
                    </p>
                    <input type="text" name="ward" value="<c:out value='${user.ward}' />"
                           placeholder="15"
                           class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition"/>
                </div>

                <%-- street --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Street / tole</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                        <c:out value="${user.street}" default="-"/>
                    </p>
                    <input type="text" name="street" value="<c:out value='${user.street}' />"
                           placeholder="Tole name"
                           class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition"/>
                </div>

                <%-- landmark --%>
                <div>
                    <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">Landmark</label>
                    <p class="text-sm text-gray-800 view-mode-address">
                       <c:out value="${user.landmark}" default="-"/>
                    </p>
                    <input type="text" name="landmark" 
                    value="<c:out value='${user.landmark}' />"
                    placeholder="Near hospital" class="hidden edit-mode-address w-full mt-1 px-3 py-2 text-sm border border-gray-300 rounded-lg transition"/>
                </div>
                  </div>
                </form>
            </section>

            <section class="bg-primary border border-gray-200 rounded-2xl p-4 md:p-6">
                <h1 class="text-base md:text-lg text-accent font-semibold w-full sm:w-auto my-2">Account Details</h1> 
                <div class="flex flex-wrap justify-between">
                    <div>
                    <p class="block text-xs font-semibold uppercase text-gray-400 mb-1">
                        Member since 
                    </p>
                    <p class="text-sm text-gray-800 mb-4">
                        <fmt:formatDate value="${user.createdAt}" pattern="MMMM dd, yyyy"/>
                    </p>
                </div>

                <div>
                    <p class="block text-xs font-semibold uppercase text-gray-400 mb-1">
                        Last updated on 
                    </p>
                    <p class="text-sm text-gray-800 mb-4">
                        <fmt:formatDate value="${user.updatedAt}" pattern="MMMM dd, yyyy"/>
                    </p>
                </div>

                <div>
                    <p class="block text-xs font-semibold uppercase text-gray-400 mb-1">
                       Account status
                    </p>
                    <p class="text-sm text-gray-800">
                        <c:choose>
                            <c:when test="${user.active}">
                              <span><i class="fa-solid fa-circle animate-pulse text-green-500 text-[5px]"></i></span>  Active
                            </c:when>
                            <c:otherwise>
                                <span><i class="fa-solid fa-circle animate-pulse text-red-500 text-[5px]"></i></span> Inactive
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                </div>
            </section>

            <section class="bg-red-50 border border-red-200 rounded-2xl p-4 md:p-5">
                <h1 class="text-base md:text-lg text-accent font-semibold my-2">Security Settings</h1>

                <div class="flex flex-col sm:flex-row sm:justify-between items-start md:items-center gap-4">
                  <div>
                    <button type="button" onclick="togglePassword()"
                            class="text-sm text-blue-600 hover:underline">
                        Change password →
                  </button>
                  <div id="password-section" class="hidden mt-4 pt-4 border-t border-orange-200">
                        <form action="${pageContext.request.contextPath}/profile" method="post"
                              class="flex flex-col gap-3 w-full">
                            <input type="hidden" name="action" value="changePassword"/>

                            <div>
                                <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">
                                    Current password
                                </label>
                                <input type="password" name="currentPassword" required class="w-full px-3 py-1 text-sm border border-gray-300 rounded-lg transition"/>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">
                                    New password
                                </label>
                                <input type="password" name="newPassword"  required class="w-full px-3 py-1 text-sm border border-gray-300 rounded-lg transition"/>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold uppercase text-gray-400 mb-1">
                                    Confirm password
                                </label>
                                <input type="password" name="confirmPassword" required class="w-full px-3 py-1 text-sm border border-gray-300 rounded-lg transition"/>
                            </div>

                            <div class="flex gap-2 mt-1">
                                <button type="button" onclick="togglePassword()"
                                        class="bg-gray-300 text-gray-700 px-4 py-2 text-[12px] rounded-lg hover:opacity-80 transition">
                                    Cancel
                                </button>
                                <button type="submit"
                                        class="bg-black text-white px-4 py-2 text-[12px] rounded-lg hover:opacity-80 transition">
                                    Update
                                </button>
                            </div>
                        </form>
                    </div>
                  </div>


                  <form action="${pageContext.request.contextPath}/profile" method="post" id="deleteForm" >
                    <input type="hidden" name="action" value="deleteAccount"/>
                    <button type="button"
                            onclick="confirmDelete()"
                            class="text-xs px-3 py-1.5 border border-red-400 text-red-500 bg-white rounded-lg hover:bg-red-50 transition-colors">
                        Delete account
                    </button>
                  </form>
                </div>
            </section>
        </div>
      </div>
    </main>
    <script>
        // personal information edit 
        // importing button and action buttons to toggle between them and show/hide based on edit mode
  const personalEditButton = document.querySelector("#personalEditButton");
  const personalActionButtons = document.querySelector("#personalActionButtons");

    function enablePersonalInformationEdit() {
        personalEditButton.classList.add("hidden");
        personalActionButtons.classList.remove("hidden");

        document.querySelectorAll(".view-mode-personal").forEach(el => el.classList.add("hidden"));
        document.querySelectorAll(".edit-mode-personal").forEach(el => el.classList.remove("hidden"));
    }

    function cancelPersonalInformationEdit() {
        personalEditButton.classList.remove("hidden");
        personalActionButtons.classList.add("hidden");

        document.querySelectorAll(".view-mode-personal").forEach(el => el.classList.remove("hidden"));
        document.querySelectorAll(".edit-mode-personal").forEach(el => el.classList.add("hidden"));
    }

    // address edit
    const addressEditButton = document.querySelector("#addressEditButton");
    const addressActionButtons = document.querySelector("#addressActionButtons");
    
    function enableAddressEdit() {
        addressEditButton.classList.add("hidden");
        addressActionButtons.classList.remove("hidden");

        document.querySelectorAll(".view-mode-address").forEach(el => el.classList.add("hidden"));
        document.querySelectorAll(".edit-mode-address").forEach(el => el.classList.remove("hidden"));
    }


    function cancelAddressEdit(){
        addressEditButton.classList.remove("hidden");
        addressActionButtons.classList.add("hidden");

        document.querySelectorAll(".view-mode-address").forEach(el => el.classList.remove("hidden"));
        document.querySelectorAll(".edit-mode-address").forEach(el => el.classList.add("hidden"));
    }

    //password change section toggle
    const passwordSection = document.querySelector("#password-section");
    function togglePassword() {
        passwordSection.classList.toggle("hidden");
    }


        // alert for deleting accout 
    function confirmDelete() {
        Swal.fire({
            title: "Are you sure?",
            text: "This action cannot be undone!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#ef4444",
            cancelButtonColor: "#6b7280",
            confirmButtonText: "Yes, delete it"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("deleteForm").submit();
            }
        });
    }

    // alert for logout
    function confirmLogout() {
        Swal.fire({
            title: "Logout?",
            text: "You will be logged out of your account.",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#ef4444",
            cancelButtonColor: "#6b7280",
            confirmButtonText: "Yes, logout"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/logout";
            }
        });
    }




    // success and error messages from servlet
        <c:if test="${not empty profileSuccess}">
            showToast("<c:out value='${profileSuccess}' />", "success");
        </c:if>

        <c:if test="${not empty passwordSuccess}">
            showToast("<c:out value='${passwordSuccess}' />", "success");
        </c:if>

        <c:if test="${not empty profileError}">
            showToast("<c:out value='${profileError}' />", "error");
        </c:if>

        <c:if test="${not empty passwordError}">
            showToast("<c:out value='${passwordError}' />", "error");
        </c:if>

        <c:if test="${not empty deleteError}">
            showToast("<c:out value='${deleteError}' />", "error");
        </c:if>
  </script>
  </body>
</html>
