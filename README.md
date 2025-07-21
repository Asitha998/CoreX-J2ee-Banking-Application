# CoreX Banking System 🏦

**CoreX** is a modular, secure, and scalable enterprise-level banking system developed using the **Jakarta EE platform**. It supports essential banking features like account management, scheduled fund transfers, OTP-based verification, role-based authorization, and automated interest calculations using EJB Timer Services.

---

## 📁 Project Structure (EAR - Multi-module)

- `core` (JAR): Contains entity classes, enums, and shared interfaces.
- `auth` (EJB): Authentication and authorization logic with Jakarta Security.
- `customer` (EJB): Customer and account management logic.
- `transaction` (EJB): Transaction logic (manual and scheduled).
- `scheduler` (EJB): TimerService-driven interest & scheduled transfer tasks.
- `web` (WAR): Frontend JSP interface and REST endpoints.
- `ear` (EAR): Aggregates and deploys all modules.

---

## 🧩 Key Features

### ✅ Functional Modules

- **User Registration & Login**
- **Role-Based Access Control** (`ADMIN`, `USER`)
- **OTP-verified Fund Transfers**
- **Scheduled Transfers** (DAILY, WEEKLY, MONTHLY, YEARLY, ONETIME)
- **Monthly Interest Calculation for Savings Accounts**
- **Balance Summary Reports via Email**
- **Secure Transaction Logs**

### 🔐 Security

- Custom `AuthenticationMechanism` with a `UserIdentityStore`
- Jakarta Security annotations like `@RolesAllowed`, `@DenyAll`
- Role mapping via `web.xml` (not GlassFish Realm)
- Session-based access control

---

## ⏰ EJB Timer Services

- `@Schedule`: Used in `InterestScheduler` for monthly interest.
- **Programmatic Timers**: For scheduled fund transfers.
- Timer persistence and validation handled using `TimerService`.

---

## 🧪 Testing & Reports

- JUnit tests for service beans and transaction workflows.
- Manual test plan and results documented in `/reports/TestReport.docx`.

---

## 🛠 Technologies Used

- Jakarta EE (EJB, JPA, CDI, Security)
- GlassFish 7 / Payara
- MySQL / H2
- JSP + JSTL (frontend)
- Maven EAR multi-module build
- JavaMail for OTP and daily balance reporting

---

## 🚀 Deployment Instructions

1. Clone the repository and open in NetBeans or IntelliJ.
2. Configure your GlassFish server domain with:
   - JDBC connection pool & datasource (MySQL/H2)
   - Mail resource for SMTP (for OTP & reports)
3. Build and deploy the EAR project.
4. Access via: `http://localhost:8080/web/`

---

## 📧 Contact

For any queries or support, reach out to:

> **Developer**: Eldu Primo  
> **Email**: eldu@example.com  
> **Project**: CoreX Banking System

---

