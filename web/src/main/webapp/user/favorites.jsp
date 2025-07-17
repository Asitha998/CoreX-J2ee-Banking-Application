<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.asitha.bank.core.model.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="com.asitha.bank.core.service.CustomerService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorite & Scheduled Transfers - CoreX</title>
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

<main class="flex-grow max-w-4xl mx-auto px-6 py-12">
    <h1 class="text-3xl font-bold text-gold mb-8 flex items-center">
        <i class="fas fa-star mr-3"></i> Favorite & Scheduled Transfers
    </h1>

    <div class="max-w-4xl mx-auto content-card p-6 rounded-2xl shadow-xl">
        <!-- Tabs -->
        <div class="flex justify-center space-x-4 mb-6">
            <button onclick="switchTab('favorites', this)" class="tab-button active">Favorites</button>
            <button onclick="switchTab('scheduleds', this)" class="tab-button">Scheduled</button>
        </div>

        <!-- Favorite Transfers List -->
        <div id="favorites" class="tab-content">
            <h3 class="text-xl font-semibold mb-4 text-gold flex items-center justify-between">
                <span><i class="fas fa-heart mr-2"></i> Favorite Transfers</span>
                <button onclick="toggleModal(true, 'addFavModal')" class="btn-icon-add" title="Add New Favorite">
                    <i class="fas fa-plus"></i>
                </button>
            </h3>
            <c:if test="${empty favorites}">
                <p class="text-medium-gray text-center py-4">No favorite transfers found.</p>
            </c:if>
            <c:forEach var="fav" items="${favorites}">
                <div class="content-card border border-gray-700 p-4 rounded-md mb-3 hover:shadow-lg transition duration-200">
                    <p class="text-light-gray text-lg font-semibold mb-1 flex items-center"><i
                            class="fas fa-tag mr-2 text-gold text-sm"></i><c:out value="${fav.nickname}"/></p>
                    <p class="text-medium-gray text-sm mb-1"><strong class="text-gold">From:</strong> <c:out
                            value="${fav.fromAccount.accountNumber}"/></p>
                    <p class="text-medium-gray text-sm mb-1"><strong class="text-gold">To:</strong> <c:out
                            value="${fav.toAccount.accountNumber}"/></p>
                    <p class="text-medium-gray text-sm"><strong class="text-gold">Status:</strong>
                        <span class="font-medium text-${fav.verified ? 'success' : 'red-400'}">
                            <c:out value="${fav.verified ? 'Verified' : 'Unverified'}"/>
                        </span>
                    </p>
                    <form action="${pageContext.request.contextPath}/user/transfer.jsp" method="post" class="inline">
                        <input type="hidden" name="fromAccNo" value="${fav.fromAccount.accountNumber}"/>
                        <input type="hidden" name="toAccNo" value="${fav.toAccount.accountNumber}"/>
                        <input type="hidden" name="nickname" value="${fav.nickname}"/>
                        <input type="hidden" name="isFavorite" value="true"/>
                        <button type="submit" class="btn-clear px-6 py-3 rounded-lg font-semibold shadow-lg flex items-center text-gold">
                            <i class="fas fa-exchange-alt mr-2 text-gold"></i> Transfer Now
                        </button>
                    </form>
                </div>
            </c:forEach>
        </div>

        <!-- Scheduled Transfers List -->
        <div id="scheduleds" class="tab-content hidden">
            <h3 class="text-xl font-semibold mb-4 text-gold flex items-center justify-between">
                <span><i class="fas fa-clock mr-2"></i> Scheduled Transfers</span>
                <button onclick="toggleModal(true, 'addScheduledModal')" class="btn-icon-add"
                        title="Add New Scheduled Transfer">
                    <i class="fas fa-plus"></i>
                </button>
            </h3>
            <c:if test="${empty scheduleds}">
                <p class="text-medium-gray text-center py-4">No scheduled transfers found.</p>
            </c:if>
            <c:forEach var="sch" items="${scheduleds}">
                <div class="content-card border border-gray-700 p-4 rounded-md mb-3 hover:shadow-lg transition duration-200">

                    <div class="flex items-center justify-between mb-3">
                        <p class="text-light-gray text-xl font-semibold flex items-center">
                            <i class="fas fa-tag mr-3 text-gold text-base"></i>
                            <c:out value="${sch.nickname}"/>
                        </p>

                        <form action="${pageContext.request.contextPath}/user/scheduled/toggle" method="post"
                              class="inline-block">
                            <input type="hidden" name="id" value="${sch.id}"/>
                            <input type="hidden" name="currentState" value="${sch.active}"/>

                            <div class="toggle-wrapper green">
                                <input class="toggle-checkbox" type="checkbox" name="activeToggle"
                                       onchange="this.form.submit()"
                                       <c:if test="${sch.active}">checked</c:if>>
                                <div class="toggle-container">
                                    <div class="toggle-ball"></div>
                                </div>
                            </div>
                        </form>
                    </div>


                    <p class="text-medium-gray text-sm mb-1">
                        <strong class="text-gold">From:</strong>
                        <c:out value="${sch.fromAccount.accountNumber}"/>
                    </p>

                    <p class="text-medium-gray text-sm mb-1">
                        <strong class="text-gold">To:</strong>
                        <c:out value="${sch.toAccount.accountNumber}"/>
                    </p>

                    <p class="text-medium-gray text-sm mb-1">
                        <strong class="text-gold">Amount:</strong>
                        <span class="text-success">Rs. <c:out value="${sch.amount}"/></span>
                    </p>

                    <p class="text-medium-gray text-sm mb-1">
                        <strong class="text-gold">Type:</strong>
                        <c:out value="${sch.scheduleType}"/>
                    </p>

                    <c:choose>
                        <c:when test="${sch.scheduleType == 'WEEKLY' || sch.scheduleType == 'MONTHLY'}">
                            <p class="text-medium-gray text-sm mb-1">
                                <strong class="text-gold">Day:</strong>
                                <c:out value="${sch.scheduleDay}"/>
                            </p>
                        </c:when>
                        <c:when test="${sch.scheduleType == 'YEARLY'}">
                            <p class="text-medium-gray text-sm mb-1">
                                <strong class="text-gold">Date:</strong>
                                <c:out value="${sch.formattedYearly}"/>
                            </p>
                        </c:when>
                        <c:when test="${sch.scheduleType == 'ONCE'}">
                            <p class="text-medium-gray text-sm mb-1">
                                <strong class="text-gold">Date:</strong>
                                <c:out value="${sch.formattedOnce}"/>
                            </p>
                        </c:when>
                    </c:choose>

                        <%--                    <p class="text-medium-gray text-sm mb-1">--%>
                        <%--                        <strong class="text-gold">Next Run:</strong>--%>
                        <%--                        <fmt:formatDate value="${sch.nextRun}" pattern="yyyy-MM-dd HH:mm"/>--%>
                        <%--                    </p>--%>

                    <p class="text-medium-gray text-sm">
                        <strong class="text-gold">Status:</strong>
                        <span class="font-medium text-${sch.verified ? 'success' : 'red-400'}">
                <c:out value="${sch.verified ? 'Verified' : 'Unverified'}"/>
            </span>
                    </p>
                </div>
            </c:forEach>
        </div>
    </div>
</main>

<script>
    function switchTab(tabId, clickedButton) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(div => div.classList.add('hidden'));
        // Show the selected tab content
        document.getElementById(tabId).classList.remove('hidden');

        // Deactivate all tab buttons
        document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
        // Activate the clicked button
        clickedButton.classList.add('active');
    }

    // Function to toggle modal visibility
    function toggleModal(show, modalId) {
        const modal = document.getElementById(modalId);
        if (show) {
            modal.classList.remove('hidden');
            modal.classList.add('flex'); // Use flex to center
        } else {
            modal.classList.add('hidden');
            modal.classList.remove('flex');
        }
    }

    function toggleScheduleDay(scheduleType) {
        const scheduleDayField = document.getElementById('scheduleDayField');
        const input = scheduleDayField.querySelector('input');

        if (scheduleType === 'DAILY') {
            scheduleDayField.classList.add('hidden');
            input.removeAttribute('required');
            input.type = 'text';
            input.value = '';
        } else if (scheduleType === 'WEEKLY') {
            scheduleDayField.classList.remove('hidden');
            input.type = 'number';
            input.min = 1;
            input.max = 7;
            input.placeholder = '1 = Monday, 7 = Sunday';
            input.setAttribute('required', 'true');
        } else if (scheduleType === 'MONTHLY') {
            scheduleDayField.classList.remove('hidden');
            input.type = 'number';
            input.min = 1;
            input.max = 31;
            input.placeholder = 'Enter day of the month (1–31)';
            input.setAttribute('required', 'true');
        } else if (scheduleType === 'YEARLY' || scheduleType === 'ONCE') {
            scheduleDayField.classList.remove('hidden');
            input.type = 'date';
            input.setAttribute('required', 'true');
            input.placeholder = '';
        }
    }

</script>

<style>
    .tab-button {
        padding: 0.75rem 1.5rem; /* Increased padding */
        border-radius: 9999px; /* Pill shape */
        font-weight: 600; /* Semi-bold */
        transition: all 0.3s ease;
        background-color: #2A2A2A; /* Dark background for inactive */
        color: #B0B0B0; /* Medium gray text for inactive */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); /* Subtle shadow */
    }

    .tab-button:hover {
        background-color: #3A3A3A; /* Slightly lighter dark on hover */
        color: #E0E0E0; /* Lighter text on hover */
    }

    .tab-button.active {
        background: linear-gradient(45deg, #D4AF37, #A67C00); /* Gold gradient for active */
        color: #1A1A1A; /* Dark text on active gold button */
        box-shadow: 0 4px 10px rgba(212, 175, 55, 0.4); /* Gold shadow for active */
    }

    /* New style for the add icon button */
    .btn-icon-add {
        background-color: #3A3A3A; /* Darker background */
        color: #D4AF37; /* Gold icon color */
        border-radius: 9999px; /* Circle */
        width: 32px; /* Fixed size */
        height: 32px; /* Fixed size */
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1rem; /* Icon size */
        transition: all 0.2s ease;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        flex-shrink: 0; /* Prevent it from shrinking */
    }

    .btn-icon-add:hover {
        background-color: #4A4A4A; /* Slightly lighter on hover */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4);
    }

    /* Modal specific styles */
    .modal-content-card {
        background-color: #1A1A1A; /* Dark background for modal */
        border: 1px solid rgba(50, 50, 50, 0.7);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
    }

    .modal-close-button {
        color: #B0B0B0; /* Medium gray for close icon */
    }

    .modal-close-button:hover {
        color: #D4AF37; /* Gold on hover */
    }
</style>

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
%>

<!-- Add New Favorite Modal -->
<div id="addFavModal" class="fixed inset-0 bg-black bg-opacity-70 hidden items-center justify-center z-50">
    <div class="modal-content-card rounded-lg shadow-lg p-6 w-full max-w-md relative">

        <!-- Close Button -->
        <button onclick="toggleModal(false, 'addFavModal')"
                class="absolute top-4 right-4 text-2xl modal-close-button hover:text-gold">
            <i class="fas fa-times"></i>
        </button>

        <h2 class="text-xl font-semibold mb-6 text-center text-gold flex items-center justify-center">
            <i class="fas fa-star mr-2"></i> Add New Favorite
        </h2>

        <form action="${pageContext.request.contextPath}/user/favorites/add" method="post" class="space-y-5">
            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">Nickname</span>
                <div class="relative input-group">
                    <i class="fas fa-tag absolute icon"></i>
                    <input type="text" name="nickname" placeholder="e.g., My Friend's Account" required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                </div>
            </label>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">From Account</span>
                <div class="relative input-group">
                    <i class="fas fa-credit-card absolute icon"></i>
                    <select name="fromAccountNumber"
                            class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"
                            required
                            style="color:white;background-color: #2a2a2a;padding-left: 30px">
                        <option value="" class="bg-gray-800 text-light-gray">-- Select Your Account --</option>
                        <c:forEach var="acc" items="${accounts}">
                            <option value="${acc.accountNumber}" class="bg-gray-800 text-light-gray"><c:out
                                    value="${acc.accountNumber}"/> - <c:out value="${acc.type}"/></option>
                        </c:forEach>
                    </select>
                </div>
            </label>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">To Account Number</span>
                <div class="relative input-group">
                    <i class="fas fa-user-circle absolute icon"></i>
                    <input type="text" name="toAccountNumber" placeholder="Recipient Account Number" required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                </div>
            </label>

            <button type="submit"
                    class="w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center justify-center">
                <i class="fas fa-save mr-2"></i> Save Favorite
            </button>
        </form>

    </div>
</div>

<!-- Scheduled Transfer Modal -->
<div id="addScheduledModal" class="fixed inset-0 bg-black bg-opacity-70 hidden items-center justify-center z-50">
    <div class="modal-content-card rounded-lg shadow-lg p-6 w-full max-w-lg relative">

        <!-- Close button -->
        <button onclick="toggleModal(false, 'addScheduledModal')"
                class="absolute top-4 right-4 text-2xl modal-close-button hover:text-gold">
            <i class="fas fa-times"></i>
        </button>

        <h2 class="text-xl font-semibold mb-6 text-center text-gold flex items-center justify-center">
            <i class="fas fa-clock mr-2"></i> Add New Scheduled Transfer
        </h2>

        <form action="${pageContext.request.contextPath}/user/scheduled/add" method="post" class="space-y-5">

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">Nickname</span>
                <div class="relative input-group">
                    <i class="fas fa-tag absolute icon"></i>
                    <input type="text" name="nickname" placeholder="e.g., Monthly Rent" required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                </div>
            </label>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">From Account</span>
                <div class="relative input-group">
                    <i class="fas fa-credit-card absolute icon"></i>
                    <select name="fromAccountNumber"
                            class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"
                            required
                            style="color:white;background-color: #2a2a2a;padding-left: 30px">
                        <option value="" class="bg-gray-800 text-light-gray">-- Select Your Account --</option>
                        <c:forEach var="acc" items="${accounts}">
                            <option value="${acc.accountNumber}" class="bg-gray-800 text-light-gray"><c:out
                                    value="${acc.accountNumber}"/> - <c:out value="${acc.type}"/></option>
                        </c:forEach>
                    </select>
                </div>
            </label>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">To Account Number</span>
                <div class="relative input-group">
                    <i class="fas fa-user-circle absolute icon"></i>
                    <input type="text" name="toAccountNumber" placeholder="Recipient Account Number" required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                </div>
            </label>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">Amount (Rs.)</span>
                <div class="relative input-group">
                    <i class="fas fa-coins absolute icon"></i>
                    <input type="number" name="amount" step="0.01" placeholder="e.g., 1000.00" required
                           class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"/>
                </div>
            </label>

            <div>
                <label class="block">
                    <span class="text-light-gray text-sm font-medium mb-1 block">Schedule Type</span>
                    <div class="relative input-group">
                        <i class="fas fa-calendar-alt absolute icon"></i>
                        <select name="scheduleType"
                                class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"
                                onchange="toggleScheduleDay(this.value)"
                                style="color:white;background-color: #2a2a2a;padding-left: 30px">
                            <option value="DAILY" class="bg-gray-800 text-light-gray">Daily</option>
                            <option value="WEEKLY" class="bg-gray-800 text-light-gray">Weekly</option>
                            <option value="MONTHLY" class="bg-gray-800 text-light-gray">Monthly</option>
                            <option value="YEARLY" class="bg-gray-800 text-light-gray">Yearly</option>
                            <option value="ONCE" class="bg-gray-800 text-light-gray">Specific Date</option>
                        </select>
                    </div>
                </label>
            </div>

            <div id="scheduleDayField" class="hidden">
                <label class="block">
                    <span class="text-light-gray text-sm font-medium mb-1 block">Schedule Day</span>
                    <div class="relative input-group">
                        <i class="fas fa-calendar-day absolute icon"></i>
                        <input type="text" name="scheduleDay"
                               class="w-full p-3 rounded-lg focus:outline-none focus:ring-2 transition duration-200"
                               placeholder="Eg: MONDAY / 15 / YYYY-MM-DD">
                    </div>
                </label>
            </div>

            <label class="block">
                <span class="text-light-gray text-sm font-medium mb-1 block">Active Now</span>
                <div class="flex items-center space-x-3">
                    <input type="checkbox" name="active" id="activeCheckbox"
                           class="h-5 w-5 text-gold focus:ring-gold bg-gray-700 border-gray-600 rounded" checked/>
                    <label for="activeCheckbox" class="text-medium-gray text-sm">Enable this scheduled transfer</label>
                </div>
            </label>


            <button type="submit"
                    class="w-full btn-primary py-3 rounded-lg font-semibold shadow-lg hover:shadow-xl focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gold transition duration-300 flex items-center justify-center">
                <i class="fas fa-save mr-2"></i> Save Scheduled Transfer
            </button>

        </form>
    </div>
</div>


<%@ include file="../components/footer.jspf" %>
</body>
</html>
