const c = [
	() => import("..\\components\\layout.svelte"),
	() => import("..\\components\\error.svelte"),
	() => import("..\\..\\..\\src\\routes\\index.svelte"),
	() => import("..\\..\\..\\src\\routes\\confetti.svelte")
];

const d = decodeURIComponent;

export const routes = [
	// src/routes/index.css
	[/^\/$/],

	// src/routes/index.svelte
	[/^\/$/, [c[0], c[2]], [c[1]]],

	// src/routes/confetti.svelte
	[/^\/confetti\/?$/, [c[0], c[3]], [c[1]]]
];

export const fallback = [c[0](), c[1]()];