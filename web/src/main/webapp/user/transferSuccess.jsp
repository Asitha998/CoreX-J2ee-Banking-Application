<%@ page import="com.asitha.bank.core.model.Transaction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Success - CoreX Banking</title>
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

<div class="flex-grow flex items-center justify-center w-full px-4 py-8">
    <main class="max-w-xl w-full content-card rounded-2xl shadow-xl p-8 text-center">
        <h2 class="text-3xl font-extrabold text-gold mb-6 flex items-center justify-center">
            <i class="fas fa-check-circle mr-3 text-4xl text-success"></i> Transaction Successful!
        </h2>

        <%
            Transaction tx = (Transaction) session.getAttribute("pendingTx");
        %>

        <div class="text-left space-y-3 mb-8 text-light-gray text-lg">
            <p><strong class="text-gold"><i class="fas fa-user-circle mr-2 text-sm"></i>From Account:</strong> <%= tx != null ? tx.getFromAccount().getAccountNumber() : "N/A" %></p>
            <p><strong class="text-gold"><i class="fas fa-arrow-alt-circle-right mr-2 text-sm"></i>To Account:</strong> <%= tx != null ? tx.getToAccount().getAccountNumber() : "N/A" %></p>
            <p><strong class="text-gold"><i class="fas fa-user mr-2 text-sm"></i>To Name:</strong> <%= tx != null ? tx.getToAccount().getOwner().getCustomer().getFullName() : "N/A" %></p>
            <p><strong class="text-gold"><i class="fas fa-coins mr-2 text-sm"></i>Amount:</strong> <span class="text-success">Rs. <%= tx != null ? tx.getAmount() : "N/A" %></span></p>
            <p><strong class="text-gold"><i class="fas fa-calendar-alt mr-2 text-sm"></i>Date:</strong> <%= tx != null ? tx.getTimestamp() : "N/A" %></p>
        </div>

        <p class="text-lg text-light-gray mb-8">Thank you. Your transaction has been completed successfully.</p>

        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn-primary px-6 py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center justify-center mx-auto max-w-xs">
            <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
        </a>
    </main>
</div>

<%@ include file="../components/footer.jspf" %>

</body>
</html>
