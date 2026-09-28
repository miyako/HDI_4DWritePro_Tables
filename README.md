# HDI_4DWritePro_Tables

A 4D **HDI** (How Do I) example demonstrating the **4D Write Pro table commands** — building a real, styleable table (not a tab-stop mockup) inside a 4D Write Pro document entirely by programming. Originally distributed as a binary `.4DB` database, it has been converted to the modern 4D project (`.4DProject`) architecture and modernised for current 4D language conventions with the help of **GitHub Copilot**.

## Overview

The demo builds a table from the `SAMPLES` table's records, one construction step at a time, so each command can be inspected in isolation: `WP Insert table` creates the table and `WP Table append row` fills it with a header, one row per record, and a totals footer; `WP Table get columns`/`get rows`/`get cells` then carve out ranges (a column, a row, an arbitrary rectangle of cells) that `WP SET ATTRIBUTES` styles independently — borders, fonts, colors, alignment, widths, and heights. The finished table can be exported to a standalone HTML page and previewed in the system browser.

## Features

- **Create a table and append rows** — `WP New`, `WP Text range`, `WP Insert table`, and `WP Table append row` build a table with a header row, one row per `SAMPLES` record (mixing a picture, text, date, and number field into the same row), and a totals footer.
- **Table-level styling** — `WP SET ATTRIBUTES` applied directly to the table reference sets overall alignment, border style/width/color, font family/size, and text color.
- **Column-level styling** — `WP Table get columns` isolates the icon/name/date/value columns so each can get its own width and alignment.
- **Row-level styling** — `WP Table get rows` isolates the header and footer rows for bold text, background color, height, and vertical alignment.
- **Cell-range styling** — `WP Table get cells` selects arbitrary rectangular ranges (e.g. the whole value column, or just the last cell) for one-off text/background color and font-size overrides.
- **Export to HTML** — `WP EXPORT DOCUMENT` writes the finished area out as a complete, self-contained web page, then `OPEN URL` opens it immediately for a side-by-side comparison with the 4D Write Pro rendering.
- **Data-driven demo content** — `initHDI` seeds the `SAMPLES` table with ten generated records (random dates/values, per-row icons) on first run, so the table always has real data to render.
- **Modern splash/startup flow** — `00_Start` uses `CALL WORKER`, a non-blocking `DIALOG(...;*)`, and window-reuse detection instead of spawning a new process or blocking on a modal dialog.
- **XLIFF localisation** — all user-facing menu, form, and message strings are externalised to `Resources/{lang}.lproj/*.xlf` (English and Japanese), grouped by purpose (menus, per-form, messages).
- **Dark mode & Liquid Glass** — `styleSheets.css` uses `"automatic"`/`"automaticAlternate"` colour values (with light/dark variants for the few colours that stay branded) so the UI adapts to light/dark mode; `styleSheets_mac.css` sizes buttons correctly for macOS Tahoe's Liquid Glass appearance as well as classic rendering.
- **Modern method declarations** — all methods use `#DECLARE`/`var` typing instead of legacy `C_*` directives, with subroutines marked `invisible` so only real entry points show up in the Run Method dialog.

## Project structure

| Path | Contents |
|------|----------|
| `Project/Sources/Methods/Decorate.4dm` | The core of the demo: a single subroutine, gated by a `$part` argument (1-5), that creates the table, then progressively styles it at the table/column/row/cell level. |
| `Project/Sources/Methods/initHDI.4dm` | Seeds the `SAMPLES` table with ten generated records on first run (or when `Shift` is held) so there is always real data to build the table from. |
| `Project/Sources/Methods/00_Start.4dm` | Splash/startup entry point (worker dispatch, window reuse, non-blocking dialog). |
| `Project/Sources/Forms/HDI/` | Splash screen form, its `On Load` method, and the `BtnDemo` object method that opens the main demo. |
| `Project/Sources/Forms/HDI2/` | Main demo form: an intro/description tab (`Page 1`) and the working 4D Write Pro area with the five step buttons and the HTML-export button (`Page 2`). |
| `Project/Sources/Forms/HDI2/ObjectMethods/Button*.4dm` | Each of the five step buttons; all but the first just call `Decorate` with the matching part number. |
| `Project/Sources/Forms/HDI2/ObjectMethods/btnHtml.4dm` | Exports the 4D Write Pro area to HTML and opens the result. |
| `Project/Sources/TableForms/3/` | Default input/list forms for `SAMPLES`, the table this demo's data comes from. |
| `Project/Sources/TableForms/1/` | Default input/output forms for `Person`, an unused table left over from the original template — not part of this demo's logic. |
| `Project/Sources/menus.json` | Menu bar definition (File/Edit/Mode), using standard actions (e.g. `"action": "quit"`) where applicable. |
| `Project/Sources/styleSheets*.css` | Cross-platform and macOS/Windows-specific form stylesheets (dark mode, Liquid Glass button sizing). |
| `Resources/{lang}.lproj/*.xlf` | XLIFF translation files (English source + Japanese), grouped by menu/form/messages. |

## Points of interest

| File | Why it's worth reading |
|------|-------------------------|
| `Project/Sources/Methods/Decorate.4dm` | The whole demo in one place: `WP Insert table`, `WP Table append row`, `WP Table get columns`/`get rows`/`get cells`, and `WP SET ATTRIBUTES`, each behind its own `Case of` branch. |
| `Project/Sources/Forms/HDI2/ObjectMethods/Button.4dm` | `WP New` creates a brand-new, empty Write Pro area only when the demo actually starts (`FORM GOTO PAGE(2)`), rather than at form load. |
| `Project/Sources/Forms/HDI2/ObjectMethods/btnHtml.4dm` | `WP EXPORT DOCUMENT` to a complete web page, then `OPEN URL` to preview the exported table immediately. |
| `Project/Sources/Methods/initHDI.4dm` | How the demo gets its sample data — generated dates/numbers and per-row icon pictures, written directly into a selection with `ARRAY TO SELECTION`. |
| `Project/Sources/Methods/00_Start.4dm` | The splash/startup pattern: worker dispatch, window reuse, non-blocking dialog. |
| `Project/Sources/Forms/HDI/ObjectMethods/BtnDemo.4dm` | Transition from the splash screen to the main demo, using `Form.quit` and `INVOKE ACTION(ak return to design mode)` instead of `QUIT 4D`. |
| `Project/Sources/styleSheets.css`, `styleSheets_mac.css` | Dark mode and Liquid Glass adaptation via `prefers-color-scheme`/`form-theme` media queries. |
| `Resources/*.lproj/*.xlf` | XLIFF localisation structure (menus, per-form, messages), in English and Japanese. |

## Modernisation notes

Beyond the table-command demo itself, the codebase has been brought up to current 4D conventions:

- **Localisation** — all menu titles, form text/labels, and message strings use `:xliff:` references or `Localized string(...)`, backed by XLIFF files under `Resources/`.
- **Modern variable declarations** — legacy `C_LONGINT`/`C_TEXT` directives in `00_Start.4dm` and `Decorate.4dm` have been replaced with `var`/`#DECLARE`.
- **Standard menu actions** — the one-line `m_Quit` wrapper method was removed in favor of the built-in `"action": "quit"`.
- **Method visibility** — `Decorate` (a subroutine with no standalone purpose) is marked `"invisible": true`; `00_Start` and `initHDI` remain visible as real entry points (`FeedData` is an empty, unreferenced leftover method from the original template and was left untouched).
- **Modern startup pattern** — `#DECLARE`, `CALL WORKER` (instead of `New process`), and non-blocking `DIALOG(...; *)`; the obsolete v16 version-check branch was removed, while the functionally meaningful 4D Write Pro license check was kept.
- **Dark mode & Liquid Glass** — forms use `"automatic"` colors and `prefers-color-scheme`/`form-theme` media queries instead of hardcoded hex colors.
- **List boxes** — not applicable; this project doesn't use any list box objects.

## Requirements

- 4D 21.1 or later (project uses `compatibilityVersion: 2101`).

## Getting started

1. Open `Project/HDI_4DWritePro_Tables.4DProject` in 4D.
2. Run the `00_Start` method (or use the **File > Demo...** menu item) to open the splash screen, then click **Demo** to open the main window.
3. On the first tab, click **Demo** again to create a fresh 4D Write Pro area and switch to the working tab.
4. Click the five buttons in order — create the table, then style its table/column/row/cell ranges — watching the 4D Write Pro area update after each step; then click **Export to HTML** to preview the result in your browser.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16 R4. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (syntax, localisation, dark mode) with the help of **GitHub Copilot**.

- **Blog post:** https://blog.4d.com/4d-write-pro-supports-tables/
- **Original download:** https://download.4d.com/Demos/4D_v16_R4/HDI_4DWritePro_Tables.zip

## References

- `WP Insert table`: http://doc.4d.com/4Dv16R4/4D/16-R4/WP-Insert-table.301-3306823.en.html
- `WP Table append row`: http://doc.4d.com/4Dv16R4/4D/16-R4/WP-Table-append-row.301-3306933.en.html
- `WP Table get columns`: http://doc.4d.com/4Dv16R4/4D/16-R4/WP-Table-get-columns.301-3307165.en.html
- `WP Table get rows`: http://doc.4d.com/4Dv16R4/4D/16-R4/WP-Table-get-rows.301-3307081.en.html
- `WP Table get cells`: http://doc.4d.com/4Dv16R4/4D/16-R4/WP-Table-get-cells.301-3307222.en.html
- `WP SET ATTRIBUTES` / `WP GET ATTRIBUTES`: http://doc.4d.com/4Dv16R4/4D/16-R4/WP-SET-ATTRIBUTES.301-3332052.en.html
- CSS in 4D (dark mode, Liquid Glass): https://developer.4d.com/docs/FormEditor/stylesheets
- XLIFF localisation: https://developer.4d.com/docs/Notions/localization
