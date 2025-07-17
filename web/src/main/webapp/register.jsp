<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CoreX Banking</title>
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

<%@ include file="components/header.jspf" %>

<main class="flex-grow flex items-center justify-center w-full px-4 py-8">
    <div class="content-card p-8 rounded-2xl shadow-xl w-full max-w-xl">
        <div class="text-center mb-8">
            <i class="fas fa-user-plus text-gold text-5xl mb-4"></i>
            <h2 class="text-3xl font-extrabold text-gold">Create Your CoreX Account</h2>
            <p class="text-lg text-medium-gray mt-2">Join us today!</p>
        </div>

        <%-- Display Error Message if present --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
        <div class="error-message border px-4 py-3 rounded relative mb-6" role="alert">
            <strong class="font-bold">Registration Failed!</strong>
            <span class="block sm:inline"><%= errorMessage %></span>
        </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/register" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-5">
            <div class="relative input-group md:col-span-2">
                <i class="fas fa-signature absolute icon"></i>
                <input type="text" name="name" placeholder="Full Name" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <div class="relative input-group md:col-span-2">
                <i class="fas fa-envelope absolute icon"></i>
                <input type="email" name="email" placeholder="Email" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <div class="relative input-group md:col-span-2">
                <i class="fas fa-phone absolute icon"></i>
                <input type="text" name="contact" placeholder="Phone Number" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <div class="relative input-group md:col-span-2">
                <i class="fas fa-map-marker-alt absolute icon"></i>
                <input type="text" name="address_line1" placeholder="Address Line 1" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <div class="relative input-group md:col-span-2">
                <i class="fas fa-map-marked-alt absolute icon"></i>
                <input type="text" name="address_line2" placeholder="Address Line 2 (Optional)"
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <div class="relative input-group md:col-span-2">
                <i class="fas fa-lock absolute icon"></i>
                <input type="password" name="password" placeholder="Password" required
                       class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200">
            </div>
            <button type="submit"
                    class="md:col-span-2 w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300">
                Register Account
            </button>
        </form>
        <p class="text-sm text-center mt-6 text-medium-gray">Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp" class="text-gold font-medium hover:underline transition duration-200">Log in</a>
        </p>
    </div>
</main>

<%-- Include Footer Component --%>
<%@ include file="components/footer.jspf" %>
</body>
</html>
