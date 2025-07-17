<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.asitha.bank.core.service.CustomerService" %>
<%@ page import="com.asitha.bank.core.model.Account" %>
<%@ page import="java.util.List" %>
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
    <title>Transfer Funds - CoreX</title>
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

<main class="flex-grow max-w-xl mx-auto px-6 py-12">
    <h1 class="text-2xl font-semibold text-gold mb-6 flex items-center">
        <i class="fas fa-paper-plane mr-3"></i> Transfer Funds
    </h1>

    <div class="content-card rounded-xl p-6 space-y-5">

        <c:if test="${not empty param.error}">

            <div class="error-message border px-4 py-3 rounded relative mb-4" role="alert">
                <strong>Error!</strong>
                <span class="block sm:inline"> ${param.error}</span>
            </div>

        </c:if>

        <%
            try {
                InitialContext ic = new InitialContext();
                CustomerService customerService = (CustomerService) ic.lookup("com.asitha.bank.core.service.CustomerService");
                String username = request.getUserPrincipal().getName();
                List<Account> accounts = customerService.getAccountsByUsername(username);
                pageContext.setAttribute("accounts", accounts);
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }

            String fromAccNo = request.getParameter("fromAccNo");
            String toAccNo = request.getParameter("toAccNo");
            String isFavorite = request.getParameter("isFavorite");
            String nickname = request.getParameter("nickname");
        %>

        <form action="${pageContext.request.contextPath}/user/transfer" method="post" class="space-y-5">

            <span class="text-light-gray text-sm font-medium mb-1 block">Favorite Transfer:  <c:if
                    test="${param.nickname != null}">${param.nickname}</c:if></span>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">From Account</span>
                <div class="relative input-group">
                    <i class="fas fa-credit-card absolute icon"></i>
                    <select name="fromAccount"
                            class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"
                            style="color:white;background-color: #2a2a2a;padding-left: 30px">
                        <c:forEach var="acc" items="${accounts}">
                            <c:set var="accNo" value="${acc.accountNumber}"/>
                            <option value="${accNo}"
                                    class="bg-gray-800 text-light-gray"
                                    <c:if test="${param.fromAccNo == accNo}">selected</c:if>>
                                    ${accNo} - Rs. ${acc.balance}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </label>

            <%-- To Account --%>
            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">To Account Number</span>
                <div class="relative input-group">
                    <i class="fas fa-user-circle absolute icon"></i>
                    <input type="text"
                           name="toAccount"
                           value="<%= toAccNo != null ? toAccNo : "" %>"
                            <%= toAccNo != null ? "readonly" : "" %>
                           placeholder="Recipient Account Number"
                           required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200 bg-gray-700 text-white"/>
                </div>
            </label>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">Amount (Rs.)</span>
                <div class="relative input-group">
                    <i class="fas fa-coins absolute icon"></i>
                    <input type="number" name="amount" min="1" placeholder="Enter amount" required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                </div>
            </label>

            <%-- Hidden Favorite Flag --%>
            <% if (isFavorite != null) { %>
            <input type="hidden" name="isFavorite" value="true"/>
            <% } else { %>
            <input type="hidden" name="isFavorite" value="false"/>
            <% } %>

            <button type="submit"
                    class="w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center justify-center">
                <i class="fas fa-paper-plane mr-2"></i> Send Funds
            </button>
        </form>
    </div>
</main>

<%@ include file="../components/footer.jspf" %>

</body>
</html>

