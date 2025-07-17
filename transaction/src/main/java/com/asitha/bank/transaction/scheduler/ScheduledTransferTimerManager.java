package com.asitha.bank.transaction.scheduler;

import com.asitha.bank.core.model.ScheduleType;
import com.asitha.bank.core.model.ScheduledTransfer;
import com.asitha.bank.core.service.TransactionService;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import jakarta.ejb.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Singleton
@Startup
public class ScheduledTransferTimerManager {

    @Resource
    private TimerService timerService;

    @EJB
    private TransactionService transactionService;

    // Store all active timers by transfer ID
    private final Map<Long, Timer> timers = new ConcurrentHashMap<>();

    @PostConstruct
    public void init() {
        List<ScheduledTransfer> scheduled = transactionService.getActiveAndVerifiedTransfers();
        for (ScheduledTransfer s : scheduled) {
            createTimerFor(s);
        }
    }

    public void createTimerFor(ScheduledTransfer s) {
        if (!s.isActive() || !s.isVerified()) return;

        ScheduleExpression expression = buildSchedule(s);

        TimerConfig config = new TimerConfig();
        config.setPersistent(true);
        config.setInfo(s.getId());

        Timer timer = timerService.createCalendarTimer(expression, config);
        timers.put(s.getId(), timer);
        System.out.println("Created timer for transfer ID: " + s.getId() + " with schedule: " + expression);
    }

    public void cancelTimer(Long scheduledTransferId) {
        Timer timer = timers.get(scheduledTransferId);
        if (timer != null) {
            timer.cancel();
            timers.remove(scheduledTransferId);
        }
        System.out.println("Cancelled timer for transfer ID: " + scheduledTransferId);
    }

    @Timeout
    public void onTimeout(Timer timer) {
        Long transferId = (Long) timer.getInfo();
        ScheduledTransfer s = transactionService.findScheduledTransfer(transferId);

        if (s == null || !s.isActive() || !s.isVerified()) return;

        transactionService.executeScheduledTransfer(s);

        if (s.getScheduleType() == ScheduleType.ONCE) {
            cancelTimer(transferId);
            s.setActive(false);
            transactionService.removeScheduledTransfer(s);
        }

        System.out.println("Executed scheduled transfer with ID: " + transferId + " at " + LocalDateTime.now());
    }

    private ScheduleExpression buildSchedule(ScheduledTransfer s) {
        ScheduleExpression expr = new ScheduleExpression();

        switch (s.getScheduleType()) {
            case DAILY:
                return expr.hour(0).minute(0).second(0);
            case WEEKLY:
                return expr.dayOfWeek(s.getScheduleDay()).hour(0).minute(0).second(0);
            case MONTHLY:
                return expr.dayOfMonth(s.getScheduleDay()).hour(0).minute(0).second(0);
            case YEARLY:
                LocalDateTime yt = s.getExactDate().atTime(0, 0);
                return expr
                        .month(yt.getMonthValue())
                        .dayOfMonth(yt.getDayOfMonth())
                        .hour(yt.getHour()).minute(yt.getMinute()).second(0);
            case ONCE:
                LocalDateTime dt = s.getExactDate().atTime(0, 0);
                return expr
                        .year(dt.getYear())
                        .month(dt.getMonthValue())
                        .dayOfMonth(dt.getDayOfMonth())
                        .hour(dt.getHour()).minute(dt.getMinute()).second(0);
        }

        return expr.hour(9);
    }
}

