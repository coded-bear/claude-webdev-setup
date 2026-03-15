# Component Conventions

## Folder Convention (non-shadcn components)

The folder name, component file name, test file name, and types file name MUST all use the same PascalCase name — identical to the component's export name.

Example for a component named `UserProfile`:

```
UserProfile/
├── UserProfile.tsx        # export const UserProfile = ...
├── UserProfile.test.tsx
├── UserProfile.types.ts   # only if types go beyond main Props interface
└── index.ts               # export { UserProfile } from './UserProfile'
```

Each folder contains:

- `ComponentName.tsx` — component implementation (named export matching PascalCase name)
- `ComponentName.test.tsx` — unit tests
- `index.ts` — re-exports (component + any other public exports)
- `ComponentName.types.ts` — **only** if types go beyond the main Props interface

## Component Categories (`components/` directory)

```
components/
├── ui/          # shadcn/ui primitives — flat files, shadcn convention (don't wrap in folders)
├── common/      # Reusable across the app (Logo, ThemeToggle, PageHeader, Avatar)
├── sections/    # Page sections (HeroSection, PricingSection, CTASection, FAQSection)
├── layouts/     # Layout building blocks (Sidebar, Navbar, Footer, MobileMenu)
```

## Key Rules

- `ui/` keeps shadcn's flat file convention — no PascalCase folders for these
- Feature-specific components go in `features/<name>/components/` (not in global `components/`)
- The `index.ts` pattern: `export { ComponentName } from './ComponentName'`
