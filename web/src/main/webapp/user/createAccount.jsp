<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Open New Bank Account - CoreX Banking</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts - Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CoreX Theme Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>

    </style>
</head>
<body class="flex flex-col min-h-screen">

<%-- Include Header Component --%>
<%@ include file="../components/header.jspf" %>

<%-- Main content wrapper to allow footer to stick to bottom --%>
<div class="flex-grow flex items-center justify-center w-full px-4 py-8">
    <main class="max-w-5xl w-full flex flex-col md:flex-row page-container">
        <%-- Left Side: Image/Art (SVG) --%>
        <div class="image-side md:w-2/5">
            <img  src="../images/bkg02.png" style="width: auto;height: 100%" alt="">
        </div>

        <%-- Right Side: Form --%>
        <div class="form-side md:w-3/5">
            <h2 class="text-3xl font-extrabold text-gold mb-6 text-center flex items-center justify-center">
                <i class="fas fa-piggy-bank mr-3 text-4xl"></i> Open a CoreX Account
            </h2>
            <p class="text-lg text-medium-gray text-center mb-8">Start your financial journey with us.</p>

            <%-- Display Success/Error Message --%>
            <%
                String successMessage = (String) request.getAttribute("successMessage");
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (successMessage != null && !successMessage.isEmpty()) {
            %>
            <div class="bg-green-700 text-white px-4 py-3 rounded relative mb-4" role="alert">
                <strong class="font-bold">Success!</strong>
                <span class="block sm:inline"><%= successMessage %></span>
            </div>
            <%
            } else if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
            <div class="error-message border px-4 py-3 rounded relative mb-4" role="alert">
                <strong class="font-bold">Account Creation Failed!</strong>
                <span class="block sm:inline"><%= errorMessage %></span>
            </div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/create-account" method="post" class="space-y-5 text-left">
                <label class="block">
                    <span class="text-light-gray text-sm font-medium mb-1 block">Account Type</span>
                    <div class="relative input-group">
                        <i class="fas fa-wallet absolute icon"></i>
                        <select id="accountTypeSelect" name="type"
                                class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"
                                style="color:white;background-color: #2a2a2a;padding-left: 30px">
                            <option value="">-- Select Account Type --</option>
                            <option value="SAVINGS" class="bg-gray-800 text-light-gray">Savings Account</option>
                            <option value="CURRENT" class="bg-gray-800 text-light-gray">Current Account</option>
                        </select>
                    </div>
                </label>

                <label class="block">
                    <span class="text-light-gray text-sm font-medium mb-1 block">Initial Deposit (Rs.)</span>
                    <div class="relative input-group">
                        <i class="fas fa-coins absolute icon"></i>
                        <input type="number" name="balance" min="0" value="0"
                               class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                    </div>
                </label>
                <button type="submit"
                        class="w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center justify-center mt-6">
                    <i class="fas fa-plus-circle mr-2"></i> Create Account
                </button>
            </form>
        </div>
    </main>
</div>

<%@ include file="../components/footer.jspf" %>

</body>
</html>
