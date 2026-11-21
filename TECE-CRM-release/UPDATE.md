# TECE CRM — server 2.1.0 / web 117

## Install (same as last time)
1. Upload `server-full-v210.zip` and `web-dist117.zip` into `~/exhibition-card-scanner` with File Manager.
2. In Terminal run `~/crm update` (or `crm-update`). It makes a backup first (database, server code, web), then unpacks, installs, builds and restarts.
3. Open the CRM and check the menu shows **2.1.0**.

What runs by itself at the first start (it only adds things, nothing is removed):
- Database updates `091` to `098`: trip notes, budget documents, unverified-customer lists, price performance, coaching reports.
- `098` puts old priority ratings that were stored as 0–100 onto the 0–10 scale the app uses everywhere else.
- One new package, `pdf-lib`. `npm install` adds it; the server needs internet for that one time.

## Your 9 notes
1. **Trip planner in 3 columns:** customers | days | map. The map is smaller and has an Expand button. Drag customers onto a day.
2. **Budget report:** one PDF with the summary and every uploaded invoice/receipt behind it. Fair numbers in the Turquality PDF match the fair board.
3. **Managers see where their staff has been:** a team trips view in Manager mode, with each trip's visits.
4. **Trip notes per customer:** saved on the customer with the trip's name as a tag, and visible on the customer page.
5. **Readable buttons and chips:** colours fixed in light and dark mode.
6. **Trip costs:** the same cost options as fairs, including Turquality, with cost per customer visited.
7. **Login page:** uses the site's colours.
8. **View-only customers in your countries:** you can open customers in your responsible countries that a colleague looks after. You can read them but not change them, and a banner says "X looks after them".
9. **Unverified customers (admin and brand manager):**
   - Download the list as Excel (Turkish or English headings) and edit it.
   - Fill an e-mail, website or phone to complete a customer, or delete the row of a company that does not exist.
   - Upload it back. Nothing changes until you confirm a preview that lists every change.
   - A customer with orders, offers, notes, calls or a way to reach it is never deleted. Deleted customers go to the junk folder, so they can be brought back.

## Also asked for
- **What each customer buys** (Customers → Purchases tab) and **what each country buys** (Countries → Buys): products, kg/m², € per kg or m², colours, 12-month trend charts.
- **Price performance** next to sales performance (Performance → Price performance). It follows your rule:
  - € per kg for PVC/ABS/PP, € per m² for melamine/veneer.
  - 100 = the volume-weighted average of all customers for the same products over the same 12 months.
  - Everybody sees their own customers: status, success and value.
- **My team** (managers) and **My performance** (everybody): sales, customers kept, activity, overdue follow-ups and the price index, each compared with the team.
- **A verdict for each person** (On track / Needs attention / At risk) with the reasons, and **your options** for each one: coach, plan a trip, give their untouched country to someone with time, and so on.
- **AI coaching report in Turkish** for each person. It includes the companies in their countries that nobody contacted, as places to explore and grow. You can send it by e-mail or download it as a PDF.
- **"Your focus" on Today:** the 3 places where effort pays most today, worked out from your customers, countries and fairs.
  - Examples: "Offers nobody followed up", "Vietnam: 126 companies nobody contacted for a year".
  - Each card shows its value per year and has one Start button.
  - "Why this?" shows the calculation; "Not now" hides it.
- **Design pass:** consistent page headers, real empty states, phone layouts without sideways scrolling, a lower phone top bar, and no developer text shown to staff.
- **Final quality check:** six reviewers checked how it looks and works, the numbers, permissions, Turkish, speed and the advice. They found about 100 issues; the confirmed ones were fixed and then checked again. Main fixes:
  - Assistants and people without money access now see no € figures in focus, verdicts or coaching reports.
  - The yearly budget report now includes costs that were booked on old line names. The SICAM costs were missing before.
  - "Customers won" at a fair is now counted the same way everywhere.
  - Trip PDFs and route explanations are in Turkish for Turkish users.
  - Turkish number and date formats are used in the new screens.
  - A deleted to-do can be brought back with Undo.
  - Team and focus pages take under 0.1 seconds.

## Known limits
- AI coaching and e-mail sending could not be tried here, because there is no AI key and no mailbox. The rules-based version of the report works without a key.
- Price, team and focus figures come from the sales list in Sales intelligence. If that list is out of date, so are they.
- The 12-month windows end at the newest sales date, not at the last full month. Changing that would shift every price figure, so it is left for now.
