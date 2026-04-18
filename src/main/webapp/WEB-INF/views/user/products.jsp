<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="NEO-HUB | Products" />
        <jsp:param name="metaDescription" value="Browse our collection of IoT equipment and projects at NEO-HUB. Find the perfect components for your next IoT adventure." />
        <jsp:param name="metaKeywords" value="IoT, Arduino, sensors, electronics, IoT kits, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="products" />
    </jsp:include>

    <main>
        <h1>Products page </h1>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>
