<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="jakarta.tags.core" %>
<html>
  <head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
      <jsp:param name="title" value="NEO-HUB | Contact Us" />
      <jsp:param
        name="metaDescription"
        value="Get in touch with NEO-HUB for any inquiries or support."
      />
      <jsp:param
        name="metaKeywords"
        value="IoT, Arduino, sensors, electronics, IoT kits, NEO-HUB"
      />
      <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
    </jsp:include>
  </head>

  <body>
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
      <jsp:param name="activePage" value="contact" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20 flex flex-col gap-10">
      <!-- hero section  -->
      <section
        class="bg-white border border-gray-200 rounded-2xl overflow-hidden"
      >
        <div class="flex flex-col md:flex-row items-stretch">
          <!-- lleft  -->
          <div
            class="flex-1 p-8 md:p-12 lg:p-16 text-center md:text-left"
          >
            <span
              class="inline-flex items-center gap-2 text-[11px] font-semibold tracking-widest uppercase text-accent bg-accent/5 border border-accent/20 rounded-full px-3.5 py-1 mb-5"
            >
              <span
                class="w-1.5 h-1.5 rounded-full bg-accent animate-pulse"
              ></span>
              Get in Touch
            </span>
            <h1
              class="text-3xl md:text-4xl lg:text-5xl font-bold text-accent leading-tight mb-4"
            >
              Let’s talk.<br />
              <span class="text-gray-500">We’re here to help.</span>
            </h1>
            <p
              class="text-gray-500 text-sm md:text-base max-w-md mx-auto md:mx-0 leading-relaxed mb-8"
            >
              Have a question about a product, need help with an order, or just
              want to say hello? Fill out the form or reach us directly.
            </p>
            <div
              class="flex flex-col sm:flex-row gap-3 justify-center md:justify-start"
            >
              <a
                href="${pageContext.request.contextPath}/products"
                class="inline-flex items-center gap-2 bg-accent text-white text-sm font-semibold px-6 py-2.5 rounded-xl hover:opacity-90 transition shadow-sm"
              >
                Browse Products <i class="fa-solid fa-arrow-right text-xs"></i>
              </a>
              <a
                href="${pageContext.request.contextPath}/#"
                class="inline-flex items-center gap-2 bg-white border border-gray-200 text-gray-600 text-sm font-medium px-6 py-2.5 rounded-xl hover:bg-gray-50 transition"
              >
                <i class="fa-regular fa-circle-question"></i> FAQ
              </a>
            </div>
          </div>

          <!-- right side -->
          <div
            class="flex-1 hidden md:flex items-center justify-center p-8 lg:p-12"
          >
            <div class="relative">
              <div
                class="w-40 h-40 lg:w-56 lg:h-56 rounded-full bg-accent/5 flex items-center justify-center"
              >
                <i
                  class="fa-solid fa-headset text-accent text-6xl lg:text-7xl"
                ></i>
              </div>
              <div
                class="absolute -bottom-4 -right-4 w-20 h-20 bg-white rounded-full shadow-md flex items-center justify-center border border-gray-100"
              >
                <i class="fa-regular fa-message text-accent text-2xl"></i>
              </div>
              <div
                class="absolute -top-3 -left-3 w-12 h-12 bg-accent/10 rounded-full flex items-center justify-center"
              >
                <i class="fa-regular fa-clock text-accent text-sm"></i>
              </div>
            </div>
          </div>
        </div>
      </section>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- left side contact details  -->
        <div class="flex flex-col gap-4">
          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex items-start gap-4"
          >
            <div
              class="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-location-dot text-blue-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Our Address
              </p>
              <p class="text-sm font-semibold text-accent">NEO-HUB Store</p>
              <p class="text-xs text-gray-500 leading-relaxed mt-0.5">
                Gandaki Province, Pokhara<br />Nepal
              </p>
            </div>
          </div>

          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex items-start gap-4"
          >
            <div
              class="w-10 h-10 rounded-xl bg-green-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-phone text-green-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Phone
              </p>
              <p class="text-sm font-semibold text-accent">+977 981-2345678</p>
              <p class="text-xs text-gray-500 mt-0.5">Sun – Fri, 9 AM – 6 PM</p>
            </div>
          </div>

          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex items-start gap-4"
          >
            <div
              class="w-10 h-10 rounded-xl bg-purple-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-envelope text-purple-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Email
              </p>
              <p class="text-sm font-semibold text-accent">
                neohubnepal@gmail.com
              </p>
              <p class="text-xs text-gray-500 mt-0.5">
                We reply within 24 hours
              </p>
            </div>
          </div>

          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex items-start gap-4"
          >
            <div
              class="w-10 h-10 rounded-xl bg-orange-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-clock text-orange-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Business Hours
              </p>
              <p class="text-sm font-semibold text-accent">Sunday – Friday</p>
              <p class="text-xs text-gray-500 mt-0.5">9:00 AM – 6:00 PM NPT</p>
            </div>
          </div>
        </div>

        <!-- contact form  -->
        <div
          class="md:col-span-2 bg-white border border-gray-200 rounded-2xl p-6 md:p-8"
        >
          <h2 class="text-base md:text-lg font-semibold text-[#1D1D1F] mb-1">
            Send a Message
          </h2>
          <p class="text-xs text-gray-500 mb-6">
            <c:choose>
              <c:when
                test="${not empty sessionScope.user or not empty sessionScope.user}"
              >
                Logged in as
                <span class="font-medium text-[#1D1D1F]">
                  <c:out value="${sessionScope.user.fullName}" />
                  <c:if test="${empty sessionScope.user}">
                    <c:out value="${sessionScope.user.fullName}" />
                  </c:if>
                </span>
                — fill in the form below.
              </c:when>
              <c:otherwise>
                You must be
                <a
                  href="${pageContext.request.contextPath}/login"
                  class="text-blue-500 hover:underline font-medium"
                  >logged in</a
                >
                to send a message.
              </c:otherwise>
            </c:choose>
          </p>

          <c:choose>
            <c:when
              test="${not empty sessionScope.user or not empty sessionScope.user}"
            >
              <form
                action="${pageContext.request.contextPath}/contact"
                method="post"
                class="flex flex-col gap-5"
              >
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div>
                    <label
                      class="block text-xs font-semibold uppercase text-gray-400 mb-1"
                      >Full Name</label
                    >
                    <input
                      type="text"
                      disabled
                      value="<c:out value='${sessionScope.user.fullName}'/>"
                      class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg bg-[#F5F5F7] text-gray-500 cursor-not-allowed"
                    />
                  </div>
                  <div>
                    <label
                      class="block text-xs font-semibold uppercase text-gray-400 mb-1"
                      >Email</label
                    >
                    <input
                      type="text"
                      disabled
                      value="<c:out value='${sessionScope.user.email}'/>"
                      class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg bg-[#F5F5F7] text-gray-500 cursor-not-allowed"
                    />
                  </div>
                </div>

                <div>
                  <label
                    class="block text-xs font-semibold uppercase text-gray-400 mb-1"
                  >
                    Subject <span class="text-red-400">*</span>
                  </label>
                  <input
                    type="text"
                    name="subject"
                    maxlength="200"
                    required
                    placeholder="e.g. Question about ESP32 stock"
                    value="<c:out value='${param.subject}'/>"
                    class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:border-gray-400 transition"
                  />
                </div>

                <div>
                  <label
                    class="block text-xs font-semibold uppercase text-gray-400 mb-1"
                  >
                    Message <span class="text-red-400">*</span>
                  </label>
                  <textarea
                    name="message"
                    rows="6"
                    required
                    placeholder="Write your message here..."
                    class="w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:border-gray-400 transition resize-none"
                  >
<c:out value='${param.message}'/></textarea
                  >
                </div>

                <div class="flex justify-end">
                  <button
                    type="submit"
                    class="inline-flex items-center gap-2 bg-[#1D1D1F] text-white text-sm font-semibold px-6 py-2.5 rounded-xl hover:opacity-80 transition-opacity"
                  >
                    <i class="fa-solid fa-paper-plane text-xs"></i> Send Message
                  </button>
                </div>
              </form>
            </c:when>

            <c:otherwise>
              <div
                class="flex flex-col items-center justify-center gap-4 py-16 text-center"
              >
                <div
                  class="w-14 h-14 rounded-full bg-gray-100 flex items-center justify-center"
                >
                  <i class="fa-solid fa-lock text-gray-400 text-xl"></i>
                </div>
                <p class="text-sm text-gray-500 max-w-xs leading-relaxed">
                  Please log in to your account to send us a message.
                </p>
                <a
                  href="${pageContext.request.contextPath}/login"
                  class="inline-flex items-center gap-2 bg-[#1D1D1F] text-white text-sm font-semibold px-6 py-2.5 rounded-xl hover:opacity-80 transition-opacity"
                >
                  <i class="fa-solid fa-arrow-right-to-bracket text-xs"></i>
                  Login to Continue
                </a>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />

    <script>
      <c:if test="${not empty contactError}">
          showToast("<c:out value='${contactError}'/>", "error");
      </c:if>

      // flash messages from session and remove them
      <c:if test="${not empty sessionScope.contactSuccess}">
          showToast("<c:out value='${sessionScope.contactSuccess}'/>", "success");
          <c:remove var="contactSuccess" scope="session" />
      </c:if>
    </script>
  </body>
</html>
