<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        class="relative bg-[#1D1D1F] rounded-2xl overflow-hidden px-8 py-14 md:px-16 md:py-20 flex flex-col md:flex-row items-center gap-10"
      >
        <div
          class="absolute inset-0 opacity-10"
          style="
            background-image: radial-gradient(
              circle,
              #fff 1px,
              transparent 1px
            );
            background-size: 28px 28px;
          "
        ></div>

        <div class="flex-1 relative text-center md:text-left">
          <span
            class="inline-block text-xs font-semibold uppercase tracking-widest text-gray-400 mb-4 bg-white/10 px-3 py-1 rounded-full"
          >
            Contact NEO-HUB
          </span>
          <h1
            class="text-3xl md:text-4xl font-bold text-white leading-tight mb-4"
          >
            We'd Love to<br />
            <span class="text-blue-400">Hear From You</span>
          </h1>
          <p
            class="text-gray-300 text-sm md:text-base leading-relaxed max-w-lg"
          >
            Have a question about a product, need help with an order, or just
            want to say hello? Drop us a message and we'll get back to you as
            soon as possible.
          </p>
        </div>


        <div
          class="relative w-36 h-36 md:w-48 md:h-48 bg-white/10 rounded-full border border-white/20 flex items-center justify-center"
        >
          <div
            class="w-24 h-24 md:w-32 md:h-32 bg-white/10 rounded-full border border-white/20 flex items-center justify-center"
          >
            <i
              class="fa-solid fa-envelope-open-text text-blue-400 text-4xl md:text-5xl"
            ></i>
          </div>
          <span
            class="absolute top-4 right-5 w-3 h-3 bg-blue-400 rounded-full opacity-80"
          ></span>
          <span
            class="absolute bottom-5 left-4 w-2 h-2 bg-green-400 rounded-full opacity-80"
          ></span>
          <span
            class="absolute top-1/2 right-1 w-2 h-2 bg-yellow-300 rounded-full opacity-70"
          ></span>
        </div>
      </section>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- left side contact details  -->
        <div class="flex flex-col gap-4">
          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col gap-3"
          >
            <div
              class="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-location-dot text-gray-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Our Address
              </p>
              <p class="text-sm font-semibold text-[#1D1D1F]">NEO-HUB Store</p>
              <p class="text-xs text-gray-500 leading-relaxed mt-0.5">
                Gandaki Province, Pokhara<br />Nepal
              </p>
            </div>
          </div>

          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col gap-3"
          >
            <div
              class="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-phone text-gray-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Phone
              </p>
              <p class="text-sm font-semibold text-[#1D1D1F]">
                +977 981-2345678
              </p>
              <p class="text-xs text-gray-500 mt-0.5">Sun – Fri, 9 AM – 6 PM</p>
            </div>
          </div>

          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col gap-3"
          >
            <div
              class="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-envelope text-gray-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Email
              </p>
              <p class="text-sm font-semibold text-[#1D1D1F]">
                neohubnepal@gmail.com
              </p>
              <p class="text-xs text-gray-500 mt-0.5">
                We reply within 24 hours
              </p>
            </div>
          </div>

          <div
            class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col gap-3"
          >
            <div
              class="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center flex-shrink-0"
            >
              <i class="fa-solid fa-clock text-gray-500"></i>
            </div>
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-wide text-gray-400 mb-1"
              >
                Business Hours
              </p>
              <p class="text-sm font-semibold text-[#1D1D1F]">
                Sunday – Friday
              </p>
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
                  ><c:out value='${param.message}'/></textarea>
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
