<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - CoreX</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts - Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CoreX Theme Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body class="flex flex-col min-h-screen items-center justify-center">
<main class="flex-grow flex items-center justify-center w-full px-4 py-8">
    <div class="content-card shadow-xl rounded-xl p-8 max-w-lg text-center">
        <i class="fas fa-exclamation-triangle text-gold text-6xl mb-6"></i>
        <h1 class="text-3xl text-gold font-bold mb-4">Oops! Something went wrong.</h1>
        <p class="text-light-gray text-lg mb-6">An unexpected error occurred. Please try again later.</p>
        <c:if test="${not empty exception}">
            <div class="error-message border px-4 py-3 rounded relative mb-6 text-left">
                <strong class="font-bold">Error Details:</strong>
                <span class="block sm:inline"><%= exception.getMessage() %></span>
            </div>
        </c:if>
        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-primary px-6 py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300">
            <i class="fas fa-sign-in-alt mr-2"></i> Go to Login
        </a>
    </div>
</main>
</body>
</html>

