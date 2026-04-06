# Atrio — Salon Discovery & Booking Platform

## Context

Atrio is a two-sided mobile marketplace connecting clients with barber salons. Clients discover nearby salons, browse services and barbers, book appointments or walk in, and track their live queue position. Salon owners manage their business — services, barbers, bookings, queue flow, and revenue analytics — from a dedicated dashboard. The app supports real-time WebSocket queue updates, push notifications, offline-first notes, and dual-language localization (English/French).

**Target audience:**
- Primary: Male clients aged 18–45 seeking convenient salon booking in urban areas
- Secondary: Salon/barber shop owners managing daily operations, staff, and customer flow

**Primary goals:**
- Clients: Find a salon → Book a service → Track queue → Get serviced with minimal wait
- Owners: Manage salon operations → Maximize daily throughput → Reduce no-shows

**Key conversion actions:** Complete a booking, join a walk-in queue, leave a review, upgrade to owner account

---

## Design System

### Colors
- **Primary:** #0D9488 (teal) — used for CTAs, active states, links
- **Primary Container:** #CCFBF1 — used for selected chips, light badges
- **Secondary:** #10B981 (green) — used for success states, open status
- **Secondary Container:** #D1FAE5
- **Background:** #F8FAFC (light) / #0F172A (dark)
- **Surface:** #FFFFFF (light) / #1E293B (dark)
- **Text Primary:** #0F172A (light) / #F8FAFC (dark)
- **Text Secondary:** #64748B (light) / #94A3B8 (dark)
- **Error:** #EF4444 — destructive actions, closed status
- **Warning:** #F59E0B — pending status, alerts
- **Info:** #3B82F6 — informational badges, in-progress status
- **Status palette:** Open #10B981, Closed #EF4444, Pending #F59E0B, In Progress #3B82F6, Completed #10B981, Cancelled #64748B

### Dark Mode
- Primary shifts to #5EEAD4, Secondary to #34D399
- Surfaces use slate-900 (#0F172A) and slate-800 (#1E293B)
- All status colors have dedicated dark-mode variants with darker container backgrounds

### Typography
- **Font:** Inter (Google Fonts)
- **Scale (Material 3):**
  - Display: 57/45/36px — splash, hero sections
  - Headline: 32/28/24px SemiBold — page titles, stat values
  - Title: 22/16/14px SemiBold — section headers, card titles
  - Body: 16/14/12px Regular — content text, descriptions
  - Label: 14/12/11px Medium — buttons, chips, badges, metadata
- **Domain-specific styles:** Price text (bold primary), Timer text (headline bold tabular figures for queue counters), Stat value text (headline bold for dashboard KPIs), Meta text (body small muted for addresses/dates), Badge text (label small bold for status chips)

### Spacing
- **4px base grid:** 2 / 4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48 / 64px
- **Content padding:** 16px horizontal standard, 24px for wide sections
- **Card internal padding:** 16px all sides
- **Section spacing:** 24–32px vertical between content blocks

### Border Radius
- **Cards:** 12px
- **Buttons:** 12px
- **Inputs:** 12px
- **Chips/Badges:** 999px (pill)
- **Avatars:** Full circle
- **Bottom sheets:** 16px top corners

### Shadows
- **Cards:** Subtle 2-layer shadow (0.04 + 0.06 alpha, 4–8px blur)
- **Elevated elements:** Medium shadow (0.06 + 0.08 alpha, 8–16px blur)
- **Modals/sheets:** Heavy shadow (0.08 + 0.12 alpha, 16–32px blur)

### Iconography
- Material Icons throughout
- Organized by domain: navigation (home, back, menu), salon (content_cut, chair, storefront), booking (calendar_today, schedule, access_time), queue (format_list_numbered, fiber_manual_record for live dot), actions (search, filter_list, add, edit, delete, share, favorite), status (location_on, phone, star, attach_money)
- Sizes: 14px inline / 16px chips / 20px buttons / 24px standard / 32px section headers / 48px empty states / 64px onboarding

---

## Layout & Navigation

### Client Navigation (Bottom Tab Bar — 4 tabs)
1. **Discover** (search icon) — Salon browsing with search, filters, list/map toggle
2. **Bookings** (calendar icon) — Upcoming and past appointments
3. **Profile** (person icon) — Avatar, name, email, edit profile, change password, logout
4. **Settings** (settings icon) — Theme toggle, language selector, about/legal

### Owner Navigation (Bottom Tab Bar — 4 tabs)
1. **Dashboard** (dashboard icon) — KPI stats, quick actions, today's bookings
2. **Queue** (list icon) — Live queue management with advance/skip controls
3. **Profile** (person icon) — Same as client
4. **Settings** (settings icon) — Same as client

### Navigation Patterns
- StatefulShellRoute preserves tab state across navigation
- Nested navigation within tabs (e.g., Discover → Salon Detail → Reviews)
- Full-screen overlays for booking flow and queue status
- Bottom sheets for filters and confirmations
- Role-based redirect: clients see Discover, owners see Dashboard

### Responsive Behavior
- **Mobile (<600px):** Single column, 4-column grid, 16px gutters — primary target
- **Tablet (600–1024px):** 8-column grid, 24px gutters, side-by-side panels where appropriate
- **Desktop (≥1024px):** 12-column grid, 24px gutters, multi-panel layouts

---

## Screens to Generate (30 Total)

### 1. Splash Screen
- Centered app icon (100×100) with loading spinner below
- Clean background, no text — auto-navigates after auth check

### 2. Onboarding (3-step PageView)
- Step 1: Waving hand icon + "Welcome to Atrio" + value proposition
- Step 2: Folder icon + "Discover & Book" + discovery description
- Step 3: Rocket icon + "Ready to Go" + call to action
- Animated dot indicators (active dot elongated in primary color)
- "Skip" text button top-right, "Next"/"Get Started" primary button bottom

### 3. Login
- Auth header: app logo + "Welcome Back" title + subtitle
- Email text field with envelope icon prefix
- Password field with lock icon prefix and visibility toggle
- "Forgot Password?" right-aligned text link
- Full-width "Login" primary button with loading state
- Horizontal divider with centered "OR" label
- Two social login outlined buttons: Google (with logo) and Apple (with logo)
- Bottom text: "Don't have an account? Register" with tappable link

### 4. Register
- Auth header: logo + "Create Account"
- Two animated role selection cards side by side: "Client" (person icon) and "Salon Owner" (storefront icon) — selected card has primary border + primary container background
- Name text field
- Email text field
- Password field with visibility toggle
- Confirm password field with match validation
- Full-width "Register" primary button with loading state
- Bottom text: "Already have an account? Login"

### 5. Forgot Password
- Auth header: logo + "Reset Password" + instruction text
- Email text field
- Full-width "Next" primary button

### 6. OTP Verification
- Auth header: logo + "Verify Email" + "Enter the 6-digit code sent to {email}"
- 6-digit OTP input (6 individual square boxes, auto-advance focus)
- Full-width "Done" primary button
- "Resend OTP" text link centered below

### 7. Salon Discovery (Client — Tab 1)
- Search bar at top with search icon prefix and filter icon button suffix
- Filter bottom sheet: distance radius slider, rating minimum, open now toggle, service type chips
- Toggle button for List/Map view (segmented control)
- **List view:** Vertical scrollable list of SalonCards:
  - Cover image (16:9 ratio, rounded 12px)
  - Salon name (title medium bold)
  - Star rating (filled/empty stars) + review count text
  - Address with location pin icon (meta text style)
  - Open/Closed pill badge (green #10B981 or red #EF4444 with matching container background)
- **Map view:** Placeholder with map icon + "Configure Google Maps API key" instruction
- Pull-to-refresh enabled
- Empty state: search icon + "No salons found" + "Try adjusting your filters"

### 8. Salon Detail
- **Collapsing app bar** with salon cover image as background, back button overlay, share button
- Below image:
  - Salon name (headline small)
  - Rating stars row + "(N reviews)" tappable link
  - Open/Closed status pill badge
  - Address row: location icon + address text
  - Phone row: phone icon + phone number text
  - Description paragraph (body medium, muted)
- **Opening Hours section:** Section header "Opening Hours", list of days with time ranges, current day highlighted
- **Services section:** Section header "Services" with horizontal scrollable service cards:
  - Service name (title small)
  - Duration in minutes (meta text)
  - Price (price text style — bold primary)
- **Barbers section:** Section header "Barbers" with horizontal carousel:
  - Circle avatar (48px)
  - Barber name
  - Star rating
  - Available/unavailable indicator dot
- **Reviews section:** Section header "Reviews" with "See all" link:
  - 3 review preview cards: avatar + name + star rating + review text + date
- **Floating "Book Now" button** — extended FAB at bottom right, primary color, calendar icon

### 9. Salon Reviews (Full List)
- App bar: "Reviews" title with back button
- Review count subtitle
- Scrollable list of ReviewCards:
  - User avatar + name
  - Star rating (filled stars)
  - Review text (body medium)
  - Date (meta text)
- Pull-to-refresh

### 10. Booking Flow — Step 1: Select Service
- App bar: "Book Appointment" with back button
- **Horizontal progress bar** (4 steps, step 1 active — teal filled, rest gray)
- Section header: "Select a Service"
- List of tappable service cards:
  - Service name (title small bold)
  - Duration badge (e.g., "30 min")
  - Price (price text style, right-aligned)
  - Selected state: primary border + primary container background + checkmark
- "Next" button at bottom (disabled until selection made)

### 11. Booking Flow — Step 2: Select Barber
- Same app bar and progress bar (step 2 active)
- Section header: "Choose a Barber"
- "Any Available" option card at top (with shuffle icon)
- Grid of barber cards (2 columns):
  - Circle avatar (64px)
  - Barber name
  - Star rating
  - Selected state: primary border highlight
- "Next" button at bottom

### 12. Booking Flow — Step 3: Select Time
- Same app bar and progress bar (step 3 active)
- Section header: "Pick a Time"
- **Booking type toggle:** "Reservation" / "Walk-in" segmented control
- If Reservation:
  - Calendar date picker (inline, current month visible)
  - Time slot grid below (chips showing available times, e.g., "9:00 AM", "9:30 AM")
  - Selected slot highlighted in primary
  - Unavailable slots grayed out
- If Walk-in:
  - "Join the queue now" card with estimated wait time
- "Next" button at bottom

### 13. Booking Flow — Step 4: Confirm
- Same app bar and progress bar (step 4 active — all filled)
- Section header: "Confirm Booking"
- **Booking summary card** (elevated card with internal sections):
  - Service: name + duration
  - Barber: name or "Any available"
  - Date & Time: "March 15, 2026 at 2:30 PM" or "Walk-in"
  - Type: "Reservation" or "Walk-in" badge
  - Price: large bold price display
  - Divider
  - Salon name + address (meta text)
- Full-width "Confirm Booking" primary button with loading state

### 14. Booking Confirmation
- Large animated checkmark icon (green, 64px) centered
- "Booking Confirmed!" headline
- Descriptive subtitle text
- Booking summary card (same as step 4)
- Two buttons stacked:
  - "View My Bookings" primary button
  - "Back to Home" ghost button

### 15. My Bookings (Client — Tab 2)
- **Tab bar** at top: "Upcoming" | "Past" (underline indicator, primary color)
- **Upcoming tab:** List of BookingCards for pending/confirmed/inProgress:
  - Service name (title small bold)
  - Salon name (meta text)
  - Date & time (meta text with calendar icon)
  - Barber name (meta text with person icon)
  - Status chip (color-coded pill: Pending #F59E0B, Confirmed #3B82F6, In Progress #10B981)
  - Price (right-aligned, price text)
  - Tap → Booking Detail
- **Past tab:** Same card layout for completed/cancelled
  - Completed: green chip, Cancelled: gray chip
- Empty states per tab: "No upcoming bookings" / "No past bookings"
- Pull-to-refresh

### 16. Booking Detail
- App bar: "Booking Details" with back button
- **Status banner** at top (full-width colored strip matching status)
- Detail sections:
  - Service info: name, duration, price
  - Salon info: name, address (tappable for map)
  - Barber info: avatar, name, rating
  - Schedule: date, time, booking type
  - Status timeline (vertical stepper showing status progression)
- **Action buttons** (contextual):
  - Pending/Confirmed: "Cancel Booking" destructive outlined button
  - Completed: "Leave a Review" primary button
  - Cancelled: No actions

### 17. Queue Status (Client — Full Screen)
- App bar: "Queue Status" with **animated "Live" badge** (red dot + "LIVE" label, pulsing)
- **Queue summary row** (3 stat cards inline):
  - Total waiting (people icon + count)
  - Currently serving (chair icon + count)
  - Est. wait (timer icon + "~N min")
- **Your Position Card** (highlighted, primary container background):
  - Large position number "#5" (timer text style — headline bold)
  - "You are #5 in line"
  - "Estimated wait: 12 min"
  - Service name
  - "Leave Queue" destructive outlined button
  - When turn arrives: green background, "It's your turn!" with celebration icon
- **Queue entries list:**
  - Each entry: position circle badge (primary if serving) + service name + barber name + duration + price
  - Currently serving entry highlighted with "Serving" badge
- Empty state: "Queue is empty" with chair icon
- Pull-to-refresh (also auto-updates via WebSocket)

### 18. Owner Dashboard (Owner — Tab 1)
- **Salon header:** Salon name (headline medium) + Open/Closed text indicator
- **Stats grid** (2×2 cards):
  - "Today's Bookings" — calendar icon, count value (stat value text), "N completed" subtitle
  - "Today's Revenue" — money icon, dollar amount (green stat value), formatted currency
  - "Week Bookings" — date range icon, count value
  - "Avg. Wait Time" — timer icon, "N min" (orange stat value)
- **Quick Actions row** (horizontal scrollable chips):
  - Queue, Services, Barbers, All Bookings, Stats — each navigates to respective management page
- **Today's Bookings section:**
  - Section header "Today's Bookings" with "See all" link
  - List of booking cards (compact: time + service + client name + status chip)
- Pull-to-refresh

### 19. Owner Queue Management (Owner — Tab 2)
- App bar: "Queue Management" with refresh button
- **Control bar** at top:
  - "Advance Queue" primary button (skip_next icon) — serves next customer
  - "Skip" outlined button — skips current entry
- **Queue entries list:**
  - Position badge (circle, primary-filled if currently serving)
  - Service name (title small)
  - Barber name or "Any barber" (meta text)
  - Duration or "Serving" green badge
  - Price (right-aligned)
  - Currently serving row visually elevated with primary container background
- Empty state: "No one in queue"

### 20. Service Management (Owner)
- App bar: "Services" with "+" add button
- List of service tiles:
  - Service name + active/inactive toggle
  - Duration + price
  - Edit (pencil icon) and delete (trash icon) action buttons
  - Swipe-to-delete with confirmation
- FAB "+" to add new service

### 21. Service Form (Owner — Add/Edit)
- App bar: "Add Service" or "Edit Service"
- Form fields:
  - Service name text field
  - Description multiline field
  - Price number field with "$" prefix
  - Duration number field with "min" suffix
  - Image upload (optional) — camera/gallery picker
  - Active toggle switch
- "Save" primary button at bottom with loading state

### 22. Barber Management (Owner)
- App bar: "Barbers" with "+" add button
- Grid of barber cards (2 columns):
  - Circle avatar (64px)
  - Barber name
  - Star rating
  - Available/unavailable status dot
  - Edit/remove actions
- FAB "+" to add new barber

### 23. Barber Form (Owner — Add/Edit)
- App bar: "Add Barber" or "Edit Barber"
- Form fields:
  - Photo upload (circle avatar with camera overlay)
  - Name text field
  - Service assignment (multi-select chips from salon's services)
  - Availability toggle
- "Save" primary button

### 24. Owner Stats / Analytics
- App bar: "Statistics"
- **Revenue chart** (line or bar chart — weekly/monthly toggle)
- **Booking breakdown:** Completed vs cancelled vs no-show (pie or donut chart)
- **Key metrics cards:**
  - Total bookings this month
  - Average rating
  - Revenue trend (up/down arrow with percentage)
  - Most popular service
  - Busiest day of week

### 25. Owner All Bookings
- App bar: "All Bookings"
- Filter chips: All, Pending, Confirmed, In Progress, Completed, Cancelled
- Sortable list of booking entries:
  - Date + time
  - Client name
  - Service name
  - Barber name
  - Status chip
  - Price
- Tap → status update options (confirm, start, complete, cancel, no-show)

### 26. Salon Settings (Owner)
- App bar: "Salon Settings"
- Editable sections:
  - Salon name + description
  - Address + phone
  - Cover photo upload
  - Gallery photos management
  - Opening hours editor (per day)
  - "Save Changes" button

### 27. Notifications
- App bar: "Notifications" with "Read all" text button (visible when unread exist)
- **Grouped by date:** "Today", "Yesterday", "March 12, 2026"
- Notification tiles:
  - Notification type icon (colored circle: booking=blue, queue=teal, reminder=amber, general=gray)
  - Title (bold if unread)
  - Body text preview (2 lines max)
  - Timestamp (relative: "2h ago", "Yesterday")
  - Unread indicator dot (primary color, left edge)
- Tap marks as read
- Empty state: bell icon + "No notifications yet"

### 28. Profile
- App bar: "Profile"
- **Avatar section:** Large circle avatar (80px) centered with camera edit overlay
- **User info:** Name (headline small), Email (body medium muted)
- **Action list:**
  - Edit Profile → form page
  - Change Password → form page
  - Theme toggle: System / Light / Dark (current selection shown)
  - Logout — destructive text, shows confirmation dialog
- Divider between sections

### 29. Settings
- App bar: "Settings"
- **Appearance section:**
  - Theme selector tile → dialog with 3 options (System, Light, Dark) with radio buttons
  - Language selector tile → dialog with 2 options (English, Français) with radio buttons
- **About section:**
  - Version info tile ("v1.0.0")
  - Terms of Service tile → link
  - Privacy Policy tile → link
- Each tile: icon + label + current value trailing text + chevron right

### 30. Notes (Offline-First)
- App bar: "Notes" with sync status icon (cloud_done if synced, cloud_upload if pending)
- **Sync status banner** at top when items pending sync
- Notes list:
  - Note card: title (1 line, bold) + content preview (2 lines) + sync icon if pending
  - Tap → Note detail/editor
- FAB "+" to create note
- Pull-to-refresh
- Empty state: "No notes yet"

---

## UX & CRO Optimization

### Reduce Booking Friction
- Show estimated total price at every step of the booking flow, not just confirmation
- Add "Book Again" shortcut on completed booking cards in My Bookings
- Pre-select the most popular service on Step 1
- Show barber availability indicators (green dot) directly on selection cards
- Add "Skip barber selection" quick action for clients who don't have a preference

### Improve Discovery Conversion
- Add "Popular" and "Nearby" quick-filter pills above salon list (no bottom sheet needed for common filters)
- Show real-time queue length on salon cards ("3 people waiting" badge)
- Display "Next available slot" on each salon card to reduce browsing time
- Add horizontal "Recently Visited" carousel at top of Discover for returning users

### Optimize Queue Experience
- Add push notification prompt when user is 2 positions away from being served
- Show countdown timer instead of just "estimated wait" for better anticipation
- Add "Share my position" action so users can notify someone they're almost done
- Vibration/haptic feedback when "It's your turn!" state triggers

### Owner Dashboard CRO
- Make stats cards tappable to drill into detailed analytics
- Add "Start of day checklist" card (open salon, check barber availability, review today's bookings)
- Show real-time revenue counter animation (AppCountUp widget)
- Prominent "No-show rate" metric to encourage owners to enable reminders

### Onboarding & Activation
- Add role-specific onboarding: clients see salon discovery tips, owners see dashboard walkthrough
- Show a "Complete your profile" progress bar on Profile page until avatar + phone added
- First booking prompt: after onboarding, suggest popular nearby salons immediately
- Owner first-time setup wizard: add salon → add services → add barbers → go live

### Form Optimization
- Auto-save form progress (booking flow, service form, barber form) so users don't lose data on back navigation
- Inline validation with real-time feedback (green checkmark on valid fields)
- Smart defaults: pre-fill city from GPS, suggest price range based on service type

---

## Reusable Component System

### Navigation
- `BottomNavBar` — 4-tab bar with role-aware items, badge support for notifications count
- `AppBar` — Centered title, optional back button, action buttons, elevation 0
- `SectionHeader` — Title text + optional "See all" trailing action link

### Buttons
- `PrimaryButton` — Full-width, 52px height, 12px radius, loading spinner overlay, teal fill
- `SecondaryButton` — Full-width outlined, same dimensions, teal border
- `GhostButton` — Text-only, optional leading icon, custom color support
- `IconButton` — 48px circle, customizable icon/color/background, tooltip
- `FAB` — Circular (icon only) or Extended (icon + label) floating action button

### Inputs
- `TextField` — Label above, 12px radius, prefix/suffix icon slots, error text below
- `PasswordField` — TextField + visibility toggle icon
- `SearchBar` — Rounded, search icon prefix, filter icon suffix, real-time onChange
- `OtpField` — 6 individual digit boxes, auto-advance, paste support
- `Dropdown` — Labeled dropdown with generic type support
- `ToggleSwitch` — Label + optional subtitle + switch, full-width tap target
- `SegmentedControl` — 2–4 segment toggle (e.g., Upcoming/Past, Reservation/Walk-in)
- `RatingInput` — 5 tappable stars for review submission
- `TimeSlotPicker` — Grid of time chips with available/unavailable/selected states

### Data Display
- `SalonCard` — Image + name + rating + address + status badge (used in Discover list)
- `BookingCard` — Service + salon + date + barber + status chip + price (used in My Bookings)
- `ReviewCard` — Avatar + name + stars + text + date
- `StatCard` — Icon + label + value + optional subtitle (used in Owner Dashboard 2×2 grid)
- `ServiceTile` — Name + duration + price + optional edit/delete actions
- `BarberCard` — Avatar + name + rating + availability dot
- `NotificationTile` — Type icon + title + body + timestamp + unread dot
- `QueueEntryTile` — Position badge + service + barber + duration + price
- `Avatar` — Circle image with initials fallback, configurable size
- `Badge` — Overlay count badge (notification count, "99+" max)
- `Chip` — Filter/selection chip, selected/unselected states
- `StatusChip` — Pill badge with status-specific color (Pending amber, Confirmed blue, etc.)
- `PriceDisplay` — Bold primary-colored formatted price
- `ProgressSteps` — Horizontal 4-step progress indicator for booking flow

### Feedback
- `SnackBar` — Success (green), Error (red), Warning (amber), Info (blue) variants with icon
- `Dialog` — Title + message + confirm/cancel buttons, destructive variant (red confirm)
- `BottomSheet` — 16px top radius, drag handle, scrollable content
- `Toast` — Lightweight notification overlay
- `ConfirmDialog` — Specialized dialog for destructive actions

### State Displays
- `EmptyState` — Large icon (48px) + title + subtitle + optional action button
- `ErrorState` — Error icon + message + "Retry" button
- `OfflineBanner` — Persistent top banner when connectivity lost (amber background)
- `ShimmerLoader` — Placeholder skeleton (configurable width/height/radius) for loading states
- `SkeletonCard` — Full card shimmer placeholder
- `SkeletonListTile` — List item shimmer placeholder

### Layout
- `AppScaffold` — Scaffold wrapper with automatic offline banner
- `PullToRefresh` — Pull-to-refresh wrapper for scrollable content
- `ExpandableSection` — Collapsible section with header + animated expand/collapse
- `DividerWithText` — Horizontal divider with centered label (e.g., "OR")
- `ResponsiveBuilder` — Mobile/tablet/desktop layout switcher

### Animation
- `FadeIn` — Fade + slide-up entrance (configurable delay for staggered lists)
- `Pulse` — Pulsing animation for live indicators
- `CountUp` — Animated number counter for dashboard stats
- `StaggeredList` — Sequential fade-in for list items

---

## Style Direction

**Visual identity:** Modern SaaS meets local services — clean, trustworthy, and efficient. Think Calendly's simplicity meets Square Appointments' utility. Not flashy or playful — professional and confidence-inspiring for both sides of the marketplace.

**Key visual principles:**
- **White space dominant** — generous padding, no visual clutter
- **Card-based UI** — all content blocks in subtle elevated cards with 12px radius
- **Teal as hero color** — used sparingly for CTAs, active states, and key affordances; never overwhelming
- **Functional color** — status colors carry meaning (green=open/success, red=closed/error, amber=pending, blue=info)
- **Hierarchy through weight** — SemiBold headlines, Regular body, no underlines or decorative elements
- **Micro-interactions** — subtle fade-in on screen load, scale on card tap, pulse on live indicators
- **Content-first** — images are supporting (salon covers, barber avatars), not decorative
- **Dark mode parity** — every screen fully functional and visually polished in dark mode with slate surfaces and lighter teal accents

**Inspiration references:** Fresha (salon booking), Booksy (barber app), Square Appointments (clean scheduling), Stripe Dashboard (owner analytics clarity)
