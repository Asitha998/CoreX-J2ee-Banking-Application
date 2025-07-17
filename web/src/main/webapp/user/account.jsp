<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Details - CoreX</title>
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

<%@ include file="../components/header.jspf" %>

<main class="flex-grow max-w-3xl mx-auto px-6 py-12">
    <h1 class="text-2xl font-bold text-gold mb-6 flex items-center">
        <i class="fas fa-credit-card mr-3"></i> Account #<c:out value="${account.accountNumber}"/>
    </h1>

    <div class="content-card p-6 rounded-xl shadow space-y-4">
        <div class="text-light-gray text-lg">
            <p class="mb-2"><strong class="text-gold"><i class="fas fa-typo3 mr-2 text-sm"></i>Account Type:</strong> <c:out value="${account.type}"/></p>
            <p class="mb-2"><strong class="text-gold"><i class="fas fa-user mr-2 text-sm"></i>Account Holder:</strong> <c:out value="${account.owner.customer.fullName}"/></p>
            <p class="mb-2"><strong class="text-gold"><i class="fas fa-envelope mr-2 text-sm"></i>Email:</strong> <c:out value="${account.owner.customer.email}"/></p>
            <p><strong class="text-gold"><i class="fas fa-phone mr-2 text-sm"></i>Contact:</strong> <c:out value="${account.owner.customer.contact}"/></p>
        </div>

        <div class="text-4xl font-extrabold text-success mt-4 flex items-center">
            <i class="fas fa-money-bill-wave mr-3"></i> Rs. <c:out value="${account.balance}"/> /=
        </div>
    </div>

    <div class="mt-8 flex flex-wrap gap-4">
        <a href="${pageContext.request.contextPath}/user/transfer.jsp" class="btn-primary px-6 py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center">
            <i class="fas fa-paper-plane mr-2"></i> Transfer Money
        </a>
        <a href="${pageContext.request.contextPath}/user/transactions?acc=${account.accountNumber}" class="bg-gray-700 text-light-gray px-6 py-3 rounded-lg hover:bg-gray-600 font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition duration-300 flex items-center">
            <i class="fas fa-history mr-2"></i> View Transactions
        </a>
    </div>
</main>

<%@ include file="../components/footer.jspf" %>

</body>
</html>
