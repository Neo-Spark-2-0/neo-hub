<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="NEO-HUB - Modern IOT E-Commerce Platform" />
    <meta name="author" content="NEO-HUB IOT Component Selling Platform" />
    <title>NEO-HUB</title>
    <%--     tailwind css--%>
    <script src="https://cdn.tailwindcss.com"></script>
    <%--toastify css and js --%>
    <%--  CSS --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.css" />
    <%-- Toastify JavaScript --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.12.0/toastify.js"></script>
    <%--    font awesome--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <%--    sweet alert --%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <%--    tailwind config--%>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#10B981',
                        accent: '#F59E0B',
                        dark: '#1F2937',
                        danger: '#EF4444',
                        warning: '#FBBF24',
                        info: '#06B6D4'
                    },
                    fontFamily: {
                        poppins: ['Poppins', 'sans-serif']
                    }
                }
            }
        }
    </script>
    <%--    main css --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css"/>
</head>
<body>
<h1>Bibek</h1>
<button onclick="showAlert()" class="bg-primary text-white px-4 py-2 rounded">
    Click Me
</button>
</body>
</html>
