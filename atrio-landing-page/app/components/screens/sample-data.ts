/**
 * Illustrative data rendered inside the app-screen recreations.
 * These are product previews, not customer records or real metrics.
 */

export const sampleSalon = {
  name: "Studio Kente",
  district: "Cocody, Abidjan",
  rating: "4,8",
};

export const sampleSalons = [
  { name: "Studio Kente", district: "Cocody", rating: "4,8", open: true, tags: ["fade", "beard"] },
  { name: "Maison Akwaba", district: "Plateau", rating: "4,7", open: true, tags: ["cut", "care"] },
  {
    name: "Le Prestige",
    district: "Marcory",
    rating: "4,6",
    open: false,
    tags: ["braids", "beard"],
  },
] as const;

/** Clients waiting ahead of "you" in the live queue, in order. */
export const queueAhead = [
  { name: "Koffi A.", service: "fade" },
  { name: "Moussa T.", service: "beard" },
  { name: "Yao K.", service: "classic" },
  { name: "Ibrahim D.", service: "fade" },
] as const;

export const sampleBarbers = [
  { name: "Serge", initials: "S" },
  { name: "Awa", initials: "A" },
  { name: "Didier", initials: "D" },
] as const;

export const ownerBookings = [
  { time: "14:30", name: "Jean-Marc K.", service: "fade", barber: "Serge", status: "confirmed" },
  { time: "15:15", name: "Aya B.", service: "braids", barber: "Awa", status: "arriving" },
  { time: "16:00", name: "Kader S.", service: "beard", barber: "Didier", status: "pending" },
] as const;

export const weeklyBookings = [12, 16, 14, 19, 24, 31, 22] as const;

export const leaderboard = [
  { name: "Serge", share: 0.86 },
  { name: "Awa", share: 0.72 },
  { name: "Didier", share: 0.58 },
] as const;
