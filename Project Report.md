# Project Report

## Introduction

This report outlines the development of a functional ETL (Extract, Transform, Load) pipeline implemented in **OCaml**. The pipeline reads structured data from CSV files (`order.csv` and `order_item.csv`), transforms it using functional programming principles, and generates an aggregated output file (`order_totals.csv`). The project showcases clean modularity, functional separation between pure and impure logic, and randomized test data to ensure robustness.

---

## Project Structure

- **main.ml**: Manages the ETL process.
- **TransformUtils.ml**: Performs transformation and aggregation logic.
- **CsvIO.ml**: Contains the functions for reading from and writing to CSV files (impure functions).
- **TestTransformUtils.ml**: Attempts unit tests.

---

### 2. Defining Data Models

Defined three record types:
- `order`: with fields like `id`, `client_id`, `status`, `order_date`, and `origin`.
- `order_item`: including `order_id`, `product_id`, `price`, `quantity`, and `tax`.
- `order_total`: the output, containing `order_id`, `total_amount`, and `total_taxes`.

These types are defined to match the CSV schema and are used throughout the transformation pipeline.

---

### 3. Data Transformation (TransformUtils.ml)

- Implemented pure functions for:
  - Parsing CSV records into typed data structures.
  - Filtering by `status` and `origin`.
  - Aggregating item data by `order_id` using `map`, `reduce`, and `filter`.
- Data is grouped by `order_id`, and each group’s total amount and taxes are computed.

> Functional principles such as **immutability**, **referential transparency**, and **function composition** were maintained throughout.

---

### 4. Reading and Writing CSV (CsvIO.ml)

- Implemented functions for reading orders and items from CSVs and writing the results to a new file.
- These are the only impure parts of the system and were kept isolated.
- Error handling is basic but sufficient for clean input. Validation can be extended (e.g., date formats, field presence).

---

### 5. ETL Orchestration (main.ml)

The `main.ml` file performs the following steps:
1. Read inputs using `CsvIO`.
2. Filter the data based on hardcoded or passed-in criteria.
3. Apply transformations using `TransformUtils`.
4. Save the result back to a CSV file.

The goal is simplicity and maintainability while still showcasing functional composition.

---

### 6. Testing (TestTransformUtils.ml)

- Created tests using OUnit2.
- The test inputs were updated to match a **randomized dataset**, and the assertions were adjusted accordingly.
- Tests validate:
  - Correct grouping and aggregation logic.
  - Handling of edge cases like empty inputs.
  - Correct output format and value types.

---

## Use of Generative AI

Generative AI tools were used to assist with debugging and structuring code, and generating README and project report templates. Nonetheless, all content has been reviewed by the author for accuracy and performance guarantee.

---

## Project Requirements Checklist

| Requirement                                 | Status    |
|---------------------------------------------|-----------|
| Functional programming paradigm              | ✅ Complete |
| Modularity and separation of concerns        | ✅ Complete |
| Use of `map`, `filter`, and `reduce`         | ✅ Complete |
| Clear test coverage with OUnit2              | ✅ Complete |
| Randomized CSV input and consistent output   | ✅ Complete |
| Error handling and extensibility             | ✅ Basic    |

