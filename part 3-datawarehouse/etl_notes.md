## ETL Decisions
### Decision 1 — Standardize Date Formats
Problem: The `date` column contained multiple formats such as `29/08/2023`, `12-12-2023`, and ISO `2023-02-05`, which breaks grouping and month-based reporting.
Resolution: Converted all dates into a single canonical format (`YYYY-MM-DD`) and created a numeric `date_key` (`YYYYMMDD`) for `dim_date`.
### Decision 2 — Normalize Category Values
Problem: Category values have inconsistent casing (`electronics` vs `Electronics`) and inconsistent naming for groceries (`Grocery` vs `Groceries`).
Resolution: Standardized categories into consistent labels (Title Case) and merged grocery variants into a single category `Grocery`.
### Decision 3 — Handle Missing Store City
Problem: Some rows have missing `store_city` (blank/NULL), which causes incomplete store dimension records.
Resolution: Filled missing store_city with `'Unknown'` during ETL so facts are not dropped and the stored.
