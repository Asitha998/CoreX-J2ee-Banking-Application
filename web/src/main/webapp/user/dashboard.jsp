<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - CoreX</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Font: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Your custom CSS, if any. Ensure it complements Tailwind. -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

</head>
<body class="flex flex-col min-h-screen bg-gray-900 text-gray-100 font-inter">

<%@ include file="../components/header.jspf" %>

<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-12">

    <div class="bg-gray-800 rounded-xl p-8 mb-10 shadow-lg border border-gray-700 flex flex-col sm:flex-row justify-between items-start sm:items-center">
        <div>
            <h1 class="text-4xl sm:text-5xl font-extrabold text-gold leading-tight mb-3">
                Welcome, <c:out value="${pageContext.request.userPrincipal.name}"/>!
            </h1>
            <p class="text-lg text-medium-gray">
                Your financial overview at a glance. Manage your accounts and transactions effortlessly.
            </p>
        </div>

        <c:if test="${isAdmin}">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="mt-6 sm:mt-0 px-6 py-3 bg-clear text-gold rounded-lg font-semibold shadow-md transition duration-300 transform hover:scale-105 flex items-center justify-center whitespace-nowrap group">
                <i class="fas fa-user-shield mr-2"></i> Admin Panel
                <i class="fas fa-arrow-right ml-2 text-sm transform translate-x-0 group-hover:translate-x-1 transition-transform duration-200"></i>
            </a>
        </c:if>
    </div>

    <!-- Account Cards Section -->
    <section class="mb-10">
        <h2 class="text-3xl font-bold text-light-gray mb-6 flex items-center">
            <i class="fas fa-university mr-3 text-gold"></i> Your Accounts
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach var="account" items="${accounts}">
                <div class="content-card rounded-xl p-7 hover:shadow-xl transition duration-300 ease-in-out transform hover:-translate-y-1 group">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-xl font-semibold text-light-gray flex items-center">
                            <i class="fas fa-wallet text-gold mr-3 text-2xl"></i>
                                ${account.type == "SAVINGS" ? "Savings Account" : "Current Account"}
                        </h3>
                        <span class="text-sm text-medium-gray bg-gray-700 px-3 py-1 rounded-full">
                                #<c:out value="${account.accountNumber}"/>
                            </span>
                    </div>
                    <p class="text-md text-medium-gray mb-2">Current Balance:</p>
                    <p class="text-4xl font-extrabold text-success mb-5">
                        Rs. <c:out value="${account.balance}"/>
                    </p>
                    <a href="${pageContext.request.contextPath}/user/account?acc=${account.accountNumber}"
                       class="text-gold hover:text-yellow-400 text-base font-medium flex items-center transition duration-200">
                        View Details
                        <i class="fas fa-arrow-right ml-2 text-sm transform translate-x-0 group-hover:translate-x-1 transition-transform duration-200"></i>
                    </a>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Action Buttons Section -->
    <section>
        <h2 class="text-3xl font-bold text-light-gray mb-6 flex items-center">
            <i class="fas fa-cogs mr-3 text-gold"></i> Quick Actions
        </h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <a href="${pageContext.request.contextPath}/user/createAccount.jsp"
               class="bg-green-600 text-white px-7 py-4 rounded-lg hover:bg-green-700 font-semibold shadow-lg flex items-center justify-center transition duration-300 transform hover:scale-105">
                <i class="fas fa-plus mr-3 text-lg"></i> Create New Account
            </a>
            <a href="${pageContext.request.contextPath}/user/transfer.jsp"
               class="btn-primary px-7 py-4 rounded-lg font-semibold shadow-lg flex items-center justify-center transition duration-300 transform hover:scale-105">
                <i class="fas fa-exchange-alt mr-3 text-lg"></i> Transfer Funds
            </a>
            <a href="${pageContext.request.contextPath}/user/transactions"
               class="btn-secondary px-7 py-4 rounded-lg font-semibold shadow-lg flex items-center justify-center transition duration-300 transform hover:scale-105">
                <i class="fas fa-history mr-3 text-lg"></i> View Transactions
            </a>
            <a href="${pageContext.request.contextPath}/user/favorites"
               class="btn-secondary px-7 py-4 rounded-lg font-semibold shadow-lg flex items-center justify-center transition duration-300 transform hover:scale-105">
                <i class="fas fa-star mr-3 text-lg"></i> Favourite & Scheduled Transfers
            </a>
        </div>
    </section>
</main>

<%-- Include Footer Component --%>
<%@ include file="../components/footer.jspf" %>

<style>
    /* Custom styles to ensure Inter font is applied globally and define custom colors */
    body {
        font-family: 'Inter', sans-serif;
        background-color: #1a202c; /* Darker background for a premium feel */
        color: #e2e8f0; /* Light gray for general text */
    }

    .text-gold {
        color: #FFD700; /* Gold color */
    }

    .bg-gold {
        background-color: #FFD700;
    }

    .hover\:bg-yellow-500:hover {
        background-color: #fcd34d; /* Lighter yellow for hover */
    }

    .text-light-gray {
        color: #cbd5e0;
    }

    .text-medium-gray {
        color: #a0aec0;
    }

    .text-success {
        color: #34D399; /* Green for success/positive values */
    }

    .content-card {
        background-color: #2d3748; /* Darker card background */
        border: 1px solid #4a5568; /* Subtle border */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Soft shadow */
    }

    .content-card:hover {
        transform: translateY(-3px); /* Slight lift on hover */
        box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2); /* More pronounced shadow on hover */
    }

    .btn-primary {
        background-color: #4299e1; /* Blue for primary actions */
        color: white;
    }

    .btn-primary:hover {
        background-color: #3182ce; /* Darker blue on hover */
    }

    .btn-secondary {
        background-color: #4a5568; /* Dark gray for secondary actions */
        color: #cbd5e0;
    }

    .btn-secondary:hover {
        background-color: #2d3748; /* Even darker gray on hover */
    }
</style>

</body>
</html>
