open OUnit2
open ETL.TransformUtils

(* Tests *)
let test_parse_order _ =
  let input = ["1"; "100"; "2025-03-15"; "Shipped"; "Online"] in
  let expected = Some { id = 1; client_id = 100; order_date = "2025-03-15"; status = "Shipped"; origin = "Online" } in
  assert_equal expected (parse_order input)

let test_parse_order_missing_field _ =
  let input = ["1"; "100"; "2025-03-15"; "Shipped"] in
  let expected = None in
  assert_equal expected (parse_order input)

let test_parse_order_empty _ =
  let input = [] in
  let expected = None in
  assert_equal expected (parse_order input)

let test_parse_order_item _ =
  let input = ["1"; "5"; "100.0"; "10.0"; "Amber"] in
  let expected = Some { order_id = 1; product_id = "Amber"; quantity = 5; price = 100.0; tax = 10.0 } in
  assert_equal expected (parse_order_item input)

let test_parse_order_item_missing_field _ =
  let input = ["1"; "5"; "100.0"; "10.0"] in
  let expected = None in
  assert_equal expected (parse_order_item input)

let test_parse_order_item_empty _ = 
  let input = [] in
  let expected = None in
  assert_equal expected (parse_order_item input)

let test_get_order_total _ =
  let items = [{ order_id = 1; product_id = "Amber"; quantity = 2; price = 50.0; tax = 5.0 };
               { order_id = 1; product_id = "Banana"; quantity = 3; price = 30.0; tax = 3.0 }] in
  let expected = Some { order_id = 1; total_amount = 190.0; total_taxes = 19.0 } in
  assert_equal expected (get_order_total 1 items)

let test_compute_order_totals _ =
  let orders = [{ id = 1; client_id = 100; order_date = "2025-03-15"; status = "Shipped"; origin = "Online" }] in
  let order_items = [{ order_id = 1; product_id = "Amber"; quantity = 2; price = 50.0; tax = 5.0 };
                     { order_id = 1; product_id = "Banana"; quantity = 3; price = 30.0; tax = 3.0 }] in
  let expected = [{ order_id = 1; total_amount = 190.0; total_taxes = 19.0 }] in
  assert_equal expected (compute_order_totals orders order_items)

let suite =
  "Tests" >::: [
    "test_parse_order" >:: test_parse_order;
    "test_parse_order_missing_field" >:: test_parse_order_missing_field;
    "test_parse_order_empty" >:: test_parse_order_empty;
    "test_parse_order_item" >:: test_parse_order_item;
    "test_parse_order_item_missing_field" >:: test_parse_order_item_missing_field;
    "test_parse_order_item_empty" >:: test_parse_order_item_empty;
    "test_get_order_total" >:: test_get_order_total;
    "test_compute_order_totals" >:: test_compute_order_totals
  ]

let () = run_test_tt_main suite