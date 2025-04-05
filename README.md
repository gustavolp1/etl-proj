# etl-proj

This project is a functional ETL (Extract, Transform, Load) pipeline built with **OCaml** and separation between I/O and transformation logic.

---

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/gustavolp1/etl-proj
cd ETL_project
```

### 2. Install dependencies

Make sure you have **OPAM** and **Dune** installed. Then install required packages:

```bash
opam install dune csv
```

### 3. Set up OPAM environment (if needed)

```bash
eval $(opam env)
```

---

## Building

Run this from the root of the project:

```bash
dune build
```

---

## Running

From the `ETL` folder, run:

```bash
dune exec ./bin/main.exe
```

This will read from `data/order.csv` and `data/order_item.csv`, generating `data/order_totals.csv`.

---

## Tests

To run the test suite:

```bash
dune runtest
```

---

## Note

This project was developed with assistance from AI models such as Deepseek and ChatGPT.