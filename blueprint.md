# Ubican ID Tiendas Blueprint

## Overview

This application, titled "Ubican ID Tiendas," is a simple tool for managing points of sale. It allows users to create, read, update, and delete point of sale entries. Each entry includes details such as the business name, owner, address, visits, and notes.

## Features

*   **Create, Read, Update, Delete (CRUD):** Full CRUD functionality for points of sale.
*   **Database:** Uses a local SQLite database to store the data.
*   **Provider:** Uses the `provider` package for state management.
*   **Search:** Allows users to search for points of sale by business or city.
*   **Dynamic Fields:** Allows users to dynamically add and remove serial numbers and visit dates.
*   **Notes & Visits:** Allows users to add and view notes and a history of visits for each point of sale.
*   **Theme:** Includes a dark/light theme toggle for the user interface.

## Current Task: Final Bug Fixes and Title Change

**Plan:**

1.  **Fix Database Schema:** Updated `database_helper.dart` to include `visits` and `notes` columns, and incremented the database version to handle migration.
2.  **Fix Edit Form Bugs:** Refactored `add_edit_screen.dart` to use `TextEditingController` for all fields, resolving issues where data was not being saved correctly, especially for dynamically added serial numbers and visits.
3.  **Refine UI:** Improved the `detail_screen.dart` layout using `Card` and `ListTile` widgets for better organization and readability.
4.  **Finalize Dynamic Fields:** Corrected the validation logic in `add_edit_screen.dart` for dynamic fields to ensure they are properly registered with the form and saved correctly without being overly strict.
5.  **Update App Title:** Changed the application title to "Ubican ID Tiendas" in `lib/main.dart` for brand consistency.
6.  **Update Blueprint:** Updated this `blueprint.md` file to reflect all the recent changes and the new application title.
