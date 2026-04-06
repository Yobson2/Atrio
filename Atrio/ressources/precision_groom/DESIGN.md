# Design System Specification: The Precision Grooming Experience

## 1. Overview & Creative North Star
### The Creative North Star: "The Editorial Artisan"
This design system moves beyond the utility of a standard booking tool to create a high-end digital concierge. We are not just building a directory; we are creating a curated editorial experience. The "Editorial Artisan" philosophy combines the efficiency of a Swiss timepiece with the tactile elegance of a luxury lifestyle magazine.

To break the "template" look, we lean into **intentional asymmetry** and **tonal depth**. We bypass rigid, boxed-in grids in favor of wide breathing room (whitespace as a functional element) and sophisticated layering. The goal is a "Zero-Line" interface where structure is felt through light and shadow rather than seen through borders.

---

## 2. Colors & Surface Philosophy
The palette is rooted in deep, sophisticated teals and crisp botanical greens, balanced by a neutral foundation that favors "cool-studio" light.

### Tonal Hierarchy
- **Primary (`#00685f`) & Secondary (`#006c49`):** Used sparingly for high-impact intent. These represent the "Signature" of the barber—the final touch of a sharp blade.
- **Surface & Background:** We utilize the Material 3 container scale to define depth.
    - **Base:** `surface` (#f7f9fb)
    - **Subtle Recess:** `surface-container-low` (#f2f4f6)
    - **High-Focus Elevation:** `surface-container-lowest` (#ffffff)

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders to section off content. Boundaries must be defined through:
1. **Background Color Shifts:** A `surface-container-low` card sitting on a `surface` background.
2. **Generous Spacing:** Using the 24px or 32px spacing increments to create mental "rooms" for content.

### Signature Textures: The "Glass & Gradient" Rule
To add soul to the "Professional" requirement:
- **Hero CTAs:** Use a subtle linear gradient (Top-Left: `primary` to Bottom-Right: `primary_container`). This prevents the UI from looking flat and "SaaS-generic."
- **Floating Navigation:** Use **Glassmorphism**. Apply `surface` at 80% opacity with a `20px` backdrop-blur. This makes the interface feel integrated and light.

---

## 3. Typography
We use **Inter** not as a system font, but as a precision instrument. The hierarchy is designed to feel like a high-end appointment card.

- **Display & Headline (The Statement):** Use `display-md` or `headline-lg` with tight tracking (-0.02em). These are your "Editorial Hooks." Use them for salon names and service categories to command authority.
- **Title (The Navigation):** `title-md` and `title-sm` act as the functional headers. They should be semi-bold to convey trustworthiness.
- **Body (The Detail):** `body-md` is our workhorse. We prioritize line height (1.5x minimum) to ensure "breathing room" in dense booking descriptions.
- **Labels (The Metadata):** `label-sm` is used for durations, prices, and status. Use `on_surface_variant` (#3d4947) to keep these secondary to the user's primary goal.

---

## 4. Elevation & Depth
In this design system, depth is a physical property, not a stylistic choice.

### The Layering Principle
Think of the UI as stacked sheets of fine stationery. 
- **The Desk (Background):** `surface`
- **The Folder (Section):** `surface-container-low`
- **The Card (Actionable):** `surface-container-lowest`

### Ambient Shadows
For floating elements (Modals, Hovering Buttons), use **Ambient Shadows**:
- **Shadow Property:** `0px 12px 32px rgba(25, 28, 30, 0.06)`
- **Color:** Shadows must never be pure black. Use a tinted version of `on_surface` at ultra-low opacity to mimic natural studio lighting.

### The "Ghost Border" Fallback
If a border is required for accessibility (e.g., Input fields), it must be a **Ghost Border**: Use `outline_variant` at **15% opacity**. It should be felt as a soft edge, never a hard line.

---

## 5. Components

### Buttons: The Signature Action
- **Primary:** Gradient-filled (`primary` to `primary_container`), 12px radius. 
- **Secondary:** Surface-container-high fill, no border, `primary` text color.
- **Tertiary:** No fill, no border. Use `title-sm` weight for the label.
- **Interaction:** On hover, the button should "lift" using the Ambient Shadow, rather than just changing color.

### Input Fields & Booking Slates
- **Input:** 12px radius, `surface-container-low` fill. No border. On focus, transition to a 1px `primary` Ghost Border.
- **Booking Cards:** Forbid the use of divider lines between "Time" and "Barber." Use a 24px horizontal gap. If separation is needed, use a vertical `surface-variant` line at 20% opacity.

### Chips: The Pill Style
- Use the **Pill (9999px)** radius.
- **Inactive:** `surface-container-high` background, `on_surface_variant` text.
- **Active:** `primary` background, `on_primary` text. This provides a clear, high-contrast signal of "Selected."

### Navigation Rails
- Avoid standard bottom-nav bars with thick borders. Use a floating "Glassmorphism" rail anchored 16px from the bottom, utilizing the `md` (0.75rem) border radius for the container.

---

## 6. Do’s and Don’ts

### Do
- **Do** use "Negative Space" as a design element. If a section feels crowded, add 16px of padding rather than adding a divider.
- **Do** use Material Icons in "Rounded" or "Sharp" style consistently—never mix both.
- **Do** use `tertiary` (#924628) for high-alert or "Limited Availability" flags. It provides a sophisticated contrast to the teal/green primary.

### Don't
- **Don’t** use 100% opaque borders. They create "visual noise" that breaks the premium feel.
- **Don’t** use standard drop shadows (e.g., `0 2px 4px`). They look dated. Stick to the Ambient Shadow spec.
- **Don’t** use cards inside cards without a tonal shift. If a card sits on a container, the inner card must be `surface-container-lowest` (pure white) to provide contrast.