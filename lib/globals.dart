library fitness_tracker.globals;

// ─── Global Variables ────────────────────────────────────────────────
// These variables are shared across the whole app.
// Think of this file as a "blackboard" everyone can read and write to.

// Current logged-in user's full name
String currentUserName = 'Stefani Wong';

// First and last name separately
String currentUserFirstName = 'Stefani';
String currentUserLastName = 'Wong';

// User's email
String currentUserEmail = '';

// User role: 'guest', 'user', or 'admin'
// 'guest'  → not logged in (can only see public screens)
// 'user'   → logged in normal user (full app access)
// 'admin'  → admin (can manage users and content)
String currentUserRole = 'guest';

// Helper: check if the current user is logged in
bool get isLoggedIn => currentUserRole != 'guest';

// Helper: check if the current user is an admin
bool get isAdmin => currentUserRole == 'admin';
