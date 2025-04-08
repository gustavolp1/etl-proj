open ETL.TransformUtils
open ETL.CsvIO

module OrderFilter = struct
  let create_filter ~origin ~status =
    match origin, status with
    | "", "" -> fun _ -> true
    | "", status -> fun order -> order.status = status
    | origin, "" -> fun order -> order.origin = origin
    | origin, status -> fun order -> order.origin = origin && order.status = status
end

module OrderProcessor = struct
  let process_orders ~orders_path ~order_items_path ~output_path ~origin ~status =
    let orders = read_orders orders_path in
    let order_items = read_order_items order_items_path in
    
    let filtered_orders = 
      List.filter (OrderFilter.create_filter ~origin ~status) orders in
    
    let order_totals = compute_order_totals filtered_orders order_items in
    write_order_totals_to_csv output_path order_totals
end

let () =
  let orders_path = "./data/order.csv" in
  let order_items_path = "./data/order_item.csv" in
  let output_path = "./data/order_totals.csv" in
  
  let origin = try Sys.argv.(1) with _ -> "" in
  let status = try Sys.argv.(2) with _ -> "" in
  
  OrderProcessor.process_orders 
    ~orders_path 
    ~order_items_path 
    ~output_path 
    ~origin 
    ~status