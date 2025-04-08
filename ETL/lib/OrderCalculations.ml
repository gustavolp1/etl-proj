open OrderTypes

let get_order_total (order_id: int) (order_items_filtered: order_item list) : order_total option =
  match order_items_filtered with
  | [] -> None
  | _ ->
      let sum, tax = List.fold_left
        (fun (sum, tax) order_item ->
           (sum +. order_item.price *. float_of_int order_item.quantity,
            tax +. order_item.tax *. float_of_int order_item.quantity))
        (0.0, 0.0)
        order_items_filtered
      in
      Some { order_id; total_amount = sum; total_taxes = tax }

let compute_order_totals (orders: order list) (order_items: order_item list) : order_total list =
  List.filter_map (fun order ->
    List.filter (fun (order_item:order_item) -> order_item.order_id = order.id) order_items
    |> get_order_total order.id 
  ) orders