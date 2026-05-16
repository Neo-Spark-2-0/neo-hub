<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="jakarta.tags.core" %> <%@ taglib prefix="fmt"
uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
  <jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="NEO-HUB | Home" />
    <jsp:param
      name="metaDescription"
      value="Welcome to NEO-HUB, your one-stop shop for IoT equipment and projects."
    />
    <jsp:param
      name="metaKeywords"
      value="IoT, Arduino, sensors, electronics, IoT kits, NEO-HUB"
    />
    <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
  </jsp:include>

  <body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
      <jsp:param name="activePage" value="home" />
    </jsp:include>

    <main>
      <!-- hero section  -->
      <section class="bg-gray-200 border-b border-gray-100">
        <div class="w-[90vw] mx-auto py-14 md:py-20 flex flex-col md:flex-row items-center gap-12 md:gap-16">

          <!-- left side section -->
          <div class="flex-1 text-center md:text-left">

            <span class="inline-flex items-center gap-2 text-[11px] font-semibold tracking-widest uppercase text-accent bg-accent/8 border border-accent/20 rounded-full px-3.5 py-1 mb-6">
              <span class="w-1.5 h-1.5 rounded-full bg-accent animate-pulse"></span>
              Nepal's IoT Marketplace
            </span>

            <h1 class="text-4xl sm:text-5xl md:text-[52px] font-extrabold text-accent leading-[1.1] tracking-tight mb-5">
              Build Something<br />
              <span class="text-gray-500">Extraordinary</span>
            </h1>

            <p class="text-gray-500 text-sm sm:text-base max-w-sm mb-8 mx-auto md:mx-0 leading-relaxed">
              Arduino, ESP32, sensors, modules and ready-made IoT project kits —
              all in one place, delivered nationwide.
            </p>

            <!-- search -->
            <form action="${pageContext.request.contextPath}/products" method="get" class="mb-8">
              <div class="flex items-center max-w-sm mx-auto md:mx-0 bg-white border border-gray-200 rounded-xl overflow-hidden focus-within:border-accent focus-within:ring-2 focus-within:ring-accent/15 transition-all shadow-sm">
                <i class="fa-solid fa-magnifying-glass text-gray-400 text-sm pl-4"></i>
                <input type="text" name="keyword" placeholder="Search products…"
                       class="flex-1 px-6 py-3 text-sm text-accent bg-transparent placeholder-gray-400 focus:outline-none" />
                <button type="submit"
                        class="m-1.5 px-4 py-2 bg-accent text-white text-sm font-semibold rounded-lg hover:opacity-90 transition flex-shrink-0">
                  Search
                </button>
              </div>
            </form>


          <!-- buttons  -->
            <div class="flex flex-col sm:flex-row gap-3 justify-center md:justify-start">
              <a href="${pageContext.request.contextPath}/products"
                 class="bg-accent text-white text-sm font-bold px-8 py-3.5 rounded-xl hover:opacity-90 transition shadow-sm">
                Shop Now &nbsp;→
              </a>
              <a href="${pageContext.request.contextPath}/products?sort=newest"
                 class="bg-white border border-gray-200 text-gray-600 text-sm font-medium px-8 py-3.5 rounded-xl hover:bg-gray-50 hover:border-gray-300 transition shadow-sm">
                New Arrivals
              </a>
            </div>

            <!--  stats -->
            <div class="flex items-center gap-6 mt-10 justify-center md:justify-start">
              <div class="text-center md:text-left">
                <p class="text-lg font-extrabold text-accent leading-none">500+</p>
                <p class="text-[11px] text-gray-400 mt-0.5">Products</p>
              </div>
              <div class="w-px h-8 bg-gray-200"></div>
              <div class="text-center md:text-left">
                <p class="text-lg font-extrabold text-accent leading-none">Khalti</p>
                <p class="text-[11px] text-gray-400 mt-0.5">& COD</p>
              </div>
              <div class="w-px h-8 bg-gray-200"></div>
              <div class="text-center md:text-left">
                <p class="text-lg font-extrabold text-accent leading-none">Promo</p>
                <p class="text-[11px] text-gray-400 mt-0.5">Code</p>
              </div>
            </div>
          </div>

          <!-- right hero image -->
          <div class="flex-1 w-full max-w-md md:max-w-none">
            <div class="relative rounded-3xl overflow-hidden bg-gray-100 border border-gray-200 aspect-[4/3] shadow-sm">
              <img src="${pageContext.request.contextPath}/static/images/hero.jpg"
                   alt="IoT components and project kits"
                   class="w-full h-full object-cover" />

              <!-- floating badge -->
              <div class="absolute bottom-4 left-4 bg-white/95 backdrop-blur-sm border border-gray-200 rounded-xl px-4 py-2.5 flex items-center gap-2.5 shadow-sm">
                <div class="w-7 h-7 rounded-lg bg-green-50 flex items-center justify-center flex-shrink-0">
                  <i class="fa-solid fa-truck text-green-600 text-xs"></i>
                </div>
                <div>
                  <p class="text-[11px] font-bold text-gray-800 leading-none">Free Delivery</p>
                  <p class="text-[10px] text-gray-400 mt-0.5">On orders over Rs. 2000</p>
                </div>
              </div>
            </div>
          </div>

        </div>
      </section>


      <!-- hero below bar  -->
      <section class="bg-white border-b border-gray-100">
        <div class="w-[90vw] mx-auto py-5 grid grid-cols-2 md:grid-cols-4 divide-x divide-gray-100">

          <!-- Products -->
          <div class="px-6 flex items-center gap-3">
            <div class="w-9 h-9 rounded-lg bg-blue-50 flex items-center justify-center flex-shrink-0">
              <i class="fa-solid fa-box text-blue-500 text-sm"></i>
            </div>
            <div>
              <p class="text-[10px] text-gray-400 font-semibold uppercase tracking-wide">Products</p>
              <p class="text-sm font-bold text-accent">500+</p>
            </div>
          </div>

          <!-- Delivery -->
          <div class="px-6 flex items-center gap-3">
            <div class="w-9 h-9 rounded-lg bg-green-50 flex items-center justify-center flex-shrink-0">
              <i class="fa-solid fa-truck text-green-500 text-sm"></i>
            </div>
            <div>
              <p class="text-[10px] text-gray-400 font-semibold uppercase tracking-wide">Delivery</p>
              <p class="text-sm font-bold text-accent">Nationwide</p>
            </div>
          </div>

          <!-- Khalti -->
          <div class="px-6 flex items-center gap-3">
            <div class="w-9 h-9 rounded-lg bg-red-50 flex items-center justify-center flex-shrink-0">
              <i class="fa-solid fa-paper-plane text-red-500 text-sm"></i>
            </div>
            <div>
              <p class="text-[10px] text-gray-400 font-semibold uppercase tracking-wide">Secure Pay</p>
              <p class="text-sm font-bold text-accent">Khalti & COD</p>
            </div>
          </div>

          <!-- Rewards -->
          <div class="px-6 flex items-center gap-3">
            <div class="w-9 h-9 rounded-lg bg-yellow-50 flex items-center justify-center flex-shrink-0">
              <i class="fa-solid fa-star text-yellow-500 text-sm"></i>
            </div>
            <div>
              <p class="text-[10px] text-gray-400 font-semibold uppercase tracking-wide">Rewards</p>
              <p class="text-sm font-bold text-accent">Points on every order</p>
            </div>
          </div>

        </div>
      </section>


      <!-- category section  -->
      <section class="w-[90vw] mx-auto py-14">
        <div class="flex items-center justify-between mb-8">
          <div>
            <p
              class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
            >
              Browse
            </p>
            <h2 class="text-2xl md:text-3xl font-bold text-accent">
              Shop by Category
            </h2>
          </div>
          <a
            href="${pageContext.request.contextPath}/products"
            class="text-sm text-gray-500 hover:text-accent transition hidden sm:flex items-center gap-1"
          >
            View all <i class="fa-solid fa-arrow-right text-xs"></i>
          </a>
        </div>

        <div
          class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4"
        >
          <c:forEach var="category" items="${categories}">
            <a
              href="${pageContext.request.contextPath}/products?categoryId=${category.id}"
              class="bg-primary border border-gray-200 rounded-2xl p-5 flex flex-col items-center gap-3 hover:border-accent hover:shadow-md transition-all duration-200 text-center"
            >
              <div
                class="w-14 h-14 rounded-xl bg-secondary flex items-center justify-center hover:bg-accent/5 transition-colors overflow-hidden"
              >
                <c:choose>
                  <c:when test="${not empty category.image}">
                    <img
                      src="${pageContext.request.contextPath}/uploads/${category.image}"
                      alt="${category.name}"
                      class="w-full h-full object-cover rounded-xl"
                    />
                  </c:when>
                  <c:otherwise>
                    <img
                      src="${pageContext.request.contextPath}/static/images/category-fallback.jpg"
                      alt="${category.name}"
                      class="w-full h-full object-cover rounded-xl"
                    />
                  </c:otherwise>
                </c:choose>
              </div>

              <span
                class="text-sm font-semibold text-gray-700 hover:text-accent transition-colors"
              >
                <c:out value="${category.name}" />
              </span>
            </a>
          </c:forEach>

          <!-- else condition to show if there are no categories -->
          <c:if test="${empty categories}">
            <p class="col-span-full text-sm text-gray-400 text-center py-10">
              No categories found.
            </p>
          </c:if>
        </div>
      </section>


      <section class="bg-primary border-y border-gray-100">
        <div class="w-[90vw] mx-auto py-14">
          <div class="flex items-center justify-between mb-8">
            <div>
              <p
                class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
              >
                Handpicked
              </p>
              <h2 class="text-2xl md:text-3xl font-bold text-accent">
                Featured Products
              </h2>
            </div>
            <a
              href="${pageContext.request.contextPath}/products?featured=true"
              class="text-sm text-gray-500 hover:text-accent transition hidden sm:flex items-center gap-1"
            >
              View all <i class="fa-solid fa-arrow-right text-xs"></i>
            </a>
          </div>

          <div
            class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5"
          >
            <c:forEach var="product" items="${featuredProducts}" begin="0" end="3">
              <a
                href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
                class="bg-secondary border border-gray-100 rounded-2xl overflow-hidden hover:shadow-lg hover:border-gray-300 transition-all duration-200 flex flex-col"
              >
                <!-- image -->

                <div
                  class="relative w-full aspect-square overflow-hidden bg-white"
                >
                <c:choose>
                  <c:when test="${not empty product.image}">
                <img
                  src="${pageContext.request.contextPath}/uploads/${product.image}"
                  alt="<c:out value='${product.name}'/>"
                  class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                />
                </c:when>
                <c:otherwise>
                <img
                  src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                  alt="<c:out value='${product.name}'/>"
                  class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                />
                </c:otherwise>
              </c:choose>

                  <c:if test="${product.stock == 0}">
                    <span
                      class="absolute top-3 left-3 bg-danger text-white text-[10px] font-semibold px-2.5 py-1 rounded-full"
                    >
                      Out of Stock
                    </span>
                  </c:if>

                  <c:if test="${product.discountPrice > 0}">
                    <span
                      class="absolute top-3 right-3 bg-accent text-white text-[10px] font-semibold px-2.5 py-1 rounded-full"
                    >
                      SALE
                    </span>
                  </c:if>
                </div>

                <!-- price  & name -->
                <div class="p-4 flex flex-col gap-1 flex-1">
                  <p
                    class="text-[10px] font-semibold uppercase tracking-wider text-gray-400"
                  >
                    <c:out value="${product.categoryName}" />
                  </p>
                  <h4
                    class="text-sm font-semibold text-accent flex"
                  >
                    <c:out value="${product.name}" />
                  </h4>
                  <div class="mt-2 flex gap-2">
                    <c:choose>
                      <c:when test="${product.discountPrice > 0}">
                        <span class="text-base font-bold text-accent">
                          Rs.
                          <fmt:formatNumber
                            value="${product.discountPrice}"
                            pattern="#,##0"
                          />
                        </span>
                        <span class="text-xs text-gray-400 line-through">
                          Rs.
                          <fmt:formatNumber
                            value="${product.price}"
                            pattern="#,##0"
                          />
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="text-base font-bold text-accent">
                          Rs.
                          <fmt:formatNumber
                            value="${product.price}"
                            pattern="#,##0"
                          />
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </a>
            </c:forEach>

            <c:if test="${empty featuredProducts}">
              <p class="col-span-full text-sm text-gray-400 text-center py-10">
                No featured products at the moment.
              </p>
            </c:if>
          </div>
        </div>
      </section>




      <!-- promo banner  -->
       <c:if test="${empty sessionScope.user}">
         <div class="bg-accent rounded-3xl p-8 w-[90vw] mx-auto md:p-12 flex flex-col md:flex-row items-center justify-between gap-6 relative overflow-hidden">
           <!-- circle which appears on the top right corner of the banner -->
          <div
            class="absolute right-0 top-0 w-[100px] h-[100px] rounded-full bg-white/5"
          ></div>
          <div
            class="absolute right-0 bottom-0 w-32 h-32 rounded-full bg-white/5"
          ></div>

          <div class="text-center md:text-left">
            <p
              class="text-xs uppercase tracking-widest text-gray-400 mb-2 font-semibold"
            >
              Rewards Program
            </p>
            <h3 class="text-xl md:text-2xl font-bold text-white mb-2">
              Earn points on every purchase
            </h3>
            <p class="text-sm text-gray-400 max-w-sm">
              Sign up today and start collecting reward points. Redeem them for
              discounts on your next order.
            </p>
          </div>
          <div>
            <a
              href="${pageContext.request.contextPath}/register"
              class="inline-block bg-white text-accent text-sm font-bold px-8 py-3 rounded-xl hover:opacity-90 transition"
            >
              Create Free Account →
            </a>
          </div>
        </div>
      </section>
      </c:if>



      <!-- new products  -->
      <section class="w-[90vw] mx-auto py-14">
        <div class="flex items-center justify-between mb-8">
          <div>
            <p
              class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-1"
            >
              Just In
            </p>
            <h2 class="text-2xl md:text-3xl font-bold text-accent">
              New Arrivals
            </h2>
          </div>
          <a
            href="${pageContext.request.contextPath}/products?sort=newest"
            class="text-sm text-gray-500 hover:text-accent transition hidden sm:inline-flex items-center gap-1"
          >
            View all <i class="fa-solid fa-arrow-right text-xs"></i>
          </a>
        </div>

        <div
          class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5"
        >
          <c:forEach var="product" items="${recentProducts}" begin="0" end="3">
            <a
              href="${pageContext.request.contextPath}/product-detail?id=${product.id}"
              class="bg-primary border border-gray-200 rounded-2xl overflow-hidden hover:shadow-lg hover:border-gray-300 transition-all duration-200 flex flex-col"
            >
              <div
                class="relative w-full aspect-square overflow-hidden bg-secondary"
              >

              <c:choose>
                  <c:when test="${not empty product.image}">
                <img
                  src="${pageContext.request.contextPath}/uploads/${product.image}"
                  alt="<c:out value='${product.name}'/>"
                  class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                />
                </c:when>
                <c:otherwise>
                <img
                  src="${pageContext.request.contextPath}/static/images/product-fallback.jpg"
                  alt="<c:out value='${product.name}'/>"
                  class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                />
                </c:otherwise>
              </c:choose>

                <span
                  class="absolute top-3 left-3 bg-info text-white text-[10px] font-semibold px-2.5 py-1 rounded-full"
                >
                  NEW
                </span>
                <c:if test="${product.stock == 0}">
                  <span
                    class="absolute bottom-3 left-3 bg-danger text-white text-[10px] font-semibold px-2.5 py-1 rounded-full"
                  >
                    Out of Stock
                  </span>
                </c:if>
              </div>

              <div class="p-4 flex flex-col gap-1">
                <p
                  class="text-[10px] font-semibold uppercase tracking-wider text-gray-400"
                >
                  <c:out value="${product.categoryName}" />
                </p>
                <h4
                  class="text-sm font-semibold text-accent"
                >
                  <c:out value="${product.name}" />
                </h4>
                <div class="mt-2 flex gap-2">
                  <c:choose>
                    <c:when test="${product.discountPrice > 0}">
                      <span class="text-base font-bold text-accent">
                        Rs.
                        <fmt:formatNumber
                          value="${product.discountPrice}"
                          pattern="#,##0"
                        />
                      </span>
                      <span class="text-xs text-gray-400 line-through">
                        Rs.
                        <fmt:formatNumber
                          value="${product.price}"
                          pattern="#,##0"
                        />
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="text-base font-bold text-accent">
                        Rs.
                        <fmt:formatNumber
                          value="${product.price}"
                          pattern="#,##0"
                        />
                      </span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </a>
          </c:forEach>

          <c:if test="${empty recentProducts}">
            <p class="col-span-full text-sm text-gray-400 text-center py-10">
              No new arrivals yet.
            </p>
          </c:if>
        </div>


        <!-- mobile view browse all button -->
        <div class="flex justify-center gap-4 mt-8 sm:hidden">
          <a
            href="${pageContext.request.contextPath}/products"
            class="text-sm font-medium text-accent border border-accent rounded-xl px-6 py-2 hover:bg-accent hover:text-white transition"
          >
            Browse All Products
          </a>
        </div>
      </section>

      <!-- why to choose us section  -->
      <section class="bg-primary border-t border-gray-100">
        <div class="w-[90vw] mx-auto py-14">
          <div class="text-center mb-10">
            <p
              class="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-2"
            >
              Why Us
            </p>
            <h2 class="text-2xl md:text-3xl font-bold text-accent">
              Everything you need to build
            </h2>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
            <div class="bg-secondary rounded-2xl p-6 flex flex-col gap-3">
              <div
                class="w-10 h-10 rounded-xl bg-accent flex items-center justify-center"
              >
                <i class="fa-solid fa-boxes-stacked text-white text-sm"></i>
              </div>
              <h4 class="text-sm font-bold text-accent">Wide Selection</h4>
              <p class="text-xs text-gray-500 leading-relaxed">
                Hundreds of IoT components, kits, and ready-made devices from
                trusted brands.
              </p>
            </div>

            <div class="bg-secondary rounded-2xl p-6 flex flex-col gap-3">
              <div
                class="w-10 h-10 rounded-xl bg-accent flex items-center justify-center"
              >
                <i class="fa-solid fa-bolt text-white text-sm"></i>
              </div>
              <h4 class="text-sm font-bold text-accent">Fast Processing</h4>
              <p class="text-xs text-gray-500 leading-relaxed">
                Orders are confirmed and shipped quickly so you can start
                building sooner.
              </p>
            </div>

            <div class="bg-secondary rounded-2xl p-6 flex flex-col gap-3">
              <div
                class="w-10 h-10 rounded-xl bg-accent flex items-center justify-center"
              >
                <i class="fa-solid fa-wallet text-white text-sm"></i>
              </div>
              <h4 class="text-sm font-bold text-accent">Flexible Payment</h4>
              <p class="text-xs text-gray-500 leading-relaxed">
                Pay securely via Khalti digital wallet or choose Cash on
                Delivery.
              </p>
            </div>

            <div class="bg-secondary rounded-2xl p-6 flex flex-col gap-3">
              <div
                class="w-10 h-10 rounded-xl bg-accent flex items-center justify-center"
              >
                <i class="fa-solid fa-gift text-white text-sm"></i>
              </div>
              <h4 class="text-sm font-bold text-accent">Reward Points</h4>
              <p class="text-xs text-gray-500 leading-relaxed">
                Earn points with every purchase and redeem them for discounts on
                future orders.
              </p>
            </div>
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
