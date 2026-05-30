<%@ page contentType="text/html;charset=UTF-8" %> <%@ taglib prefix="c"
uri="jakarta.tags.core" %> <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
      <jsp:param name="title" value="My Orders - NEO-HUB" />
      <jsp:param
        name="metaDescription"
        value="View your order history and track your purchases."
      />
      <jsp:param name="metaKeywords" value="orders, history, NEO-HUB" />
      <jsp:param name="metaAuthor" value="NEO-HUB Team" />
    </jsp:include>
  </head>
  <body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
      <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10 md:my-20 min-h-[50vh]">
      <h1 class="text-2xl md:text-3xl font-bold text-accent mb-8">My Orders</h1>
      <!-- filter  -->
      <div
        class="bg-white border border-gray-200 rounded-2xl p-5 mb-6 shadow-sm"
      >
        <div class="flex flex-wrap items-end gap-6">
          <div class="flex flex-col gap-1.5">
           
            <label
              class="text-[11px] font-medium text-gray-800 uppercase tracking-widest"
              >Status</label
            >
            <select
              name="status"
              id="status"
              hx-get="${pageContext.request.contextPath}/order-history"
              hx-trigger="change"
              hx-target="#order-table"
              hx-swap="innerHTML"
              hx-include="#status, [name='paymentMethod']:checked"
              class="h-9 px-6 bg-white border border-gray-200 text-sm text-accent rounded-xl cursor-pointer"
            >
              <option value="all">All Orders</option>
              <option value="delivered">Delivered</option>
              <option value="cancelled">Cancelled</option>
              <option value="shipped">Shipped</option>
              <option value="processing">Processing</option>
              <option value="confirmed">Confirmed</option>
            </select>
          </div>

          <!-- payment method  -->
          <div class="flex flex-col gap-1.5">
            <label
              class="text-[11px] font-medium text-gray-800 uppercase tracking-widest"
              >Payment method</label
            >
            <div class="flex flex-wrap gap-2">
              <label
                class="flex items-center gap-2 px-4 py-1.5 rounded-full border border-gray-200 cursor-pointer text-sm text-gray-500"
              >
                <input
                  type="radio"
                  name="paymentMethod"
                  value="all"
                  checked
                  hx-get="${pageContext.request.contextPath}/order-history"
                  hx-trigger="change"
                  hx-target="#order-table"
                  hx-swap="innerHTML"
                  hx-include="#status, [name='paymentMethod']"
                  class="hidden"
                />
                All
              </label>
              <label
                class="flex items-center gap-2 px-4 py-1.5 rounded-full border border-gray-200 cursor-pointer text-sm text-gray-500"
              >
                <input
                  type="radio"
                  name="paymentMethod"
                  value="Khalti"
                  hx-get="${pageContext.request.contextPath}/order-history"
                  hx-trigger="change"
                  hx-target="#order-table"
                  hx-swap="innerHTML"
                  hx-include="#status, [name='paymentMethod']"
                  class="hidden"
                />
                <i class="fa-solid fa-paper-plane text-red-500 text-xs"></i>
                Khalti
              </label>
              <label
                class="flex items-center gap-2 px-4 py-1.5 rounded-full border border-gray-200 cursor-pointer text-sm text-gray-500"
              >
                <input
                  type="radio"
                  name="paymentMethod"
                  value="CashOnDelivery"
                  hx-get="${pageContext.request.contextPath}/order-history"
                  hx-trigger="change"
                  hx-target="#order-table"
                  hx-swap="innerHTML"
                  hx-include="#status, [name='paymentMethod']"
                  class="hidden"
                />
                <i
                  class="fa-solid fa-money-bill-wave text-green-600 text-xs"
                ></i>
                Cash on delivery
              </label>
            </div>
          </div>

          <!-- reset -->
          <a
            href="${pageContext.request.contextPath}/order-history"
            class="ml-auto flex items-center gap-1.5 text-xs text-red-500 hover:text-accent border border-gray-200 hover:border-accent/30 rounded-xl px-3 py-2 transition self-end"
          >
            <i class="fa-solid fa-rotate-right text-[10px]"></i> Reset
          </a>
        </div>
      </div>
      <div id="order-table">
        <c:choose>
        <c:when test="${empty orders}">
          <div
            class="bg-white rounded-2xl border border-gray-200 p-12 text-center"
          >
            <i class="fa-solid fa-receipt text-5xl text-gray-300 mb-4"></i>
            <p class="text-gray-500 mb-4">You have no orders yet.</p>
            <a
              href="${pageContext.request.contextPath}/products"
              class="inline-block bg-accent text-white px-6 py-3 rounded-xl hover:opacity-90 transition"
            >
              Start Shopping
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div
            class="bg-white rounded-2xl border border-gray-200 overflow-hidden"
          >
            <div class="overflow-x-auto">
              <jsp:include
                page="/WEB-INF/views/user/components/order-history-list.jsp"
              />
            </div>
          </div>
        </c:otherwise>
      </c:choose>
      </div>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
  </body>
</html>
