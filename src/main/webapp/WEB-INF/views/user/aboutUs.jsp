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

  <body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
      <jsp:param name="activePage" value="about" />
    </jsp:include>

    <main class="flex flex-col gap-0">
      <!-- hero section  -->
      <section class="w-[90vw] mx-auto pt-12 pb-0">
        <div class="text-center mb-10">
          <h1
            class="text-4xl sm:text-5xl md:text-[52px] font-extrabold text-accent leading-[1.1] tracking-tight mb-4"
          >
            Built by Makers,<br />
            <span class="text-gray-400">for Makers</span>
          </h1>
          <p
            class="text-gray-500 text-sm sm:text-base max-w-xl mx-auto leading-relaxed"
          >
            NEO-HUB is Nepal's dedicated marketplace for IoT components,
            development boards, and ready-made smart-device kits — built for
            students, hobbyists, and professionals.
          </p>
        </div>

        <!-- photo section  -->
        <div
          class="relative w-full rounded-3xl overflow-hidden border border-gray-200 bg-gray-100"
          style="height: 420px"
        >
          <img
            src="${pageContext.request.contextPath}/static/images/group-photo.jpg"
            alt="NEO-SPARK team"
            class="w-full h-full object-cover object-top"
          />

          <!-- float bar  -->
          <div
            class="absolute bottom-0 left-0 right-0 px-8 py-7 flex flex-col sm:flex-row items-start sm:items-end justify-between gap-4"
          >
            <div>
              <p class="text-white font-extrabold text-xl leading-tight">
                NEO-SPARK Team
              </p>
              <p class="text-white/60 text-xs mt-1">
                Pokhara, Nepal . 6 Members
              </p>
            </div>
          </div>
        </div>
      </section>

      <!-- mission  -->
      <section class="w-[90vw] mx-auto py-14">
        <div class="mb-8">
          <p
            class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
          >
            Who We Are
          </p>
          <h2 class="text-2xl md:text-3xl font-bold text-accent">
            Mission & Vision
          </h2>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 md:p-8 flex flex-col gap-4"
          >
            <div
              class="w-10 h-10 rounded-xl bg-accent flex items-center justify-center"
            >
              <i class="fa-solid fa-bullseye text-white text-sm"></i>
            </div>
            <h3 class="text-base font-bold text-accent">Our Mission</h3>
            <p class="text-sm text-gray-500 leading-relaxed">
              To make IoT technology accessible to everyone in Nepal — from
              school students building their first sensor project to engineers
              designing production-grade smart systems. We source quality
              components and curate beginner-friendly kits so the barrier to
              entry is as low as possible.
            </p>
          </div>
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 md:p-8 flex flex-col gap-4"
          >
            <div
              class="w-10 h-10 rounded-xl bg-accent flex items-center justify-center"
            >
              <i class="fa-solid fa-eye text-white text-sm"></i>
            </div>
            <h3 class="text-base font-bold text-accent">Our Vision</h3>
            <p class="text-sm text-gray-500 leading-relaxed">
              A Nepal where every maker has instant access to the hardware they
              need, supported by fast delivery, transparent pricing, and a
              thriving community of builders sharing knowledge and ready-made
              project blueprints.
            </p>
          </div>
        </div>
      </section>

      <!-- what we offer -->
      <section class="bg-primary border-y border-gray-100">
        <div class="w-[90vw] mx-auto py-14">
          <div class="flex items-center justify-between mb-8">
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
              >
                Catalogue
              </p>
              <h2 class="text-2xl md:text-3xl font-bold text-accent">
                What We Offer
              </h2>
            </div>
            <a
              href="${pageContext.request.contextPath}/products"
              class="text-sm text-gray-500 hover:text-accent transition hidden sm:flex items-center gap-1"
            >
              Shop now <i class="fa-solid fa-arrow-right text-xs"></i>
            </a>
          </div>
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            <div
              class="bg-secondary border border-gray-100 rounded-2xl p-5 flex gap-4 items-start"
            >
              <div
                class="w-10 h-10 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0"
              >
                <i class="fa-solid fa-server text-blue-500 text-sm"></i>
              </div>
              <div>
                <p class="text-sm font-semibold text-accent mb-1">
                  Development Boards
                </p>
                <p class="text-xs text-gray-500 leading-relaxed">
                  Arduino, ESP32, Raspberry Pi and more — the brains of every
                  IoT project.
                </p>
              </div>
            </div>

            <div
              class="bg-secondary border border-gray-100 rounded-2xl p-5 flex gap-4 items-start"
            >
              <div
                class="w-10 h-10 rounded-xl bg-orange-50 flex items-center justify-center flex-shrink-0"
              >
                <i
                  class="fa-solid fa-temperature-half text-orange-500 text-sm"
                ></i>
              </div>
              <div>
                <p class="text-sm font-semibold text-accent mb-1">
                  Sensors & Actuators
                </p>
                <p class="text-xs text-gray-500 leading-relaxed">
                  Temperature, motion, light, humidity, gas, ultrasonic and
                  dozens more.
                </p>
              </div>
            </div>

            <div
              class="bg-secondary border border-gray-100 rounded-2xl p-5 flex gap-4 items-start"
            >
              <div
                class="w-10 h-10 rounded-xl bg-cyan-50 flex items-center justify-center flex-shrink-0"
              >
                <i class="fa-solid fa-wifi text-cyan-500 text-sm"></i>
              </div>
              <div>
                <p class="text-sm font-semibold text-accent mb-1">
                  Communication Modules
                </p>
                <p class="text-xs text-gray-500 leading-relaxed">
                  Wi-Fi, Bluetooth, LoRa, GPS — keep your devices connected
                  everywhere.
                </p>
              </div>
            </div>

            <div
              class="bg-secondary border border-gray-100 rounded-2xl p-5 flex gap-4 items-start"
            >
              <div
                class="w-10 h-10 rounded-xl bg-green-50 flex items-center justify-center flex-shrink-0"
              >
                <i class="fa-solid fa-box-open text-green-500 text-sm"></i>
              </div>
              <div>
                <p class="text-sm font-semibold text-accent mb-1">
                  IoT Project Kits
                </p>
                <p class="text-xs text-gray-500 leading-relaxed">
                  All-in-one curated kits with components, wiring guides, and
                  sample code.
                </p>
              </div>
            </div>

            <div
              class="bg-secondary border border-gray-100 rounded-2xl p-5 flex gap-4 items-start"
            >
              <div
                class="w-10 h-10 rounded-xl bg-purple-50 flex items-center justify-center flex-shrink-0"
              >
                <i class="fa-solid fa-plug text-purple-500 text-sm"></i>
              </div>
              <div>
                <p class="text-sm font-semibold text-accent mb-1">
                  Ready-Made Devices
                </p>
                <p class="text-xs text-gray-500 leading-relaxed">
                  Pre-assembled smart devices ready to deploy straight out of
                  the box.
                </p>
              </div>
            </div>

            <div
              class="bg-secondary border border-gray-100 rounded-2xl p-5 flex gap-4 items-start"
            >
              <div
                class="w-10 h-10 rounded-xl bg-yellow-50 flex items-center justify-center flex-shrink-0"
              >
                <i class="fa-solid fa-tags text-yellow-500 text-sm"></i>
              </div>
              <div>
                <p class="text-sm font-semibold text-accent mb-1">
                  Exclusive Deals
                </p>
                <p class="text-xs text-gray-500 leading-relaxed">
                  Reward points, promo codes, and bundle discounts that save you
                  money.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- team members -->
      <section class="w-[90vw] mx-auto py-14">
        <div class="mb-10">
          <p
            class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
          >
            The People
          </p>
          <h2 class="text-2xl md:text-3xl font-bold text-accent">
            Meet the NEO-SPARK Team
          </h2>
          <p class="text-sm text-gray-500 mt-2 max-w-lg">
            A passionate group of developers and electronics enthusiasts
            building tools that help Nepali makers bring their ideas to life.
          </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          <!-- Aviyan Thapa -->
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 flex flex-col gap-4 hover:shadow-md hover:border-gray-300 transition-all duration-200"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-12 h-12 rounded-xl bg-accent flex items-center justify-center flex-shrink-0"
              >
                <span class="text-white font-extrabold text-base">AT</span>
              </div>
              <div>
                <p class="text-sm font-bold text-accent leading-tight">
                  Aviyan Thapa
                </p>
                <span
                  class="inline-block text-[10px] font-semibold uppercase tracking-wide bg-blue-50 text-blue-600 px-2 py-0.5 rounded-full mt-0.5"
                  >Front End Developer</span
                >
              </div>
            </div>
            <div class="w-full h-px bg-gray-100"></div>
            <div class="flex flex-col gap-2">
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-code text-blue-500 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500">Java . JSP · MySQL</span>
              </div>
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-envelope text-red-400 text-xs w-4 text-center"
                ></i>
                <a
                  href="mailto:thrashedgamer8@gmail.com"
                  class="text-xs text-accent hover:underline truncate"
                  >thrashedgamer8@gmail.com</a
                >
              </div>
            </div>
          </div>

          <!-- Bibek Poudel -->
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 flex flex-col gap-4 hover:shadow-md hover:border-gray-300 transition-all duration-200"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-12 h-12 rounded-xl bg-accent flex items-center justify-center flex-shrink-0"
              >
                <span class="text-white font-extrabold text-base">BP</span>
              </div>
              <div>
                <p class="text-sm font-bold text-accent leading-tight">
                  Bibek Poudel
                </p>
                <span
                  class="inline-block text-[10px] font-semibold uppercase tracking-wide bg-blue-50 text-blue-600 px-2 py-0.5 rounded-full mt-0.5"
                  >Senior Full Stack Developer</span
                >
              </div>
            </div>
            <div class="w-full h-px bg-gray-100"></div>
            <div class="flex flex-col gap-2">
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-code text-blue-500 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500">Java . JSP · MySQL</span>
              </div>
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-envelope text-red-400 text-xs w-4 text-center"
                ></i>
                <a
                  href="mailto:bibekpoudel855@gmail.com"
                  class="text-xs text-accent hover:underline truncate"
                  >bibekpoudel855@gmail.com</a
                >
              </div>
            </div>
          </div>

          <!-- Mamata Timilsina -->
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 flex flex-col gap-4 hover:shadow-md hover:border-gray-300 transition-all duration-200"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-12 h-12 rounded-xl bg-accent flex items-center justify-center flex-shrink-0"
              >
                <span class="text-white font-extrabold text-base">MT</span>
              </div>
              <div>
                <p class="text-sm font-bold text-accent leading-tight">
                  Mamata Timilsina
                </p>
                <span
                  class="inline-block text-[10px] font-semibold uppercase tracking-wide bg-blue-50 text-blue-600 px-2 py-0.5 rounded-full mt-0.5"
                  >Database Designer</span
                >
              </div>
            </div>
            <div class="w-full h-px bg-gray-100"></div>
            <div class="flex flex-col gap-2">
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-code text-blue-500 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500">Java . JSP · MySQL</span>
              </div>
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-envelope text-red-400 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500"
                  >mamatimilsina8@gmail.com</span
                >
              </div>
            </div>
          </div>

          <!-- Parbin Shrees -->
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 flex flex-col gap-4 hover:shadow-md hover:border-gray-300 transition-all duration-200"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-12 h-12 rounded-xl bg-accent flex items-center justify-center flex-shrink-0"
              >
                <span class="text-white font-extrabold text-base">PS</span>
              </div>
              <div>
                <p class="text-sm font-bold text-accent leading-tight">
                  Parbin Shrees
                </p>
                <span
                  class="inline-block text-[10px] font-semibold uppercase tracking-wide bg-pink-50 text-pink-600 px-2 py-0.5 rounded-full mt-0.5"
                  >UI/UX Designer</span
                >
              </div>
            </div>
            <div class="w-full h-px bg-gray-100"></div>
            <div class="flex flex-col gap-2">
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-code text-blue-500 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500">Java . JSP · MySQL</span>
              </div>
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-envelope text-red-400 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500"
                  >parbinshreesh64487@gmail.com</span
                >
              </div>
            </div>
          </div>

          <!-- Subodh Man Singh Bhandari -->
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 flex flex-col gap-4 hover:shadow-md hover:border-gray-300 transition-all duration-200"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-12 h-12 rounded-xl bg-accent flex items-center justify-center flex-shrink-0"
              >
                <span class="text-white font-extrabold text-base">SB</span>
              </div>
              <div>
                <p class="text-sm font-bold text-accent leading-tight">
                  Subodh Man Singh Bhandari
                </p>
                <span
                  class="inline-block text-[10px] font-semibold uppercase tracking-wide bg-green-50 text-green-600 px-2 py-0.5 rounded-full mt-0.5"
                  >Civil Eng. · Full Stack Dev</span
                >
              </div>
            </div>
            <div class="w-full h-px bg-gray-100"></div>
            <div class="flex flex-col gap-2">
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-helmet-safety text-green-500 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500"
                  >Civil Engineering · Java · MySQL</span
                >
              </div>
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-envelope text-red-400 text-xs w-4 text-center"
                ></i>
                <a
                  href="mailto:smsb668@gmail.com"
                  class="text-xs text-accent hover:underline truncate"
                  >smsb668@gmail.com</a
                >
              </div>
            </div>
          </div>

          <!-- Unita Rai -->
          <div
            class="bg-primary border border-gray-200 rounded-2xl p-6 flex flex-col gap-4 hover:shadow-md hover:border-gray-300 transition-all duration-200"
          >
            <div class="flex items-center gap-4">
              <div
                class="w-12 h-12 rounded-xl bg-accent flex items-center justify-center flex-shrink-0"
              >
                <span class="text-white font-extrabold text-base">UR</span>
              </div>
              <div>
                <p class="text-sm font-bold text-accent leading-tight">
                  Unita Rai
                </p>
                <span
                  class="inline-block text-[10px] font-semibold uppercase tracking-wide bg-blue-50 text-blue-600 px-2 py-0.5 rounded-full mt-0.5"
                  >Full Stack Developer</span
                >
              </div>
            </div>
            <div class="w-full h-px bg-gray-100"></div>
            <div class="flex flex-col gap-2">
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-code text-blue-500 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500">Java · JSP · MySQL</span>
              </div>
              <div class="flex items-center gap-2.5">
                <i
                  class="fa-solid fa-envelope text-red-400 text-xs w-4 text-center"
                ></i>
                <span class="text-xs text-gray-500">ugurung247@gmail.com</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- tech stack  -->
      <section class="bg-primary border-y border-gray-100">
        <div class="w-[90vw] mx-auto py-14">
          <div class="mb-8">
            <p
              class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
            >
              Tech Stack
            </p>
            <h2 class="text-2xl md:text-3xl font-bold text-accent">
              Built With
            </h2>
            <p class="text-sm text-gray-500 mt-1">
              NEO-HUB is powered by a solid, battle-tested Java web stack.
            </p>
          </div>
          <div class="flex flex-wrap gap-3">
            <span
              class="inline-flex items-center gap-2 bg-secondary border border-gray-200 text-xs font-semibold text-accent px-4 py-2.5 rounded-xl hover:border-gray-300 transition"
            >
              <i class="fa-brands fa-java text-orange-500 text-sm"></i> Java
              &amp; Servlets
            </span>
            <span
              class="inline-flex items-center gap-2 bg-secondary border border-gray-200 text-xs font-semibold text-accent px-4 py-2.5 rounded-xl hover:border-gray-300 transition"
            >
              <i class="fa-solid fa-file-code text-blue-500 text-sm"></i> JSP
            </span>
            <span
              class="inline-flex items-center gap-2 bg-secondary border border-gray-200 text-xs font-semibold text-accent px-4 py-2.5 rounded-xl hover:border-gray-300 transition"
            >
              <i class="fa-solid fa-database text-cyan-500 text-sm"></i> MySQL
            </span>
            <span
              class="inline-flex items-center gap-2 bg-secondary border border-gray-200 text-xs font-semibold text-accent px-4 py-2.5 rounded-xl hover:border-gray-300 transition"
            >
              <i class="fa-brands fa-css3-alt text-sky-500 text-sm"></i>
              Tailwind CSS
            </span>
            <span
              class="inline-flex items-center gap-2 bg-secondary border border-gray-200 text-xs font-semibold text-accent px-4 py-2.5 rounded-xl hover:border-gray-300 transition"
            >
              <i class="fa-solid fa-chart-pie text-pink-500 text-sm"></i>
              Chart.js
            </span>
            <span
              class="inline-flex items-center gap-2 bg-secondary border border-gray-200 text-xs font-semibold text-accent px-4 py-2.5 rounded-xl hover:border-gray-300 transition"
            >
              <i class="fa-solid fa-wallet text-purple-500 text-sm"></i> Khalti
              API
            </span>
          </div>
        </div>
      </section>

      <!-- banner  -->
      <section class="w-[90vw] mx-auto py-14">
        <div
          class="bg-accent rounded-3xl p-8 md:p-12 flex flex-col md:flex-row items-center justify-between gap-6 relative overflow-hidden"
        >
          <div
            class="absolute right-0 top-0 w-32 h-32 rounded-full bg-white/5 pointer-events-none"
          ></div>
          <div
            class="absolute right-16 bottom-0 w-20 h-20 rounded-full bg-white/5 pointer-events-none"
          ></div>
          <div class="text-center md:text-left">
            <p
              class="text-xs uppercase tracking-widest text-white/50 mb-2 font-semibold"
            >
              Ready to Build?
            </p>
            <h3 class="text-xl md:text-2xl font-bold text-white mb-2">
              Start your IoT journey today
            </h3>
            <p class="text-sm text-white/60 max-w-sm">
              Browse 500+ components, kits and devices — all delivered
              nationwide across Nepal.
            </p>
          </div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="flex-shrink-0 inline-flex items-center gap-2 bg-white text-accent text-sm font-bold px-8 py-3 rounded-xl hover:opacity-90 transition shadow-sm"
          >
            <i class="fa-solid fa-arrow-right text-xs"></i> Shop Now
          </a>
        </div>
      </section>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
  </body>
</html>
