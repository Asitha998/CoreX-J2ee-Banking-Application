<%@ page import="com.asitha.bank.core.model.Transaction" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.asitha.bank.core.model.FavoriteTransfer" %>
<%@ page import="com.asitha.bank.core.model.ScheduledTransfer" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Transfer - CoreX Banking</title>
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
        <h2 class="text-3xl font-extrabold text-gold mb-8 flex items-center justify-center">
            <i class="fas fa-check-circle mr-3 text-4xl"></i> Confirm Your Transfer
        </h2>

        <%
            Transaction tx = (Transaction) session.getAttribute("pendingTx");
            String otpErrorMessage = (String) request.getAttribute("otpErrorMessage");
            String otpSuccessMessage = (String) request.getAttribute("otpSuccessMessage");

            FavoriteTransfer fav = (FavoriteTransfer) session.getAttribute("pendingFav");
            ScheduledTransfer sd = (ScheduledTransfer) session.getAttribute("pendingSd");
        %>

        <% if (otpSuccessMessage != null && !otpSuccessMessage.isEmpty()) { %>
        <div class="bg-green-700 text-white px-4 py-3 rounded relative mb-4" role="alert">
            <strong class="font-bold">Success!</strong>
            <span class="block sm:inline"><%= otpSuccessMessage %></span>
        </div>
        <% } else if (otpErrorMessage != null && !otpErrorMessage.isEmpty()) { %>
        <div class="error-message border px-4 py-3 rounded relative mb-4" role="alert">
            <strong class="font-bold">OTP Error!</strong>
            <span class="block sm:inline"><%= otpErrorMessage %></span>
        </div>
        <% } %>

        <% if (fav != null) { %>

        <%--        add new fav--%>
        <div class="text-left space-y-3 mb-8 text-light-gray text-lg">
            <p><strong class="text-gold"><i
                    class="fas fa-user-circle mr-2 text-sm"></i>Nickname:</strong> <%=fav.getNickname()%>
            </p>
            <p><strong class="text-gold"><i
                    class="fas fa-user-circle mr-2 text-sm"></i>From:</strong> <%=fav.getFromAccount().getAccountNumber()%>
            </p>
            <p><strong class="text-gold"><i
                    class="fas fa-arrow-alt-circle-right mr-2 text-sm"></i>To:</strong> <%=fav.getToAccount().getAccountNumber()%>
            </p>
            <p><strong class="text-gold"><i class="fas fa-arrow-alt-circle-right mr-2 text-sm"></i> Receiver Name
                :</strong> <%=fav.getToAccount().getOwner().getCustomer().getFullName()%>
            </p>
            <p><strong class="text-gold"><i
                    class="fas fa-calendar-alt mr-2 text-sm"></i>Date:</strong> <%= fav.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
            </p>
        </div>
        <% } else if (sd != null) { %>

        <%--        add new schedule--%>
        <div class="text-left space-y-3 mb-8 text-light-gray text-lg">
            <p><strong class="text-gold"><i
                    class="fas fa-tag mr-2 text-sm"></i>Nickname:</strong> <%= sd.getNickname() %>
            </p>
            <p><strong class="text-gold"><i
                    class="fas fa-credit-card mr-2 text-sm"></i>From:</strong> <%= sd.getFromAccount().getAccountNumber() %>
            </p>
            <p><strong class="text-gold"><i
                    class="fas fa-arrow-alt-circle-right mr-2 text-sm"></i>To:</strong> <%= sd.getToAccount().getAccountNumber() %>
            </p>
            <p><strong class="text-gold"><i class="fas fa-user-circle mr-2 text-sm"></i>Receiver
                Name:</strong> <%= sd.getToAccount().getOwner().getCustomer().getFullName() %>
            </p>
            <p><strong class="text-gold"><i class="fas fa-coins mr-2 text-sm"></i>Amount:</strong>
                Rs. <%= sd.getAmount() %>
            </p>
            <p><strong class="text-gold"><i class="fas fa-calendar-alt mr-2 text-sm"></i>Schedule
                Type:</strong> <%= sd.getScheduleType() %>
            </p>

            <%-- Schedule Detail --%>
            <%
                switch (sd.getScheduleType()) {
                    case WEEKLY:
                        String weekday = DayOfWeek.of(sd.getScheduleDay()).name();
            %>
            <p><strong class="text-gold"><i
                    class="fas fa-clock mr-2 text-sm"></i>Day:</strong> <%= weekday.substring(0, 1) + weekday.substring(1).toLowerCase() %>
            </p>
            <%
                    break;

                case MONTHLY:
            %>
            <p><strong class="text-gold"><i class="fas fa-calendar-day mr-2 text-sm"></i>Day of
                Month:</strong> <%= sd.getScheduleDay() %>
            </p>
            <%
                    break;

                case YEARLY:
            %>
            <p><strong class="text-gold"><i class="fas fa-calendar-day mr-2 text-sm"></i>Date:</strong>
                <%= sd.getExactDate().format(DateTimeFormatter.ofPattern("MM-dd")) %>
            </p>
            <%
                    break;

                case ONCE:
            %>
            <p><strong class="text-gold"><i class="fas fa-calendar-day mr-2 text-sm"></i>Date:</strong>
                <%= sd.getExactDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %>
            </p>
            <%
                        break;
                }
            %>

            <p><strong class="text-gold"><i class="fas fa-calendar-check mr-2 text-sm"></i>Created
                At:</strong> <%= sd.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %>
            </p>
        </div>

        <%} else { %>

        <%--        confirm normal transfer--%>
        <div class="text-left space-y-3 mb-8 text-light-gray text-lg">
            <p><strong class="text-gold"><i class="fas fa-user-circle mr-2 text-sm"></i>From
                :</strong> <%= tx != null ? tx.getFromAccount().getOwner().getCustomer().getFullName() : "N/A" %>
            </p>
            <p><strong class="text-gold"><i class="fas fa-arrow-alt-circle-right mr-2 text-sm"></i>To
                :</strong> <%= tx != null ? tx.getToAccount().getAccountNumber() : "N/A" %>
            </p>
            <p><strong class="text-gold"><i class="fas fa-arrow-alt-circle-right mr-2 text-sm"></i> Receiver Name
                :</strong> <%= tx != null ? tx.getToAccount().getOwner().getCustomer().getFullName() : "N/A" %>
            </p>
            <p><strong class="text-gold"><i class="fas fa-coins mr-2 text-sm"></i>Amount
                :</strong> <span class="text-success">Rs. <%= tx != null ? tx.getAmount() : "N/A" %></span></p>
            <p><strong class="text-gold"><i class="fas fa-calendar-alt mr-2 text-sm"></i>Date
                :</strong> <%= tx != null ? tx.getTimestamp().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) : "N/A" %>
            </p>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/user/send-otp" method="post" class="space-y-4 mb-6"
                <%=tx != null && tx.getOtp().equals("Fav") ? "hidden" : ""%>>
            <button type="submit"
                    class="w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center justify-center">
                <i class="fas fa-paper-plane mr-2"></i> Request OTP
            </button>
        </form>

        <c:if test="${not empty param.error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <strong>Error:</strong> ${param.error}
            </div>
        </c:if>

        <% if (fav != null) { %>
        <form action="${pageContext.request.contextPath}/user/add-new-fav-otp" method="post" class="space-y-4">

                <% } else if (sd != null) { %>
            <form action="${pageContext.request.contextPath}/user/add-new-sd-otp" method="post" class="space-y-4">

                    <% } else { %>
                <form action="${pageContext.request.contextPath}/user/confirm-otp" method="post" class="space-y-4">

                    <% } %>

                    <label class="block" <%=tx != null && tx.getOtp().equals("Fav") ? "hidden" : ""%>>
                        <span class="text-light-gray text-sm font-medium mb-1 block text-left">Enter OTP</span>
                        <div class="relative input-group"
                                <%=tx != null && tx.getOtp().equals("Fav") ? "hidden" : ""%>>
                            <i class="fas fa-key absolute icon"></i>
                            <input type="text" name="otp" placeholder="Enter One-Time Password"
                                    <%=tx != null && tx.getOtp().equals("Fav") ? "" : "required"%>
                                   class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                        </div>
                    </label>

                    <button type="submit"
                            class="w-full bg-gray-700 text-light-gray px-5 py-3 rounded-lg hover:bg-gray-600 font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition duration-300 flex items-center justify-center">
                        <i class="fas fa-lock mr-2"></i><%= fav != null ? "Add New Favorite" : (sd != null ? "Schedule Transfer" : "Confirm Transfer") %>
                    </button>

                </form>
    </main>
</div>

<%@ include file="../components/footer.jspf" %>

</body>
</html>
