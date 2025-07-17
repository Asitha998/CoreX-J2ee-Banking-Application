<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- Added for date formatting --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CoreX</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Font: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Your custom CSS, if any. Ensure it complements Tailwind. -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

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

        /* Table specific styles */
        .table-header {
            background-color: #4a5568; /* Darker header background */
            color: #e2e8f0;
        }

        .table-row {
            border-bottom: 1px solid #4a5568; /* Separator between rows */
        }

        .table-row:last-child {
            border-bottom: none; /* No border for the last row */
        }

        .table-row:nth-child(even) {
            background-color: #2d3748; /* Slightly different background for even rows */
        }

        .table-row:hover {
            background-color: #3a475a; /* Hover effect for rows */
        }

        .table-cell {
            padding: 1rem; /* More padding for cells */
        }

        .text-info {
            color: #63b3ed; /* Light blue for info/roles */
        }

        .text-warning {
            color: #f6ad55; /* Orange for warning/pending */
        }

        .text-danger {
            color: #fc8181; /* Red for danger/failed */
        }
    </style>
</head>
<body class="flex flex-col min-h-screen bg-gray-900 text-gray-100 font-inter">

<%-- Include Header Component --%>
<%@ include file="../components/header.jspf" %>

<main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <!-- Admin Dashboard Welcome/Title Section -->
    <div class="bg-gray-800 rounded-xl p-8 mb-10 shadow-lg border border-gray-700">
        <h1 class="text-4xl sm:text-5xl font-extrabold text-gold leading-tight mb-3">
            Admin Dashboard
        </h1>
        <p class="text-lg text-medium-gray">
            Overview of system metrics and user management.
        </p>
    </div>

    <section class="mb-10">
        <h2 class="text-3xl font-bold text-light-gray mb-6 flex items-center">
            <i class="fas fa-tachometer-alt mr-3 text-gold"></i> System Overview
        </h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
            <div class="content-card rounded-xl p-7 flex items-center hover:shadow-xl transition duration-300 ease-in-out transform hover:-translate-y-1">
                <i class="fas fa-users text-gold text-4xl mr-5"></i>
                <div>
                    <p class="text-md text-medium-gray">Total Users</p>
                    <p class="text-3xl font-bold text-light-gray"><c:out value="${totalUsers}"/></p>
                </div>
            </div>
            <div class="content-card rounded-xl p-7 flex items-center hover:shadow-xl transition duration-300 ease-in-out transform hover:-translate-y-1">
                <i class="fas fa-piggy-bank text-gold text-4xl mr-5"></i>
                <div>
                    <p class="text-md text-medium-gray">Total Accounts</p>
                    <p class="text-3xl font-bold text-light-gray"><c:out value="${totalAccounts}"/></p>
                </div>
            </div>
            <div class="content-card rounded-xl p-7 flex items-center hover:shadow-xl transition duration-300 ease-in-out transform hover:-translate-y-1">
                <i class="fas fa-exchange-alt text-gold text-4xl mr-5"></i>
                <div>
                    <p class="text-md text-medium-gray">Daily
                        Transactions</p> <%-- Changed from Total to Daily as per the provided immersive --%>
                    <p class="text-3xl font-bold text-light-gray"><c:out value="${dailyTransactions}"/></p>
                </div>
            </div>
            <div class="content-card rounded-xl p-7 flex items-center hover:shadow-xl transition duration-300 ease-in-out transform hover:-translate-y-1">
                <i class="fas fa-chart-line text-gold text-4xl mr-5"></i>
                <div>
                    <p class="text-md text-medium-gray">System Uptime</p>
                    <p class="text-3xl font-bold text-success" id="uptimeDisplay" data-start-time="${serverStartTime}">Loading...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Users Table Section -->
    <section class="mb-10"> <%-- Added margin-bottom for spacing --%>
        <h2 class="text-3xl font-bold text-light-gray mb-6 flex items-center">
            <i class="fas fa-users-cog mr-3 text-gold"></i> Registered Users
        </h2>
        <div class="overflow-x-auto content-card rounded-xl p-6 max-h-96 overflow-y-auto">
            <table class="min-w-full text-sm text-left">
                <thead class="table-header sticky top-0 z-10"> <%-- Added sticky header --%>
                <tr>
                    <th class="px-6 py-4 rounded-tl-lg font-semibold">#</th>
                    <th class="px-6 py-4 font-semibold">Email</th>
                    <th class="px-6 py-4 font-semibold">Full Name</th>
                    <th class="px-6 py-4 rounded-tr-lg font-semibold">Roles</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}" varStatus="loop">
                    <tr class="table-row">
                        <td class="px-6 py-4 table-cell"><c:out value="${loop.index + 1}"/></td>
                        <td class="px-6 py-4 table-cell"><c:out value="${user.username}"/></td>
                        <td class="px-6 py-4 table-cell"><c:out value="${user.customer.fullName}"/></td>
                        <td class="px-6 py-4 table-cell">
                            <c:forEach var="role" items="${user.roles}">
                                        <span class="inline-block text-info bg-blue-900/50 px-3 py-1 rounded-full text-xs font-medium mr-2 mb-1">
                                            <c:out value="${role}"/>
                                        </span>
                            </c:forEach>
                        </td>
                    </tr>
                </c:forEach>
                <%-- Fallback for no users --%>
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="4" class="px-6 py-4 text-center text-medium-gray">No users registered yet.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>

    <section>
        <h2 class="text-3xl font-bold text-light-gray mb-6 flex items-center">
            <i class="fas fa-list-alt mr-3 text-gold"></i> All Transactions
        </h2>
        <div class="overflow-x-auto content-card rounded-xl p-6 max-h-96 overflow-y-auto">
            <table class="min-w-full text-sm text-left">
                <thead class="table-header sticky top-0 z-10">
                <tr>
                    <th class="px-6 py-4 rounded-tl-lg font-semibold">ID</th>
                    <th class="px-6 py-4 font-semibold">From Account</th>
                    <th class="px-6 py-4 font-semibold">To Account</th>
                    <th class="px-6 py-4 font-semibold">Amount</th>
                    <th class="px-6 py-4 font-semibold">Date</th>
                    <th class="px-6 py-4 rounded-tr-lg font-semibold">Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="transaction" items="${transactions}" varStatus="loop">
                    <tr class="table-row">
                        <td class="px-6 py-4 table-cell"><c:out value="${transaction.id}"/></td>
                        <td class="px-6 py-4 table-cell"><c:out value="${transaction.fromAccount.accountNumber}"/></td>
                        <td class="px-6 py-4 table-cell"><c:out value="${transaction.toAccount.accountNumber}"/></td>
                        <td class="px-6 py-4 table-cell">Rs. <c:out value="${transaction.amount}"/></td>
                        <td class="px-6 py-4 table-cell">
                            ${transaction.getFormattedTimestamp()}
                        </td>
                        <td class="px-6 py-4 table-cell">
                            <c:choose>
                                <c:when test="${transaction.otp == 'Verified'}">
                                    <span class="inline-block text-success bg-green-900/50 px-3 py-1 rounded-full text-xs font-medium">Verified</span>
                                </c:when>
                                <c:when test="${transaction.otp == 'AUTO'}">
                                    <span class="inline-block text-warning bg-yellow-900/50 px-3 py-1 rounded-full text-xs font-medium">Automatic</span>
                                </c:when>
                                <c:when test="${transaction.otp == 'Fav'}">
                                    <span class="inline-block text-danger bg-red-900/50 px-3 py-1 rounded-full text-xs font-medium">Favorite</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-block text-medium-gray bg-gray-700/50 px-3 py-1 rounded-full text-xs font-medium"><c:out
                                            value="${transaction.otp}"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty transactions}">
                    <tr>
                        <td colspan="7" class="px-6 py-4 text-center text-medium-gray">No transactions found yet.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>

<%@ include file="../components/footer.jspf" %>

<script>
    function formatUptime(ms) {
        const totalSeconds = Math.floor(Math.max(0, ms / 1000)); // Ensure non-negative
        const days = Math.floor(totalSeconds / (3600 * 24));
        const hours = Math.floor((totalSeconds % (3600 * 24)) / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);
        const seconds = totalSeconds % 60;

        let uptimeString = "";
        if (days > 0) {
            <%--uptimeString += `${days}d `;--%>
            uptimeString += days.toString()+"d "
        }
        if (hours > 0 || days > 0) {
            <%--uptimeString += `${hours}h `;--%>
            uptimeString += hours.toString()+"h "
        }
        if (minutes > 0 || hours > 0 || days > 0) {
            <%--uptimeString += `${minutes}m `;--%>
            uptimeString += minutes.toString()+"m "
        }
        <%--uptimeString += `${seconds}s`;--%>
        uptimeString += seconds.toString()+"s "

        console.log(uptimeString);

        return uptimeString.trim();
    }

    function updateUptime() {
        const display = document.getElementById("uptimeDisplay");
        if (!display) {
            console.error("Uptime display element not found.");
            return;
        }

        let startTime = Number(display.dataset.startTime);

        if (isNaN(startTime) || startTime <= 0) {
            console.warn("Invalid server start time. Displaying uptime from page load.");
            if (!window.pageLoadTime) {
                window.pageLoadTime = Date.now();
            }
            startTime = window.pageLoadTime;
        }

        const now = Date.now();
        const uptime = now - startTime;

        display.textContent = formatUptime(uptime);

        // console.log("Start Time:", display.dataset.startTime);
        // console.log("Parsed:", startTime);
        // console.log("UpTime:", uptime);
        // console.log("formattedTime:", display.textContent);
    }

    updateUptime();
    setInterval(updateUptime, 1000);
</script>

</body>
</html>
