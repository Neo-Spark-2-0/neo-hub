<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<head>
    <title><c:out value="${param.title}" /></title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="${param.metaDescription}" />
    <meta name="keywords" content="${param.metaKeywords}" />
    <meta name="author" content="${param.metaAuthor}" />
    <jsp:include page="/WEB-INF/views/common/import.jsp" />
</head>

