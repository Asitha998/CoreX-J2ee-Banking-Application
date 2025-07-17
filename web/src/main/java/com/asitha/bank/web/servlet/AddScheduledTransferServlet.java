package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.ScheduleType;
import com.asitha.bank.core.model.ScheduledTransfer;
import com.asitha.bank.core.service.CustomerService;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.*;

@WebServlet("/user/scheduled/add")
public class AddScheduledTransferServlet extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String username = req.getUserPrincipal().getName();
            String fromAccNo = req.getParameter("fromAccountNumber");
            String toAccNo = req.getParameter("toAccountNumber");
            BigDecimal amount = new BigDecimal(req.getParameter("amount"));
            String nickname = req.getParameter("nickname");
            String scheduleTypeStr = req.getParameter("scheduleType");
            String scheduleDayRaw = req.getParameter("scheduleDay");
            boolean active = Boolean.parseBoolean(req.getParameter("active"));

            ScheduleType scheduleType = ScheduleType.valueOf(scheduleTypeStr);

            Integer scheduleDay = null;
            LocalDate exactDate = null;

            // Parse scheduleDay or exactDate depending on type
            switch (scheduleType) {
                case WEEKLY:
                case MONTHLY:
                    if (scheduleDayRaw != null && !scheduleDayRaw.isEmpty()) {
                        scheduleDay = Integer.parseInt(scheduleDayRaw);
                    }
                    break;
                case YEARLY:
                case ONCE:
                    if (scheduleDayRaw != null && !scheduleDayRaw.isEmpty()) {
                        exactDate = LocalDate.parse(scheduleDayRaw);
                    }
                    break;
                case DAILY:
                    break;
            }

            Account from = customerService.getAccountByAccountNumber(fromAccNo);
            Account to = customerService.getAccountByAccountNumber(toAccNo);

            if (to == null || toAccNo.equals(fromAccNo)) {
                resp.sendRedirect(req.getContextPath() + "/user/favorites.jsp?error=Invalid+Account+Number");
                return;
            }

            ScheduledTransfer sd = new ScheduledTransfer();
            sd.setFromAccount(from);
            sd.setToAccount(to);
            sd.setAmount(amount);
            sd.setScheduleType(scheduleType);
            sd.setScheduleDay(scheduleDay);
            sd.setExactDate(exactDate);
            sd.setNickname(nickname);
            sd.setVerified(false);
            sd.setActive(active);

            sd.setNextRun(computeNextRun(scheduleType, scheduleDay, exactDate));

            System.out.println(sd);

            req.getSession().setAttribute("pendingSd", sd);
            resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/user/favorites.jsp?error=schedule-failed");
        }
    }

    private LocalDateTime computeNextRun(ScheduleType type, Integer day, LocalDate exactDate) {
        LocalDateTime now = LocalDateTime.now();

        switch (type) {
            case DAILY:
                return now.plusDays(1).withHour(9).withMinute(0);
            case WEEKLY:
                DayOfWeek targetDay = DayOfWeek.of(day); // 1 = Monday
                int diff = targetDay.getValue() - now.getDayOfWeek().getValue();
                return now.plusDays(diff <= 0 ? 7 + diff : diff).withHour(9).withMinute(0);
            case MONTHLY:
                LocalDate nextMonth = now.toLocalDate().withDayOfMonth(1).plusMonths(1);
                int safeDay = Math.min(day, nextMonth.lengthOfMonth());
                return LocalDateTime.of(nextMonth.withDayOfMonth(safeDay), LocalTime.of(9, 0));
            case YEARLY:
            case ONCE:
                if (exactDate == null) throw new IllegalArgumentException("Date required for YEARLY/ONCE");
                if (exactDate.isBefore(LocalDate.now())) {
                    exactDate = exactDate.plusYears(1);
                }
                return LocalDateTime.of(exactDate, LocalTime.of(9, 0));
            default:
                return now.plusDays(1);
        }
    }
}
