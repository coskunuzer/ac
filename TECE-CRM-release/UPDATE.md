# TECE CRM — server 2.0.0 / web 116

## Install
1. **Back up `data/app.db` first.** Two database updates run by themselves at start-up: `089_perf_indexes` (speed indexes, about a second) and `090_event_budgets` (trip/fair budgets, dares, fair-focus states).
2. Server: unpack `server-full-v200.zip` over the server folder, then `npm run build` and restart. No new packages.
3. Web: replace the contents of `web/dist` with `web-dist116.zip`. Changed files have new names, so browsers pick them up without clearing the cache.

## From your notes
1. **Dark mode:** a new, calmer palette with readable text everywhere. Light mode is unchanged.
2. **Red pill with no text** on the customer page ("Next step"): fixed. Two dark themes were clashing and made the text red on red.
3. **Fair results on the Home page**, plus **Fair focus**: a sprint through one fair's visitors. You see what was said at the stand, give a rating, write a note and set a reminder; Ctrl+Enter saves and opens the next visitor. A visitor can be parked for later or closed. The Fairs page itself is redesigned.
4. **A budget for every trip and every fair:** planned against spent, per kind of cost, and cost per customer visited or per person met. Expenses typed here are booked on the right line of the marketing budget by themselves.
5. **Quality** is removed from the menu and from Permissions. The data stays.
6. **Sena's permissions:** an assistant's own switches are now applied. Before, only the switches of the person she assists were read.
7. **Calendar drag and drop** for to-dos and meetings, with Undo. CRM meetings now show in the month even without Google Calendar.

## Also asked for during the work
- **Challenge board on Home:**
  - Today's points against your goal, your best day, yesterday at the same hour and the colleague just ahead of you.
  - Dares (Push, Beast, Record) raise today's target; once taken, a dare cannot be lowered.
  - A score pill in the top bar on every page.
- **Freight (Nakliye):**
  - Pano is now a desk that runs request → answers → decide → e-mails → documents, with one button per item.
  - Quotes are compared side by side, converted to euro, with the price per kg; the best one is approved in one click, after a confirmation.
  - "Ask for quotes" is one step from the ready-to-ship list.
- **Proforma for veneer, melamine, aluminium, acrylic and other products:**
  - Write the product name in the first field of the line and type the price per m²; no SAP colour code is needed.
  - Each kind prints under its own heading, with its own weight.
- **Research sprint:** the country can be changed again; it is now a full list plus quick country buttons.
- **Redesigned screens:** Trips list, trip planner header, Country explorer cards, and the sidebar logo.
- **Quick dock (To-do / Radar):**
  - Type a to-do and press Enter; "tomorrow" or "next week" at the end sets the day.
  - Tick it off, push it to tomorrow, or drag it onto the calendar.
  - Press T on any page to open the dock.
- **Help → "What is new"** explains all of the above. Turkish is included for every new text.

## Speed and errors (from the usage log)
- **Faster pages:** Home, the customer list and Follow-ups answer several times faster, because account totals are no longer recomputed on every click by anyone.
- **Slow-page logging:** new speed indexes, and a watchdog that writes slow server moments into the usage log.
- **Errors fixed:**
  - The ~216 `shipping/overview` 404s and ~61 `complaints/open-count` 403s: the menu badges no longer ask for pages that are switched off.
  - The sprint crash ("reading 'toLowerCase'").
  - The Leads page 403 for people who cannot upload leads.
  - The `team/summary` error when no period is given.
- **Keep-warm ping:** the server now pings itself every 4 minutes so the host does not put it to sleep. To switch it off, set `KEEP_WARM=0` in `.env`.
