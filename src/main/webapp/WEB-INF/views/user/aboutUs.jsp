<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
      <jsp:param name="title" value="NEO-HUB | About Us" />
      <jsp:param
        name="metaDescription"
        value="Learn more about NEO-HUB and our mission to provide the best IoT equipment and projects."
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
      <jsp:param name="activePage" value="about" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20 flex flex-col gap-10">
      <!-- hero seciton  -->
      <section
        class="relative bg-[#1D1D1F] rounded-2xl overflow-hidden px-8 py-16 md:px-16 md:py-20 flex flex-col md:flex-row items-center gap-10"
      >
        <!-- dot texture  -->
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

        <div class="relative z-10 flex-1 text-center md:text-left">
          <span
            class="inline-block text-xs font-semibold uppercase tracking-widest text-gray-400 mb-4 bg-white/10 px-3 py-1 rounded-full"
          >
            About NEO-HUB
          </span>
          <h1
            class="text-3xl md:text-5xl font-bold text-white leading-tight mb-4"
          >
            Your Gateway to<br />
            <span class="text-gray-100">IoT Innovation</span>
          </h1>
          <p
            class="text-gray-300 text-sm md:text-base leading-relaxed max-w-lg"
          >
            NEO-HUB is Nepal's dedicated marketplace for IoT components,
            development boards, and ready-made smart-device kits — built for
            makers, students, and professionals alike.
          </p>
        </div>

        <div
          class="relative w-44 h-44 md:w-56 md:h-56 bg-white/10 rounded-full border border-white/20 flex items-center justify-center"
        >
          <div
            class="w-28 h-28 md:w-36 md:h-36 bg-white/10 rounded-full border border-white/20 flex items-center justify-center"
          >
            <i
              class="fa-solid fa-microchip text-blue-400 text-5xl md:text-6xl"
            ></i>
          </div>
          <span
            class="absolute top-4 right-6 w-3 h-3 bg-blue-400 rounded-full opacity-80"
          ></span>
          <span
            class="absolute bottom-6 left-5 w-2 h-2 bg-green-400 rounded-full opacity-80"
          ></span>
          <span
            class="absolute top-1/2 right-2 w-2 h-2 bg-yellow-300 rounded-full opacity-70"
          ></span>
        </div>
      </section>


      <section class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div
          class="bg-white border border-gray-200 rounded-2xl p-6 md:p-8 flex flex-col gap-4"
        >
          <div
            class="w-10 h-10 rounded-xl bg-gray-50 flex items-center justify-center"
          >
            <i class="fa-solid fa-bullseye text-accent text-lg"></i>
          </div>
          <h2 class="text-lg font-semibold text-[#1D1D1F]">Our Mission</h2>
          <p class="text-sm text-gray-600 leading-relaxed">
            To make IoT technology accessible to everyone in Nepal — from school
            students building their first sensor project to engineers designing
            production-grade smart systems. We source quality components and
            curate beginner-friendly kits so the barrier to entry is as low as
            possible.
          </p>
        </div>

        <div
          class="bg-white border border-gray-200 rounded-2xl p-6 md:p-8 flex flex-col gap-4"
        >
          <div
            class="w-10 h-10 rounded-xl bg-gray-200 flex items-center justify-center"
          >
            <i class="fa-solid fa-eye text-accent text-lg"></i>
          </div>
          <h2 class="text-lg font-semibold text-[#1D1D1F]">Our Vision</h2>
          <p class="text-sm text-gray-600 leading-relaxed">
            A Nepal where every maker has instant access to the hardware they
            need, supported by fast delivery, transparent pricing, and a
            thriving community of builders sharing knowledge and ready-made
            project blueprints.
          </p>
        </div>
      </section>


      <section class="bg-white border border-gray-50 rounded-2xl p-6 md:p-10">
        <h2 class="text-base md:text-lg font-semibold text-[#1D1D1F] mb-6">
          What We Offer
        </h2>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <div class="flex gap-4 items-start bg-[#F5F5F7] rounded-xl p-4">
            <div
              class="w-9 h-9 rounded-lg bg-gray-50 flex items-center justify-center"
            >
              <i class="fa-solid fa-server text-gray-500 text-sm"></i>
            </div>
            <div>
              <p class="text-sm font-semibold text-[#1D1D1F] mb-1">
                Development Boards
              </p>
              <p class="text-xs text-gray-500 leading-relaxed">
                Arduino, ESP32, Raspberry Pi and more — the brains of every IoT
                project.
              </p>
            </div>
          </div>

          <div class="flex gap-4 items-start bg-[#F5F5F7] rounded-xl p-4">
            <div
              class="w-9 h-9  rounded-lg bg-gray-100 flex items-center justify-center"
            >
              <i
                class="fa-solid fa-temperature-half text-gray-500 text-sm"
              ></i>
            </div>
            <div>
              <p class="text-sm font-semibold text-[#1D1D1F] mb-1">
                Sensors &amp; Actuators
              </p>
              <p class="text-xs text-gray-500 leading-relaxed">
                Temperature, motion, light, humidity, gas, ultrasonic and dozens
                more.
              </p>
            </div>
          </div>

          <div class="flex gap-4 items-start bg-[#F5F5F7] rounded-xl p-4">
            <div
              class="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center"
            >
              <i class="fa-solid fa-wifi text-gray-500 text-sm"></i>
            </div>
            <div>
              <p class="text-sm font-semibold text-[#1D1D1F] mb-1">
                Communication Modules
              </p>
              <p class="text-xs text-gray-500 leading-relaxed">
                Wi-Fi, Bluetooth, LoRa, GPS — keep your devices connected
                everywhere.
              </p>
            </div>
          </div>

          <div class="flex gap-4 items-start bg-[#F5F5F7] rounded-xl p-4">
            <div
              class="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center"
            >
              <i class="fa-solid fa-box-open text-gray-500 text-sm"></i>
            </div>
            <div>
              <p class="text-sm font-semibold text-[#1D1D1F] mb-1">
                IoT Project Kits
              </p>
              <p class="text-xs text-gray-500 leading-relaxed">
                All-in-one curated kits with components, wiring guides, and
                sample code.
              </p>
            </div>
          </div>

          <div class="flex gap-4 items-start bg-[#F5F5F7] rounded-xl p-4">
            <div
              class="w-9 h-9  rounded-lg bg-gray-100 flex items-center justify-center"
            >
              <i class="fa-solid fa-plug text-gray-500 text-sm"></i>
            </div>
            <div>
              <p class="text-sm font-semibold text-[#1D1D1F] mb-1">
                Ready-Made Devices
              </p>
              <p class="text-xs text-gray-500 leading-relaxed">
                Pre-assembled smart devices ready to deploy straight out of the
                box.
              </p>
            </div>
          </div>

          <div class="flex gap-4 items-start bg-[#F5F5F7] rounded-xl p-4">
            <div
              class="w-9 h-9 rounded-lg bg-gray-100 flex items-center justify-center"
            >
              <i class="fa-solid fa-tags text-gray-500 text-sm"></i>
            </div>
            <div>
              <p class="text-sm font-semibold text-[#1D1D1F] mb-1">
                Exclusive Deals
              </p>
              <p class="text-xs text-gray-500 leading-relaxed">
                Reward points, promo codes, and bundle discounts that save you
                money.
              </p>
            </div>
          </div>
        </div>
      </section>


      <!-- stats  -->
      <section class="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div
          class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col items-center gap-1 text-center"
        >
          <span class="text-3xl font-bold text-[#1D1D1F]"
            >500<span class="text-gray-500">+</span></span
          >
          <span
            class="text-xs text-gray-500 font-medium uppercase tracking-wide mt-1"
            >Products</span
          >
        </div>

        <div
          class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col items-center gap-1 text-center"
        >
          <span class="text-3xl font-bold text-[#1D1D1F]"
            >2<span class="text-gray-500">k+</span></span
          >
          <span
            class="text-xs text-gray-500 font-medium uppercase tracking-wide mt-1"
            >Happy Customers</span
          >
        </div>

        <div
          class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col items-center gap-1 text-center"
        >
          <span class="text-3xl font-bold text-[#1D1D1F]">7</span>
          <span
            class="text-xs text-gray-500 font-medium uppercase tracking-wide mt-1"
            >Provinces Served</span
          >
        </div>

        <div
          class="bg-white border border-gray-200 rounded-2xl p-6 flex flex-col items-center gap-1 text-center"
        >
          <span class="text-3xl font-bold text-[#1D1D1F]"
            >24<span class="text-gray-500">h</span></span
          >
          <span
            class="text-xs text-gray-500 font-medium uppercase tracking-wide mt-1"
            >Order Processing</span
          >
        </div>
      </section>



      <!-- made using  -->
      <section class="bg-white border border-gray-200 rounded-2xl p-6 md:p-10">
        <h2 class="text-base md:text-lg font-semibold text-[#1D1D1F] mb-1">
          Built With
        </h2>
        <p class="text-xs text-gray-500 mb-6">
          NEO-HUB is powered by a solid, battle-tested Java web stack.
        </p>

        <div class="flex flex-wrap gap-3">
          <span
            class="flex items-center gap-2 bg-[#F5F5F7] text-xs font-medium text-gray-700 px-4 py-2 rounded-full border border-gray-200"
          >
            <i class="fa-brands fa-java text-gray-500"></i> Java &amp; Servlets
          </span>
          <span
            class="flex items-center gap-2 bg-[#F5F5F7] text-xs font-medium text-gray-700 px-4 py-2 rounded-full border border-gray-200"
          >
            <i class="fa-solid fa-file-code text-gray-500"></i> JSP
          </span>
          <span
            class="flex items-center gap-2 bg-[#F5F5F7] text-xs font-medium text-gray-700 px-4 py-2 rounded-full border border-gray-200"
          >
            <i class="fa-solid fa-database text-gray-500"></i> MySQL
          </span>
          <span
            class="flex items-center gap-2 bg-[#F5F5F7] text-xs font-medium text-gray-700 px-4 py-2 rounded-full border border-gray-200"
          >
            <i class="fa-brands fa-css3-alt text-gray-500"></i> Tailwind CSS
          </span>
          <span
            class="flex items-center gap-2 bg-[#F5F5F7] text-xs font-medium text-gray-700 px-4 py-2 rounded-full border border-gray-200"
          >
            <i class="fa-solid fa-chart-pie text-gray-500"></i> Chart.js
          </span>
          <span
            class="flex items-center gap-2 bg-[#F5F5F7] text-xs font-medium text-gray-700 px-4 py-2 rounded-full border border-gray-200"
          >
            <i class="fa-solid fa-wallet text-gray-500"></i> Khalti API
          </span>
        </div>
      </section>


      <!-- team details  -->
      <section
        class="bg-[#1D1D1F] rounded-2xl px-8 py-12 md:px-16 md:py-14 flex flex-col md:flex-row items-center justify-between gap-8"
      >
        <div>
          <h2 class="text-xl md:text-2xl font-bold text-white mb-2">
            Made by NEO-SPARK Team
          </h2>
          <p class="text-gray-400 text-sm leading-relaxed max-w-md">
            We are a passionate team of developers and electronics enthusiasts
            building tools that help Nepali makers bring their ideas to life.
          </p>
        </div>
        <a
          href="${pageContext.request.contextPath}/products"
          class="flex items-center gap-2 bg-white text-[#1D1D1F] text-sm font-semibold px-6 py-3 rounded-xl hover:opacity-90 transition-opacity"
        >
          <i class="fa-solid fa-arrow-right text-gray-500"></i>
          Explore Products
        </a>
      </section>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
  </body>
</html>
