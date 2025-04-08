open OrderTypes

let parse_order (row: string list) : order option =
  match row with
  | [id; client_id; order_date; status; origin] ->
      (try
         Some {
           id = int_of_string id;
           client_id = int_of_string client_id;
           order_date;
           status;
           origin;
         }
       with Failure _ -> None)
  | _ -> None

let parse_order_item (row: string list) : order_item option =
  match row with
  | [order_id; quantity; price; tax; product_id] ->
      (try
         Some {
           order_id = int_of_string order_id;
           product_id;
           quantity = int_of_string quantity;
           price = float_of_string price;
           tax = float_of_string tax;
         }
       with Failure _ -> None)
  | _ -> None