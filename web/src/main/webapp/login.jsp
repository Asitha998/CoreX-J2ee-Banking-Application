<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CoreX Banking</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts - Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CoreX Theme Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body class="flex flex-col min-h-screen">

<%-- Include Header Component --%>
<%@ include file="components/header.jspf" %>

<div class="flex-grow flex items-center justify-center w-full px-4 py-8">
    <div class="login-card p-8 rounded-2xl shadow-xl w-full max-w-sm">
        <div class="text-center mb-8">
            <i class="fas fa-university text-gold text-5xl mb-4"></i>
            <h1 class="text-3xl font-extrabold text-gold">CoreX Banking</h1>
            <p class="text-lg text-medium-gray mt-2">Secure Login</p>
        </div>

        <%-- Display Error Message if present --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
        <div class="error-message border px-4 py-3 rounded relative mb-6" role="alert">
            <strong class="font-bold">Login Failed!</strong>
            <span class="block sm:inline"><%= errorMessage %></span>
        </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-5">
            <div class="relative input-group">
                <i class="fas fa-user absolute icon"></i>
                <input type="text" name="username" placeholder="Email or Username" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <div class="relative input-group">
                <i class="fas fa-lock absolute icon"></i>
                <input type="password" name="password" placeholder="Password" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>

            <div class="flex items-center justify-between text-sm text-medium-gray">
                <label class="flex items-center">
                    <input type="checkbox" name="rememberMe"
                           class="form-checkbox h-4 w-4 text-gold rounded focus:ring-gold">
                    <span class="ml-2">Remember me</span>
                </label>
                <a href="#" class="text-gold hover:underline transition duration-200">Forgot Password?</a>
            </div>

            <button type="submit"
                    class="w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300">
                Sign In
            </button>
        </form>

        <div class="text-sm text-center mt-6 text-medium-gray">
            New to CoreX? <a href="${pageContext.request.contextPath}/register.jsp"
                             class="text-gold font-medium hover:underline transition duration-200">Create account</a>
        </div>
    </div>
</div>

<%@ include file="components/footer.jspf" %>

</body>
</html>
