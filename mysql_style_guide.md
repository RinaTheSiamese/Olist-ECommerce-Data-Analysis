# Olist Ecommerce: SQL Style Guide & Documentation Rules

## Capitalization & Syntax
* **SQL Keywords:** Always write SQL reserved words and functions in UPPERCASE to create visual contrast. Examples: `SELECT`, `FROM`, `WHERE`, `JOIN`, `COUNT()`, `MAX()`.
* **Identifiers:** Always write table names, column names, and custom variables in lowercase.
* **Line Termination:** End every completely self-contained query with a semicolon `;`.

## Naming Conventions
* **Case Type:** Strictly use `snake_case` (lowercase words separated by underscores) for all tables, columns, and custom variables. Example: `customer_zip_code_prefix`, not `customerZipCode`.

## Formatting & Indentation
* **Major Clauses:** Start a new line for every major SQL command (`SELECT`, `FROM`, `INNER JOIN`, `WHERE`, `GROUP BY`, `ORDER BY`).
* **Column Lists:** When selecting multiple columns, place each column on its own line and indent it. Place commas at the end of the line.
* **Join Conditions:** Place the `ON` condition on a new, indented line directly under its corresponding `JOIN`.

## Commenting Structure
* **Section Dividers:** Group related queries into logical sections using double-dash divider blocks (e.g., `-- ==========================================`). Include a `-- Desc:` line to explain the overarching goal of that section.
* **Question-Based Query Headers:** Introduce individual analytical queries with the exact business question they are answering (e.g., `-- Q1.1: What is the total (gross) revenue generated...`).
* **Contextual Notes:** Use a `-- Note:` line immediately following the question to explain specific business logic, metric definitions, or filtering decisions as necessary.

## Aliasing & Referencing
* **Explicit Column Aliases:** Always use the `AS` keyword when renaming a column or creating a calculated field.
* **Full Table Referencing (No Shorthand):** To prioritize maximum readability for external stakeholders and analysts, do *not* use shortened table aliases (like `c` or `o`). Write out the full table name when referencing.
* **Strict Prefixing:** If a query contains a `JOIN`, absolute clarity must be maintained. Every ambiguous column selected or joined must be strictly prefixed with its full table name to prevent errors. Example: `olist_order_payments.order_id = olist_orders.order_id`.

<br>

---

**🤖 Acknowledgments:** Google's Gemini AI was utilized as a collaborative assistant to help format, structure, and refine the written presentation of this style guide.
