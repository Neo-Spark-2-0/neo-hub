<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
  <jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="NEO-HUB | Nepal's Premier IoT & Electronics Marketplace" />
    <jsp:param
      name="metaDescription"
      value="Welcome to NEO-HUB, your one-stop shop for IoT equipment, Arduino, Raspberry Pi, modules and project kits."
    />
    <jsp:param
      name="metaKeywords"
      value="IoT, Arduino, ESP32, sensors, electronics, robotics, IoT kits, Nepal, NEO-HUB"
    />
    <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK" />
  </jsp:include>

  <body class="font-poppins bg-slate-50 text-slate-900 antialiased selection:bg-brand-500 selection:text-white">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
      <jsp:param name="activePage" value="home" />
    </jsp:include>

    <main class="w-[92vw] max-w-7xl mx-auto py-6 space-y-16">

      <!-- ============================================================
           HERO SECTION: Modern High-Impact Mesh Dark Banner
           ============================================================ -->
      <section class="relative rounded-3xl bg-gradient-to-br from-slate-950 via-slate-900 to-slate-850 text-white p-8 sm:p-12 md:p-16 overflow-hidden shadow-2xl border border-slate-800">
        <!-- Ambient Glowing Background Circles -->
        <div class="absolute -top-24 -right-24 w-96 h-96 bg-brand-500/15 rounded-full blur-3xl pointer-events-none"></div>
        <div class="absolute -bottom-24 -left-24 w-96 h-96 bg-blue-600/10 rounded-full blur-3xl pointer-events-none"></div>

        <div class="relative z-10 flex flex-col lg:flex-row items-center justify-between gap-12">
          
          <!-- Left Hero Text & CTA -->
          <div class="flex-1 text-center lg:text-left">
            
            <div class="inline-flex items-center gap-2 text-xs font-bold tracking-wider uppercase text-brand-400 bg-brand-500/10 border border-brand-500/25 rounded-full px-4 py-1.5 mb-6">
              <span class="w-2 h-2 rounded-full bg-brand-500 animate-pulse"></span>
              Nepal's #1 IoT Marketplace
            </div>

            <h1 class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-extrabold tracking-tight leading-[1.1] mb-6">
              Build the Future with <br />
              <span class="text-transparent bg-clip-text bg-gradient-to-r from-brand-400 via-emerald-300 to-teal-200">Next-Gen Electronics</span>
            </h1>

            <p class="text-slate-300 text-sm sm:text-base max-w-xl mb-8 mx-auto lg:mx-0 leading-relaxed font-normal">
              Arduino, ESP32, sensors, actuators, drone parts, and ready-to-deploy IoT development kits — delivered swiftly across Nepal.
            </p>

            <!-- Search Bar in Hero -->
            <form action="${pageContext.request.contextPath}/products" method="get" class="mb-8 max-w-md mx-auto lg:mx-0">
              <div class="flex items-center bg-white/10 backdrop-blur-md border border-white/15 rounded-2xl p-1.5 focus-within:border-brand-400 focus-within:ring-2 focus-within:ring-brand-400/30 transition-all shadow-lg">
                <i class="fa-solid fa-magnifying-glass text-slate-400 text-sm pl-4 pr-2"></i>
                <input type="text" name="keyword" placeholder="Search sensors, microcontrollers, kits..."
                       class="w-full py-2.5 text-sm text-white placeholder-slate-400 bg-transparent focus:outline-none" />
                <button type="submit"
                        class="px-5 py-2.5 bg-brand-500 hover:bg-brand-600 text-slate-950 font-bold text-xs rounded-xl transition-all shadow-md flex-shrink-0 flex items-center gap-1.5">
                  Search
                  <i class="fa-solid fa-arrow-right text-[10px]"></i>
                </button>
              </div>
            </form>

            <!-- CTA Buttons -->
            <div class="flex flex-wrap gap-3.5 justify-center lg:justify-start">
              <a href="${pageContext.request.contextPath}/products"
                 class="px-7 py-3.5 rounded-2xl bg-white text-slate-900 text-xs sm:text-sm font-bold hover:bg-slate-100 transition-all shadow-lg hover:shadow-xl flex items-center gap-2">
                <i class="fa-solid fa-bag-shopping text-brand-600"></i>
                Explore Catalog
              </a>
              <a href="${pageContext.request.contextPath}/products?sort=newest"
                 class="px-7 py-3.5 rounded-2xl bg-white/10 hover:bg-white/15 text-white border border-white/20 text-xs sm:text-sm font-semibold transition-all">
                New Arrivals
              </a>
            </div>

            <!-- Stats Bar -->
            <div class="flex items-center gap-6 sm:gap-8 mt-10 justify-center lg:justify-start pt-6 border-t border-slate-800/80">
              <div>
                <p class="text-xl sm:text-2xl font-black text-white">500+</p>
                <p class="text-[11px] font-medium text-slate-400">Products in Stock</p>
              </div>
              <div class="w-px h-8 bg-slate-800"></div>
              <div>
                <p class="text-xl sm:text-2xl font-black text-brand-400">100%</p>
                <p class="text-[11px] font-medium text-slate-400">Tested Quality</p>
              </div>
              <div class="w-px h-8 bg-slate-800"></div>
              <div>
                <p class="text-xl sm:text-2xl font-black text-white">Khalti &amp; COD</p>
                <p class="text-[11px] font-medium text-slate-400">Instant Payments</p>
              </div>
            </div>

          </div>

          <!-- Right Hero Image with Floating Badge -->
          <div class="w-full max-w-md lg:max-w-lg flex-shrink-0">
            <div class="relative rounded-3xl overflow-hidden border border-slate-700/60 shadow-2xl bg-slate-900 aspect-[4/3] group">
              <img src="${pageContext.request.contextPath}/static/images/hero.jpg"
                   alt="IoT components and project kits"
                   class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" />
              <div class="absolute inset-0 bg-gradient-to-t from-slate-950/70 via-transparent to-transparent"></div>

              <!-- Floating Fast Delivery Badge -->
              <div class="absolute bottom-4 left-4 right-4 bg-slate-900/90 backdrop-blur-md border border-slate-700/80 rounded-2xl p-3.5 flex items-center justify-between shadow-xl">
                <div class="flex items-center gap-3">
                  <div class="w-9 h-9 rounded-xl bg-brand-500/20 text-brand-400 border border-brand-500/30 flex items-center justify-center flex-shrink-0">
                    <i class="fa-solid fa-bolt-lightning text-sm"></i>
                  </div>
                  <div>
                    <p class="text-xs font-bold text-white">Express Nationwide Dispatch</p>
                    <p class="text-[10px] text-slate-400">Free delivery on orders over Rs. 2,000</p>
                  </div>
                </div>
                <span class="hidden sm:inline-flex px-2.5 py-1 rounded-lg bg-brand-500 text-slate-950 font-extrabold text-[10px]">
                  ACTIVE
                </span>
              </div>
            </div>
          </div>

        </div>
      </section>

      <!-- ============================================================
           CATEGORIES: Visual Modern Cards
           ============================================================ -->
      <section class="space-y-6">
        <div class="flex items-end justify-between">
          <div>
            <div class="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-brand-600 mb-1">
              <i class="fa-solid fa-layer-group text-[10px]"></i>
              Catalog
            </div>
            <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
              Shop by Category
            </h2>
          </div>
          <a href="${pageContext.request.contextPath}/products"
             class="text-xs sm:text-sm font-bold text-slate-600 hover:text-slate-900 flex items-center gap-1.5 transition-colors group">
            View all categories
            <i class="fa-solid fa-arrow-right text-xs transition-transform group-hover:translate-x-1"></i>
          </a>
        </div>

        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-4">
          <c:forEach var="category" items="${categories}">
            <a href="${pageContext.request.contextPath}/products?categoryId=${category.id}"
               class="glass-card rounded-2xl p-4 flex flex-col items-center gap-3 text-center hover-lift group border border-slate-200/80 bg-white">
              
              <div class="w-16 h-16 rounded-2xl bg-slate-100 flex items-center justify-center overflow-hidden border border-slate-100 group-hover:border-brand-500/40 group-hover:bg-brand-50/50 transition-all">
                <c:choose>
                  <c:when test="${not empty category.image}">
                    <img src="${pageContext.request.contextPath}/uploads/${category.image}"
                         alt="${category.name}"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300" />
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/static/images/category-fallback.jpg"
                         alt="${category.name}"
                         class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-300" />
                  </c:otherwise>
                </c:choose>
              </div>

              <div class="w-full">
                <span class="text-xs font-bold text-slate-800 group-hover:text-brand-600 transition-colors line-clamp-1">
                  <c:out value="${category.name}" />
                </span>
                <span class="text-[10px] text-slate-400 font-medium mt-0.5 block">Explore items</span>
              </div>
            </a>
          </c:forEach>

          <c:if test="${empty categories}">
            <div class="col-span-full py-12 text-center bg-white rounded-2xl border border-slate-200">
              <i class="fa-solid fa-box-open text-slate-300 text-3xl mb-2"></i>
              <p class="text-xs font-semibold text-slate-400">No categories found in catalog.</p>
            </div>
          </c:if>
        </div>
      </section>

      <!-- ============================================================
           FEATURED PRODUCTS: Modern Product Cards
           ============================================================ -->
      <section class="space-y-6">
        <div class="flex items-end justify-between">
          <div>
            <div class="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-amber-500 mb-1">
              <i class="fa-solid fa-star text-[10px]"></i>
              Handpicked
            </div>
            <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
              Featured Products
            </h2>
          </div>
          <a href="${pageContext.request.contextPath}/products?featured=true"
             class="text-xs sm:text-sm font-bold text-slate-600 hover:text-slate-900 flex items-center gap-1.5 transition-colors group">
            Browse featured
            <i class="fa-solid fa-arrow-right text-xs transition-transform group-hover:translate-x-1"></i>
          </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          <c:forEach var="product" items="${featuredProducts}" begin="0" end="3">
            <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
               class="glass-card rounded-3xl overflow-hidden hover-lift border border-slate-200/80 bg-white flex flex-col group">
              
              <!-- Product Image Frame -->
              <div class="relative w-full aspect-square bg-slate-100 overflow-hidden">
                <c:choose>
                  <c:when test="${not empty product.image}">
                    <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                         alt="<c:out value='${product.name}'/>"
                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                         alt="<c:out value='${product.name}'/>"
                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
                  </c:otherwise>
                </c:choose>

                <!-- Status Badges -->
                <div class="absolute top-3 left-3 flex flex-col gap-1.5">
                  <c:if test="${product.discountPrice > 0}">
                    <span class="px-2.5 py-1 rounded-xl bg-danger text-white text-[10px] font-black tracking-wider uppercase shadow-sm">
                      SALE
                    </span>
                  </c:if>
                  <c:if test="${product.stock == 0}">
                    <span class="px-2.5 py-1 rounded-xl bg-slate-900/90 text-white text-[10px] font-bold shadow-sm">
                      Out of Stock
                    </span>
                  </c:if>
                </div>
              </div>

              <!-- Product Info -->
              <div class="p-5 flex flex-col flex-1 justify-between gap-3">
                <div>
                  <p class="text-[10px] font-bold uppercase tracking-wider text-slate-400 mb-1">
                    <c:out value="${product.categoryName}" />
                  </p>
                  <h3 class="text-sm font-bold text-slate-900 group-hover:text-brand-600 transition-colors line-clamp-2">
                    <c:out value="${product.name}" />
                  </h3>
                </div>

                <div class="pt-3 border-t border-slate-100 flex items-center justify-between">
                  <div class="flex flex-col">
                    <c:choose>
                      <c:when test="${product.discountPrice > 0}">
                        <div class="flex items-center gap-2">
                          <span class="text-base font-extrabold text-slate-900">
                            Rs. <fmt:formatNumber value="${product.discountPrice}" pattern="#,##0" />
                          </span>
                          <span class="text-xs text-slate-400 line-through font-medium">
                            Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0" />
                          </span>
                        </div>
                      </c:when>
                      <c:otherwise>
                        <span class="text-base font-extrabold text-slate-900">
                          Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0" />
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </div>

                  <span class="w-8 h-8 rounded-xl bg-slate-100 text-slate-700 group-hover:bg-slate-900 group-hover:text-white flex items-center justify-center transition-colors text-xs">
                    <i class="fa-solid fa-arrow-up-right-from-square"></i>
                  </span>
                </div>
              </div>
            </a>
          </c:forEach>

          <c:if test="${empty featuredProducts}">
            <div class="col-span-full py-12 text-center bg-white rounded-3xl border border-slate-200">
              <i class="fa-regular fa-star text-slate-300 text-3xl mb-2"></i>
              <p class="text-xs font-semibold text-slate-400">No featured products right now.</p>
            </div>
          </c:if>
        </div>
      </section>

      <!-- ============================================================
           PROMOTIONAL REWARDS BANNER
           ============================================================ -->
      <c:if test="${empty sessionScope.user}">
        <section class="rounded-3xl bg-gradient-to-r from-slate-900 via-slate-850 to-slate-950 p-8 sm:p-12 text-white relative overflow-hidden shadow-xl border border-slate-800">
          <div class="absolute -right-16 -top-16 w-64 h-64 bg-brand-500/20 rounded-full blur-3xl pointer-events-none"></div>
          
          <div class="relative z-10 flex flex-col md:flex-row items-center justify-between gap-6">
            <div class="text-center md:text-left max-w-xl">
              <span class="inline-flex items-center gap-2 text-[11px] font-extrabold tracking-wider uppercase text-brand-400 bg-brand-500/15 border border-brand-500/30 rounded-full px-3.5 py-1 mb-3">
                <i class="fa-solid fa-gift"></i>
                NEO-HUB Member Rewards
              </span>
              <h3 class="text-2xl sm:text-3xl font-extrabold tracking-tight mb-2">
                Join Today &amp; Earn Discount Points
              </h3>
              <p class="text-slate-300 text-xs sm:text-sm leading-relaxed">
                Sign up for free, collect rewards points on every order, and redeem them for exclusive discounts on Arduino, Raspberry Pi, and IoT project parts.
              </p>
            </div>

            <div>
              <a href="${pageContext.request.contextPath}/register"
                 class="px-8 py-3.5 rounded-2xl bg-brand-500 hover:bg-brand-600 text-slate-950 font-bold text-xs sm:text-sm transition-all shadow-lg hover:shadow-xl inline-flex items-center gap-2">
                Create Free Account
                <i class="fa-solid fa-arrow-right text-xs"></i>
              </a>
            </div>
          </div>
        </section>
      </c:if>

      <!-- ============================================================
           NEW ARRIVALS: Fresh Stock Section
           ============================================================ -->
      <section class="space-y-6">
        <div class="flex items-end justify-between">
          <div>
            <div class="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-blue-600 mb-1">
              <i class="fa-solid fa-clock-rotate-left text-[10px]"></i>
              Just In
            </div>
            <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
              New Arrivals
            </h2>
          </div>
          <a href="${pageContext.request.contextPath}/products?sort=newest"
             class="text-xs sm:text-sm font-bold text-slate-600 hover:text-slate-900 flex items-center gap-1.5 transition-colors group">
            View all new arrivals
            <i class="fa-solid fa-arrow-right text-xs transition-transform group-hover:translate-x-1"></i>
          </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          <c:forEach var="product" items="${recentProducts}" begin="0" end="3">
            <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
               class="glass-card rounded-3xl overflow-hidden hover-lift border border-slate-200/80 bg-white flex flex-col group">
              
              <!-- Product Image -->
              <div class="relative w-full aspect-square bg-slate-100 overflow-hidden">
                <c:choose>
                  <c:when test="${not empty product.image}">
                    <img src="${pageContext.request.contextPath}/uploads/${product.image}"
                         alt="<c:out value='${product.name}'/>"
                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
                  </c:when>
                  <c:otherwise>
                    <img src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                         alt="<c:out value='${product.name}'/>"
                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" />
                  </c:otherwise>
                </c:choose>

                <!-- Badges -->
                <div class="absolute top-3 left-3 flex flex-col gap-1.5">
                  <span class="px-2.5 py-1 rounded-xl bg-blue-600 text-white text-[10px] font-black tracking-wider uppercase shadow-sm">
                    NEW
                  </span>
                  <c:if test="${product.stock == 0}">
                    <span class="px-2.5 py-1 rounded-xl bg-slate-900/90 text-white text-[10px] font-bold shadow-sm">
                      Out of Stock
                    </span>
                  </c:if>
                </div>
              </div>

              <!-- Details -->
              <div class="p-5 flex flex-col flex-1 justify-between gap-3">
                <div>
                  <p class="text-[10px] font-bold uppercase tracking-wider text-slate-400 mb-1">
                    <c:out value="${product.categoryName}" />
                  </p>
                  <h3 class="text-sm font-bold text-slate-900 group-hover:text-brand-600 transition-colors line-clamp-2">
                    <c:out value="${product.name}" />
                  </h3>
                </div>

                <div class="pt-3 border-t border-slate-100 flex items-center justify-between">
                  <div class="flex flex-col">
                    <c:choose>
                      <c:when test="${product.discountPrice > 0}">
                        <div class="flex items-center gap-2">
                          <span class="text-base font-extrabold text-slate-900">
                            Rs. <fmt:formatNumber value="${product.discountPrice}" pattern="#,##0" />
                          </span>
                          <span class="text-xs text-slate-400 line-through font-medium">
                            Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0" />
                          </span>
                        </div>
                      </c:when>
                      <c:otherwise>
                        <span class="text-base font-extrabold text-slate-900">
                          Rs. <fmt:formatNumber value="${product.price}" pattern="#,##0" />
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </div>

                  <span class="w-8 h-8 rounded-xl bg-slate-100 text-slate-700 group-hover:bg-slate-900 group-hover:text-white flex items-center justify-center transition-colors text-xs">
                    <i class="fa-solid fa-arrow-up-right-from-square"></i>
                  </span>
                </div>
              </div>
            </a>
          </c:forEach>

          <c:if test="${empty recentProducts}">
            <div class="col-span-full py-12 text-center bg-white rounded-3xl border border-slate-200">
              <i class="fa-regular fa-clock text-slate-300 text-3xl mb-2"></i>
              <p class="text-xs font-semibold text-slate-400">No new arrivals at the moment.</p>
            </div>
          </c:if>
        </div>
      </section>

      <!-- ============================================================
           VALUE PILLARS: Why Choose NEO-HUB
           ============================================================ -->
      <section class="rounded-3xl bg-white p-8 sm:p-12 border border-slate-200 shadow-sm space-y-10">
        <div class="text-center max-w-xl mx-auto space-y-2">
          <div class="inline-flex items-center gap-1.5 text-xs font-bold uppercase tracking-wider text-brand-600">
            <i class="fa-solid fa-circle-check"></i>
            The NEO-HUB Advantage
          </div>
          <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">
            Built for Makers, Students &amp; Innovators
          </h2>
          <p class="text-xs sm:text-sm text-slate-500 font-medium">
            Everything you need to turn your hardware ideas into reality with complete peace of mind.
          </p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div class="p-6 rounded-2xl bg-slate-50 border border-slate-100 hover-lift space-y-3">
            <div class="w-12 h-12 rounded-2xl bg-slate-900 text-white flex items-center justify-center text-lg shadow-sm">
              <i class="fa-solid fa-microchip text-brand-400"></i>
            </div>
            <h4 class="text-sm font-bold text-slate-900">Extensive Component Catalog</h4>
            <p class="text-xs text-slate-500 leading-relaxed font-medium">
              Over 500+ microcontrollers, sensors, communication modules, and accessories from trusted manufacturers.
            </p>
          </div>

          <div class="p-6 rounded-2xl bg-slate-50 border border-slate-100 hover-lift space-y-3">
            <div class="w-12 h-12 rounded-2xl bg-slate-900 text-white flex items-center justify-center text-lg shadow-sm">
              <i class="fa-solid fa-truck-ramp-box text-blue-400"></i>
            </div>
            <h4 class="text-sm font-bold text-slate-900">Fast &amp; Insured Dispatch</h4>
            <p class="text-xs text-slate-500 leading-relaxed font-medium">
              Orders are packaged with ESD anti-static safety and shipped directly to all 7 provinces in Nepal.
            </p>
          </div>

          <div class="p-6 rounded-2xl bg-slate-50 border border-slate-100 hover-lift space-y-3">
            <div class="w-12 h-12 rounded-2xl bg-slate-900 text-white flex items-center justify-center text-lg shadow-sm">
              <i class="fa-solid fa-shield-heart text-purple-400"></i>
            </div>
            <h4 class="text-sm font-bold text-slate-900">Khalti &amp; Cash on Delivery</h4>
            <p class="text-xs text-slate-500 leading-relaxed font-medium">
              Seamless one-click digital checkout with Khalti or pay upon delivery right at your doorstep.
            </p>
          </div>

          <div class="p-6 rounded-2xl bg-slate-50 border border-slate-100 hover-lift space-y-3">
            <div class="w-12 h-12 rounded-2xl bg-slate-900 text-white flex items-center justify-center text-lg shadow-sm">
              <i class="fa-solid fa-coins text-amber-400"></i>
            </div>
            <h4 class="text-sm font-bold text-slate-900">Loyalty Rewards Program</h4>
            <p class="text-xs text-slate-500 leading-relaxed font-medium">
              Accumulate points on every component purchase and redeem them for discounts on future hardware projects.
            </p>
          </div>
        </div>
      </section>

    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />

    <script>
      <c:if test="${not empty error}">
          showToast("<c:out value='${error}'/>", "error");
      </c:if>
      <c:if test="${not empty success}">
          showToast("<c:out value='${success}'/>", "success");
      </c:if>

      // flash message from servlet
      <c:if test="${not empty sessionScope.loginSuccessFlashMessage}">
          showToast("${sessionScope.loginSuccessFlashMessage}", "success");
          <%
              session.removeAttribute("loginSuccessFlashMessage");
          %>
      </c:if>
    </script>
  </body>
</html>

