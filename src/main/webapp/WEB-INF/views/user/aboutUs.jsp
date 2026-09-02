<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="About Us | NEO-HUB & NEO-SPARK Team" />
    <jsp:param name="metaDescription" value="Learn more about NEO-HUB, the NEO-SPARK team, and our mission to provide premier IoT components across Nepal." />
    <jsp:param name="metaKeywords" value="IoT Nepal, Arduino, sensors, electronics, IoT kits, NEO-HUB, NEO-SPARK" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
</jsp:include>

<body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="about" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-8 pb-28 space-y-16">
        
        <!-- Hero Section -->
        <section class="text-center max-w-3xl mx-auto space-y-4 pt-4">
            <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-50 border border-brand-200 text-brand-700 text-xs font-bold shadow-subtle">
                <span class="w-2 h-2 rounded-full bg-brand-500 animate-pulse"></span>
                <span>Nepal's Premier IoT Marketplace</span>
            </div>
            <h1 class="text-3xl sm:text-5xl lg:text-6xl font-black text-slate-900 tracking-tight leading-[1.1]">
                Built by Makers,<br/>
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-600 via-brand-500 to-indigo-600">for Makers in Nepal.</span>
            </h1>
            <p class="text-xs sm:text-sm text-slate-500 font-medium leading-relaxed max-w-xl mx-auto">
                NEO-HUB is Pokhara-rooted and nationwide-driven. We empower students, engineers, and hobbyists with verified electronics, quick dispatch, and authentic hardware.
            </p>

            <!-- Stats Ribbon -->
            <div class="pt-6 grid grid-cols-2 sm:grid-cols-4 gap-4">
                <div class="p-4 rounded-2xl bg-white border border-slate-200/80 shadow-card">
                    <span class="text-xl sm:text-2xl font-black text-slate-900">500+</span>
                    <span class="block text-[11px] font-bold text-slate-400 uppercase tracking-wider mt-0.5">Verified Parts</span>
                </div>
                <div class="p-4 rounded-2xl bg-white border border-slate-200/80 shadow-card">
                    <span class="text-xl sm:text-2xl font-black text-slate-900">6</span>
                    <span class="block text-[11px] font-bold text-slate-400 uppercase tracking-wider mt-0.5">Lab Engineers</span>
                </div>
                <div class="p-4 rounded-2xl bg-white border border-slate-200/80 shadow-card">
                    <span class="text-xl sm:text-2xl font-black text-slate-900">77</span>
                    <span class="block text-[11px] font-bold text-slate-400 uppercase tracking-wider mt-0.5">Districts Served</span>
                </div>
                <div class="p-4 rounded-2xl bg-white border border-slate-200/80 shadow-card">
                    <span class="text-xl sm:text-2xl font-black text-slate-900">100%</span>
                    <span class="block text-[11px] font-bold text-slate-400 uppercase tracking-wider mt-0.5">Tested Hardware</span>
                </div>
            </div>
        </section>

        <!-- Team Group Showcase -->
        <section class="relative rounded-3xl overflow-hidden border border-slate-200/80 shadow-card bg-slate-900 h-80 sm:h-[420px]">
            <img src="${pageContext.request.contextPath}/static/images/group-photo.jpg"
                 alt="NEO-SPARK Team"
                 class="w-full h-full object-cover object-top opacity-90"/>
            <div class="absolute inset-0 bg-gradient-to-t from-slate-950 via-slate-950/40 to-transparent"></div>
            
            <div class="absolute bottom-0 left-0 right-0 p-6 sm:p-8 flex flex-col sm:flex-row items-start sm:items-end justify-between gap-4">
                <div class="text-white space-y-1">
                    <div class="inline-flex items-center gap-2 px-3 py-1 rounded-xl bg-white/10 backdrop-blur-md text-brand-300 text-xs font-bold border border-white/10">
                        <i class="fa-solid fa-bolt"></i> NEO-SPARK Team
                    </div>
                    <h2 class="text-xl sm:text-2xl font-extrabold tracking-tight">Engineers, Designers &amp; Hardware Enthusiasts</h2>
                    <p class="text-xs text-slate-300 font-medium">Pokhara, Gandaki Province &bull; 6 Core Members</p>
                </div>
                <a href="#team" class="px-5 py-2.5 rounded-2xl bg-white text-slate-900 text-xs font-extrabold hover:bg-slate-100 transition shadow-md whitespace-nowrap">
                    Meet the Members <i class="fa-solid fa-arrow-down ml-1 text-xs"></i>
                </a>
            </div>
        </section>

        <!-- Mission & Vision Section -->
        <section class="space-y-6">
            <div class="flex flex-col sm:flex-row sm:items-end justify-between gap-2 border-b border-slate-200/80 pb-4">
                <div>
                    <span class="text-xs font-extrabold text-slate-400 uppercase tracking-wider">Core Purpose</span>
                    <h2 class="text-2xl font-extrabold text-slate-900 tracking-tight">Our Mission &amp; Vision</h2>
                </div>
                <p class="text-xs text-slate-500 font-medium max-w-sm">
                    Breaking hardware barriers and fostering next-gen IoT engineering in Nepal.
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="bg-white border border-slate-200/80 rounded-3xl p-7 shadow-card space-y-4 relative overflow-hidden group hover:border-slate-300 transition">
                    <div class="w-12 h-12 rounded-2xl bg-brand-50 text-brand-600 border border-brand-200 flex items-center justify-center text-xl shadow-subtle group-hover:scale-105 transition-transform">
                        <i class="fa-solid fa-bullseye"></i>
                    </div>
                    <div class="space-y-2">
                        <h3 class="text-lg font-extrabold text-slate-900">Our Mission</h3>
                        <p class="text-xs sm:text-sm text-slate-500 leading-relaxed font-medium">
                            To make IoT and embedded electronics accessible to every student, hobbyist, and startup in Nepal. By sourcing reliable components and curating tested starter kits, we eliminate supply delays and counterfeit hardware headaches.
                        </p>
                    </div>
                </div>

                <div class="bg-white border border-slate-200/80 rounded-3xl p-7 shadow-card space-y-4 relative overflow-hidden group hover:border-slate-300 transition">
                    <div class="w-12 h-12 rounded-2xl bg-purple-50 text-purple-600 border border-purple-200 flex items-center justify-center text-xl shadow-subtle group-hover:scale-105 transition-transform">
                        <i class="fa-solid fa-compass"></i>
                    </div>
                    <div class="space-y-2">
                        <h3 class="text-lg font-extrabold text-slate-900">Our Vision</h3>
                        <p class="text-xs sm:text-sm text-slate-500 leading-relaxed font-medium">
                            A self-reliant Nepal where makers bring intelligent smart-agriculture, home-automation, and industrial IoT solutions to life rapidly with local hardware access, transparent pricing, and comprehensive schematics.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Product Categories Offerings -->
        <section class="space-y-6">
            <div class="flex flex-col sm:flex-row sm:items-end justify-between gap-2 border-b border-slate-200/80 pb-4">
                <div>
                    <span class="text-xs font-extrabold text-slate-400 uppercase tracking-wider">Hardware Lab Catalog</span>
                    <h2 class="text-2xl font-extrabold text-slate-900 tracking-tight">What We Provide</h2>
                </div>
                <a href="${pageContext.request.contextPath}/products" class="text-xs font-bold text-slate-900 hover:text-brand-600 transition flex items-center gap-1">
                    Explore full catalog <i class="fa-solid fa-arrow-right text-[10px]"></i>
                </a>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start">
                    <div class="w-11 h-11 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center flex-shrink-0 text-lg border border-blue-100">
                        <i class="fa-solid fa-microchip"></i>
                    </div>
                    <div class="space-y-1">
                        <h4 class="text-sm font-extrabold text-slate-900">Development Boards</h4>
                        <p class="text-xs text-slate-500 font-medium leading-relaxed">ESP32, Arduino Uno/Nano, Raspberry Pi &amp; STM32 microcontrollers.</p>
                    </div>
                </div>

                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start">
                    <div class="w-11 h-11 rounded-2xl bg-amber-50 text-amber-600 flex items-center justify-center flex-shrink-0 text-lg border border-amber-100">
                        <i class="fa-solid fa-temperature-half"></i>
                    </div>
                    <div class="space-y-1">
                        <h4 class="text-sm font-extrabold text-slate-900">Sensors &amp; Actuators</h4>
                        <p class="text-xs text-slate-500 font-medium leading-relaxed">PIR motion, ultrasonic, DHT22, gas MQ series, servos and relays.</p>
                    </div>
                </div>

                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start">
                    <div class="w-11 h-11 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center flex-shrink-0 text-lg border border-emerald-100">
                        <i class="fa-solid fa-wifi"></i>
                    </div>
                    <div class="space-y-1">
                        <h4 class="text-sm font-extrabold text-slate-900">Wireless &amp; LoRa Modules</h4>
                        <p class="text-xs text-slate-500 font-medium leading-relaxed">NRF24L01, LoRa SX1278, GSM SIM800L and Bluetooth HC-05 modules.</p>
                    </div>
                </div>

                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start">
                    <div class="w-11 h-11 rounded-2xl bg-purple-50 text-purple-600 flex items-center justify-center flex-shrink-0 text-lg border border-purple-100">
                        <i class="fa-solid fa-boxes-stacked"></i>
                    </div>
                    <div class="space-y-1">
                        <h4 class="text-sm font-extrabold text-slate-900">IoT Project Starter Kits</h4>
                        <p class="text-xs text-slate-500 font-medium leading-relaxed">Turnkey bundles with jumper wires, breadboards, schematics &amp; code.</p>
                    </div>
                </div>

                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start">
                    <div class="w-11 h-11 rounded-2xl bg-rose-50 text-rose-600 flex items-center justify-center flex-shrink-0 text-lg border border-rose-100">
                        <i class="fa-solid fa-bolt-lightning"></i>
                    </div>
                    <div class="space-y-1">
                        <h4 class="text-sm font-extrabold text-slate-900">Power &amp; Battery Systems</h4>
                        <p class="text-xs text-slate-500 font-medium leading-relaxed">18650 Li-ion cells, BMS protection boards, and buck-boost converters.</p>
                    </div>
                </div>

                <div class="bg-white border border-slate-200/80 rounded-3xl p-6 shadow-card flex gap-4 items-start">
                    <div class="w-11 h-11 rounded-2xl bg-indigo-50 text-indigo-600 flex items-center justify-center flex-shrink-0 text-lg border border-indigo-100">
                        <i class="fa-solid fa-wallet"></i>
                    </div>
                    <div class="space-y-1">
                        <h4 class="text-sm font-extrabold text-slate-900">Seamless Nepal Checkout</h4>
                        <p class="text-xs text-slate-500 font-medium leading-relaxed">Instant Khalti wallet payment or Cash on Delivery with promo perks.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Team Members Grid -->
        <section id="team" class="space-y-6">
            <div class="flex flex-col sm:flex-row sm:items-end justify-between gap-2 border-b border-slate-200/80 pb-4">
                <div>
                    <span class="text-xs font-extrabold text-slate-400 uppercase tracking-wider">The Builders</span>
                    <h2 class="text-2xl font-extrabold text-slate-900 tracking-tight">Meet the NEO-SPARK Team</h2>
                </div>
                <p class="text-xs text-slate-500 font-medium max-w-sm">
                    Dedicated engineering minds crafting the platform and curating components.
                </p>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

                <!-- 1. Aviyan Thapa -->
                <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-card hover:shadow-card-hover transition-all group">
                    <div class="h-80 overflow-hidden bg-slate-100 relative">
                        <img src="${pageContext.request.contextPath}/static/images/aviyan.jpeg"
                             alt="Aviyan Thapa"
                             class="w-full h-full object-cover object-top group-hover:scale-105 transition-transform duration-300"/>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                        <span class="absolute bottom-3 left-3 px-3 py-1 rounded-xl bg-white/90 backdrop-blur-sm text-[11px] font-extrabold text-slate-900 shadow-sm">
                            Front-End Developer
                        </span>
                    </div>
                    <div class="p-5 space-y-3">
                        <div>
                            <h3 class="text-base font-extrabold text-slate-900">Aviyan Thapa</h3>
                            <p class="text-xs text-slate-400 font-semibold">UI Engineering &amp; Interactions</p>
                        </div>
                        <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-xs font-medium text-slate-500">
                            <span class="flex items-center gap-1.5"><i class="fa-solid fa-code text-brand-500 text-[11px]"></i> JSP &bull; Tailwind</span>
                            <a href="mailto:aviyan960@gmail.com" class="text-slate-800 hover:text-brand-600 font-bold transition">
                                <i class="fa-solid fa-envelope"></i> Email
                            </a>
                        </div>
                    </div>
                </div>

                <!-- 2. Bibek Poudel -->
                <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-card hover:shadow-card-hover transition-all group">
                    <div class="h-80 overflow-hidden bg-slate-100 relative">
                        <img src="${pageContext.request.contextPath}/static/images/bibek.jpeg"
                             alt="Bibek Poudel"
                             class="w-full h-full object-cover object-center group-hover:scale-105 transition-transform duration-300"/>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                        <span class="absolute bottom-3 left-3 px-3 py-1 rounded-xl bg-white/90 backdrop-blur-sm text-[11px] font-extrabold text-slate-900 shadow-sm">
                            Senior Full-Stack Dev
                        </span>
                    </div>
                    <div class="p-5 space-y-3">
                        <div>
                            <h3 class="text-base font-extrabold text-slate-900">Bibek Poudel</h3>
                            <p class="text-xs text-slate-400 font-semibold">Backend Architecture &amp; APIs</p>
                        </div>
                        <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-xs font-medium text-slate-500">
                            <span class="flex items-center gap-1.5"><i class="fa-solid fa-code text-brand-500 text-[11px]"></i> Jakarta EE &bull; Servlets</span>
                            <a href="mailto:bibekpoudel855@gmail.com" class="text-slate-800 hover:text-brand-600 font-bold transition">
                                <i class="fa-solid fa-envelope"></i> Email
                            </a>
                        </div>
                    </div>
                </div>

                <!-- 3. Mamata Timilsina -->
                <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-card hover:shadow-card-hover transition-all group">
                    <div class="h-80 overflow-hidden bg-slate-100 relative">
                        <img src="${pageContext.request.contextPath}/static/images/mamata.jpeg"
                             alt="Mamata Timilsina"
                             class="w-full h-full object-cover object-bottom group-hover:scale-105 transition-transform duration-300"/>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                        <span class="absolute bottom-3 left-3 px-3 py-1 rounded-xl bg-white/90 backdrop-blur-sm text-[11px] font-extrabold text-slate-900 shadow-sm">
                            Database Designer
                        </span>
                    </div>
                    <div class="p-5 space-y-3">
                        <div>
                            <h3 class="text-base font-extrabold text-slate-900">Mamata Timilsina</h3>
                            <p class="text-xs text-slate-400 font-semibold">Relational Schema &amp; Security</p>
                        </div>
                        <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-xs font-medium text-slate-500">
                            <span class="flex items-center gap-1.5"><i class="fa-solid fa-database text-cyan-500 text-[11px]"></i> MySQL &bull; ACID</span>
                            <a href="mailto:mamatimilsina8@gmail.com" class="text-slate-800 hover:text-brand-600 font-bold transition">
                                <i class="fa-solid fa-envelope"></i> Email
                            </a>
                        </div>
                    </div>
                </div>

                <!-- 4. Parbin Shrees -->
                <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-card hover:shadow-card-hover transition-all group">
                    <div class="h-80 overflow-hidden bg-slate-100 relative">
                        <img src="${pageContext.request.contextPath}/static/images/parbin.jpeg"
                             alt="Parbin Shrees"
                             class="w-full h-full object-cover object-center group-hover:scale-105 transition-transform duration-300"/>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                        <span class="absolute bottom-3 left-3 px-3 py-1 rounded-xl bg-white/90 backdrop-blur-sm text-[11px] font-extrabold text-slate-900 shadow-sm">
                            UI/UX Designer
                        </span>
                    </div>
                    <div class="p-5 space-y-3">
                        <div>
                            <h3 class="text-base font-extrabold text-slate-900">Parbin Shrees</h3>
                            <p class="text-xs text-slate-400 font-semibold">Visual Design &amp; Aesthetics</p>
                        </div>
                        <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-xs font-medium text-slate-500">
                            <span class="flex items-center gap-1.5"><i class="fa-solid fa-palette text-pink-500 text-[11px]"></i> Figma &bull; Wireframes</span>
                            <a href="mailto:parbinshreesh64487@gmail.com" class="text-slate-800 hover:text-brand-600 font-bold transition">
                                <i class="fa-solid fa-envelope"></i> Email
                            </a>
                        </div>
                    </div>
                </div>

                <!-- 5. Subodh Man Singh Bhandari -->
                <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-card hover:shadow-card-hover transition-all group">
                    <div class="h-80 overflow-hidden bg-slate-100 relative">
                        <img src="${pageContext.request.contextPath}/static/images/subodh.jpeg"
                             alt="Subodh Man Singh Bhandari"
                             class="w-full h-full object-cover object-top group-hover:scale-105 transition-transform duration-300"/>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                        <span class="absolute bottom-3 left-3 px-3 py-1 rounded-xl bg-white/90 backdrop-blur-sm text-[11px] font-extrabold text-slate-900 shadow-sm">
                            Civil Eng. &bull; Full-Stack
                        </span>
                    </div>
                    <div class="p-5 space-y-3">
                        <div>
                            <h3 class="text-base font-extrabold text-slate-900">Subodh Man Singh</h3>
                            <p class="text-xs text-slate-400 font-semibold">Full-Stack &amp; Hardware Integration</p>
                        </div>
                        <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-xs font-medium text-slate-500">
                            <span class="flex items-center gap-1.5"><i class="fa-solid fa-helmet-safety text-amber-500 text-[11px]"></i> Civil &bull; Java</span>
                            <a href="mailto:smsb668@gmail.com" class="text-slate-800 hover:text-brand-600 font-bold transition">
                                <i class="fa-solid fa-envelope"></i> Email
                            </a>
                        </div>
                    </div>
                </div>

                <!-- 6. Unita Rai -->
                <div class="bg-white border border-slate-200/80 rounded-3xl overflow-hidden shadow-card hover:shadow-card-hover transition-all group">
                    <div class="h-80 overflow-hidden bg-slate-100 relative">
                        <img src="${pageContext.request.contextPath}/static/images/unita.jpeg"
                             alt="Unita Rai"
                             class="w-full h-full object-cover object-top group-hover:scale-105 transition-transform duration-300"/>
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                        <span class="absolute bottom-3 left-3 px-3 py-1 rounded-xl bg-white/90 backdrop-blur-sm text-[11px] font-extrabold text-slate-900 shadow-sm">
                            Project Manager
                        </span>
                    </div>
                    <div class="p-5 space-y-3">
                        <div>
                            <h3 class="text-base font-extrabold text-slate-900">Unita Rai</h3>
                            <p class="text-xs text-slate-400 font-semibold">Operations &amp; Deliverables</p>
                        </div>
                        <div class="pt-2 border-t border-slate-100 flex items-center justify-between text-xs font-medium text-slate-500">
                            <span class="flex items-center gap-1.5"><i class="fa-solid fa-list-check text-purple-500 text-[11px]"></i> Agile &bull; Sprint Lead</span>
                            <a href="mailto:ugurung247@gmail.com" class="text-slate-800 hover:text-brand-600 font-bold transition">
                                <i class="fa-solid fa-envelope"></i> Email
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- Tech Stack Badges -->
        <section class="bg-white border border-slate-200/80 rounded-3xl p-8 shadow-card space-y-6">
            <div class="space-y-1">
                <span class="text-xs font-extrabold text-slate-400 uppercase tracking-wider">Architecture</span>
                <h3 class="text-xl font-extrabold text-slate-900">Engineered with Battle-Tested Tech</h3>
                <p class="text-xs text-slate-500 font-medium">High performance Java backend paired with modern utility styling.</p>
            </div>
            <div class="flex flex-wrap gap-3">
                <span class="inline-flex items-center gap-2 px-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 text-xs font-bold text-slate-800 shadow-subtle">
                    <i class="fa-brands fa-java text-orange-500 text-base"></i> Java EE &amp; Servlets
                </span>
                <span class="inline-flex items-center gap-2 px-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 text-xs font-bold text-slate-800 shadow-subtle">
                    <i class="fa-solid fa-file-code text-blue-500 text-base"></i> JSP &amp; JSTL
                </span>
                <span class="inline-flex items-center gap-2 px-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 text-xs font-bold text-slate-800 shadow-subtle">
                    <i class="fa-solid fa-database text-cyan-500 text-base"></i> MySQL Relational DB
                </span>
                <span class="inline-flex items-center gap-2 px-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 text-xs font-bold text-slate-800 shadow-subtle">
                    <i class="fa-brands fa-css3-alt text-sky-500 text-base"></i> Tailwind CSS
                </span>
                <span class="inline-flex items-center gap-2 px-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 text-xs font-bold text-slate-800 shadow-subtle">
                    <i class="fa-solid fa-wallet text-purple-600 text-base"></i> Khalti Payment Gateway
                </span>
                <span class="inline-flex items-center gap-2 px-4 py-2.5 rounded-2xl bg-slate-50 border border-slate-200 text-xs font-bold text-slate-800 shadow-subtle">
                    <i class="fa-solid fa-bolt text-brand-500 text-base"></i> HTMX Dynamic Partial Swaps
                </span>
            </div>
        </section>

        <!-- Ready to Build Banner -->
        <section class="bg-gradient-to-r from-slate-950 via-slate-900 to-slate-950 rounded-3xl p-8 sm:p-12 text-white flex flex-col md:flex-row items-center justify-between gap-8 border border-slate-800 shadow-2xl relative overflow-hidden">
            <div class="absolute -right-20 -top-20 w-80 h-80 bg-brand-500/10 rounded-full blur-3xl pointer-events-none"></div>
            <div class="space-y-2 text-center md:text-left relative z-10">
                <span class="text-xs font-bold uppercase tracking-widest text-brand-400">Ready to start prototyping?</span>
                <h3 class="text-2xl sm:text-3xl font-extrabold tracking-tight">Equip your workbench with NEO-HUB</h3>
                <p class="text-xs sm:text-sm text-slate-400 max-w-md font-medium">
                    Order individual sensors or complete project kits delivered directly to your doorstep.
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/products"
               class="relative z-10 flex-shrink-0 inline-flex items-center gap-2 bg-white hover:bg-slate-100 text-slate-900 font-extrabold text-xs sm:text-sm px-8 py-3.5 rounded-2xl transition shadow-lg whitespace-nowrap active:scale-95">
                <span>Browse Products</span>
                <i class="fa-solid fa-arrow-right text-xs text-brand-600"></i>
            </a>
        </section>

    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>

