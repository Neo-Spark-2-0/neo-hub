<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/templates/common/head.jsp">
        <jsp:param name="title" value="NEO-HUB | Contact Us" />
        <jsp:param name="metaDescription" value="Get in touch with NEO-HUB for any inquiries or support." />
        <jsp:param name="metaKeywords" value="IoT, Arduino, sensors, electronics, IoT kits, NEO-HUB" />
        <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="contact" />
    </jsp:include>

    <main>
        <h1>Contact Us</h1>
        <p>We'd love to hear from you! If you have any questions or feedback, please don't hesitate to reach out to us.</p>
    </main>

    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>
