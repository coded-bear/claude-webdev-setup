# Component Conventions

## Folder Convention (non-shadcn components)

The folder name, component file name, test file name, and types file name MUST all use the same PascalCase name — identical to the component's export name.

Example for a component named `UserProfile`:

```
UserProfile/
├── UserProfile.tsx        # export const UserProfile = ...
├── UserProfile.test.tsx
├── UserProfile.types.ts   # only if types go beyond main Props interface
└── index.ts               # export { UserProfile } from './UserProfile' (+ other public exports)
```

**Private sub-components and component-scoped hooks co-locate in the same folder**, sharing the parent's PascalCase prefix — e.g. `UserProfileAvatar.tsx` and `useUserProfile.ts` sit next to `UserProfile.tsx`. Once a sub-component is used by a second parent, promote it to its own folder (or to `common/`).

## Component Categories (`components/` directory)

```
components/
├── ui/          # shadcn/ui primitives — flat files, shadcn convention (don't wrap in folders)
├── common/      # Reusable across the app (Logo, ThemeToggle, PageHeader, Avatar)
├── sections/    # Page sections (HeroSection, PricingSection, CTASection, FAQSection)
└── layouts/     # Layout building blocks (Sidebar, Navbar, Footer, MobileMenu)
```

## Key Rules

- `ui/` keeps shadcn's flat file convention — no PascalCase folders for these
- Next.js App Router — one route only → `app/<route>/_components/`; cross-route → `components/common/`
- React + Vite — one feature only → `features/<name>/components/`; cross-feature → `components/common/`
