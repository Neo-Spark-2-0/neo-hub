<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/WEB-INF/templates/common/head.jsp">
    <jsp:param name="title" value="NEO-HUB | Home" />
    <jsp:param name="metaDescription" value="Welcome to NEO-HUB, your one-stop shop for IoT equipment and projects." />
    <jsp:param name="metaKeywords" value="IoT, Arduino, sensors, electronics, IoT kits, NEO-HUB" />
    <jsp:param name="metaAuthor" value="NEO-HUB Team, NEO-SPARK Team" />
</jsp:include>

<body class="font-poppins bg-secondary">
    <jsp:include page="/WEB-INF/templates/user/header.jsp">
        <jsp:param name="activePage" value="home" />
    </jsp:include>

    <main class="w-[90vw] mx-auto my-10">
        <h1>Home page </h1>
    </main>


    <jsp:include page="/WEB-INF/templates/user/footer.jsp" />
</body>
</html>