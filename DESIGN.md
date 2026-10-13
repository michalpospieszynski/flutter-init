# Aurora – UI/UX Design Concept

Aurora is a generic, professional demo application showing secure multi-provider sign-in (Google, Microsoft Entra ID, email/password) on web, Android and iOS. The design goal is a clean, neutral, trustworthy look that a future client can re-brand quickly.

## 1. Design principles

1. **Trust first** – sign-in is the product. Clear provider buttons, honest error messages, visible verification and linking state.
2. **One codebase, adaptive layout** – the same screens work from 360 px phones to wide desktop browsers.
3. **Neutral and re-brandable** – all colours, radii and spacing come from tokens; changing the brand means editing one theme file.
4. **Calm and accessible** – generous whitespace, AA contrast, large touch targets, full light/dark support.
5. **Never a dead end** – every error explains what happened and offers the next action.

## 2. Brand and colour – "Indigo Aurora"

| Role | Light | Dark |
|------|-------|------|
| Primary | `#4F46E5` | `#818CF8` |
| Secondary | `#7C3AED` | `#A78BFA` |
| Tertiary | `#0E7490` | `#22D3EE` |
| Accent (brand highlight) | `#22D3EE` | `#22D3EE` |
| Background | `#F8F8FA` | `#0F0F12` |
| Surface | `#FFFFFF` | `#16161A` |

- The **brand gradient** (primary → secondary, with accent glow) is used sparingly: wordmark, hero background, key highlights.
- Dark mode uses lighter tints of the brand colours so text and controls keep AA contrast on dark surfaces.
- Success / warning colours are provided by the `AppColors` theme extension for banners.

Palette alternatives that were evaluated (A–F) are previewed in the session artefact `palettes.html`; Indigo Aurora was chosen as the most neutral for a professional demo.

## 3. Typography

- Font: **Inter** (bundled variable font, SIL OFL) for consistent rendering on all platforms.
- Clear scale: large hero headline, medium section titles, 14–16 px body, small captions for legal/footer text.
- Weight is used for hierarchy (600–700 headlines, 400–500 body); line height is relaxed for readability.

## 4. Design tokens

Defined in `lib/core/theme/app_tokens.dart`:

- **Spacing** (`AppSpacing`) – 4-pt based scale.
- **Radius** (`AppRadius`) – consistent rounded corners for buttons, inputs and cards.
- **Breakpoints** (`AppBreakpoints`) – medium 520 px, wide 820 px, max content width 1040 px.
- **Colours** (`AppColors` ThemeExtension) – accent, success, warning, brand gradient; accessed via `context.appColors`.

The full Material 3 `ThemeData` (light and dark) lives in `lib/core/theme/app_theme.dart`, including themes for buttons, inputs, navigation, segmented buttons and snackbars.

## 5. Information architecture and navigation

```
/            Landing (public)        → redirects to /home when signed in
/home        Dashboard   ┐
/profile     Profile     ├ signed-in shell (auth required)
/settings    Settings    ┘
(unknown)    Not-found page
```

- Routing uses **go_router**; the redirect reacts to `AuthSession` (`isReady`, `isSignedIn`).
- While the first auth state is loading, a startup loader is shown instead of flashing the landing page.
- **Adaptive shell**: `NavigationRail` at ≥ 820 px, bottom `NavigationBar` below that.

## 6. Screens

### Landing
- Hero with headline ("One secure sign-in. Every device."), supporting text and the sign-in card.
- On mobile the sign-in card comes **first**, so the primary action is above the fold; on wide screens it sits beside the hero copy.
- Radial gradient background, features grid (security, multi-platform, providers) and a footer with contact details and copyright. Privacy Policy and Terms of Service open as in-app subpages from the sign-in card and Settings.
- App bar: wordmark, language switch (EN/PL), theme menu.

### Sign-in card
- Order: **Continue with Google**, **Continue with Microsoft**, divider "or use your email", email + password form.
- Toggle between *Sign in* and *Create account*; *Forgot password* link; show/hide password.
- Client-side validation (required, email format, minimum 6 characters on create) with inline messages.
- Per-button progress spinners; all controls disabled while a request is running.
- Results are shown in an **inline banner** (error / info / success), not in transient toasts.

### Dashboard
- Greeting by name, account status cards, quick links to Profile and Settings.
- Account banners (see §7) appear at the top when action is needed.

### Profile
- Avatar (photo or initials), name, email, verification state.
- List of linked sign-in methods with provider icons.

### Settings
- Theme: System / Light / Dark segmented control (persisted).
- Language: English / Polski (persisted by the locale controller).
- Sign out.

### Not found
- Friendly message and a button back to the start page.

## 7. Authentication UX

| Situation | Behaviour |
|-----------|-----------|
| Wrong credentials | Inline message: "Incorrect email or password." |
| Email already used with another provider | Clear message instead of the raw Firebase code. After signing in with the existing provider, a **"Link Microsoft account"** banner offers one-tap linking. |
| New email/password account | Verification email is sent automatically; "Verify your email" banner with *Resend* and *I've verified* actions. |
| Forgot password | Sends reset email, shows a success banner. |
| Auth not configured | Banner explains that authentication is not connected yet. |
| Popup closed / cancelled | Treated as a neutral cancel, not an error. |

Account linking is an explicit user action because a held OAuth credential cannot be replayed on web; re-authenticating through `linkWithPopup` / `linkWithProvider` is the reliable path.

## 8. Components

Shared widgets in `lib/core/widgets/`:

- `AppButton` – filled / outlined / text variants with a busy spinner.
- `AppTextField` – labelled field with validation and password toggle.
- `InlineBanner` – error / info / success / warning messages.
- `PageBody` and `FadeSlideIn` – max-width content container and subtle entrance animation.

Feature widgets: `AuthCard`, `UserAvatar`, `AppWordmark`, `AppBarActions`, `ThemeModeMenu`, account notice banners, provider marks/icons.

## 9. Motion

- Short fade + slide-in on page content (200–400 ms, ease-out).
- Colour/state changes use Material defaults; no decorative or looping animation.

## 10. Accessibility

- Material 3 contrast-checked colour roles for both modes.
- Minimum 48 px touch targets on buttons and navigation.
- Text scales with system settings; layouts use flexible containers (verified on 360 px width without overflow).
- Tooltips/semantic labels on icon buttons (theme menu, password toggle).
- Pinch-zoom is no longer blocked on web.
- Error information never relies on colour alone (icon + text in banners).

## 11. Localisation

- English and Polish via ARB files (`lib/l10n/app_en.arb`, `app_pl.arb`), generated with `flutter gen-l10n`.
- All user-visible text, including auth error messages, is localised; error codes are mapped in `auth_labels.dart`.

## 12. Platform notes

- **Web**: title, description, theme colour and manifest use the Aurora brand.
- **Android/iOS**: launcher icons and native splash are configured via `flutter_launcher_icons.yaml` and `flutter_native_splash.yaml`. The splash is currently dark in both modes.

## 13. Re-branding checklist

1. Change `app_name` in `base_app_config.yaml` (header and window title; `appName` in `lib/l10n/*.arb` is only the fallback). Also update the static `web/index.html` and `web/manifest.json`.
2. Update colours in `lib/core/theme/app_theme.dart` / `app_tokens.dart`.
3. Replace icon and splash images in `assets/icon/`, then run `dart run flutter_launcher_icons` and `dart run flutter_native_splash:create`.
4. Adjust hero and feature copy in the ARB files.

## 14. Possible next steps

- Light-mode splash variant.
- Delete account, unlink provider and change email flows.
- Onboarding after first sign-in; notifications and empty states for real product content.
- Golden/visual regression tests and a manual accessibility audit with screen readers.
