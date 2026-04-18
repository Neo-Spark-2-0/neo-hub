<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="NEO-HUB | About Us" />
        <jsp:param name="metaDescription" value="Learn more about NEO-HUB and our mission to provide the best IoT equipment and projects." />
        <jsp:param name="metaKeywords" value="IoT, Arduino, sensors, electronics, IoT kits, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="about" />
    </jsp:include>

    <main>
        <h1>About Us</h1>
        <p>Welcome to NEO-HUB! We are dedicated to providing the best IoT equipment and projects for enthusiasts and professionals alike.</p>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>
