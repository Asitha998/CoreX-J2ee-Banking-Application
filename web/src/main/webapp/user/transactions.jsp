<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Transaction History - CoreX</title>
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

<main class="flex-grow max-w-5xl mx-auto px-6 py-12">
  <h1 class="text-2xl font-semibold text-gold mb-6 flex items-center">
    <i class="fas fa-history mr-3"></i> Your Transactions
  </h1>

  <!-- Tabs -->
  <div class="flex space-x-4 mb-6">
    <a href="?type=debited" class="px-4 py-2 rounded-lg font-medium shadow transition
      ${param.type == 'debited' || param.type == null ? 'bg-gold text-white' : 'bg-clear text-light-gray hover:bg-gray-900'}">
      Debited
    </a>
    <a href="?type=credited" class="px-4 py-2 rounded-lg font-medium shadow transition
      ${param.type == 'credited' ? 'bg-gold text-white' : 'bg-clear text-light-gray hover:bg-gray-900'}">
      Credited
    </a>
  </div>

  <div class="overflow-x-auto content-card rounded-xl p-6">
    <table class="min-w-full text-sm text-left">
      <thead class="table-header">
      <tr>
        <th class="px-4 py-3 rounded-tl-lg">Date</th>
        <th class="px-4 py-3">From Account</th>
        <th class="px-4 py-3">To Account</th>
        <th class="px-4 py-3 ">Amount (Rs.)</th>
        <th class="px-4 py-3 rounded-tr-lg">Status</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="tx" items="${transactions}">
        <tr class="table-row">
          <td class="px-4 py-3 table-cell">
              ${tx.formattedTimestamp}
          </td>
          <td class="px-4 py-3 table-cell">${tx.fromAccount.accountNumber}</td>
          <td class="px-4 py-3 table-cell">${tx.toAccount.accountNumber}</td>
          <td class="px-4 py-3 table-cell font-semibold text-success">Rs. ${tx.amount}</td>
          <td class="px-4 py-3 table-cell font-semibold text-blue">${tx.otp}</td>
        </tr>
      </c:forEach>
      <c:if test="${empty transactions}">
        <tr>
          <td colspan="4" class="px-4 py-3 text-center text-medium-gray">No transactions found.</td>
        </tr>
      </c:if>
      </tbody>
    </table>
  </div>
</main>

<%@ include file="../components/footer.jspf" %>

</body>
</html>
