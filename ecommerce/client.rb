# client.rb
require 'grpc'
require './order_services_pb'

def main
  # Connect to the OrderService
  order_stub = Ecommerce::OrderService::Stub.new('localhost:50052', :this_channel_is_insecure)

  # Create an order request
  order_request = Ecommerce::OrderRequest.new(product_id: 1, quantity: 2)

  # Send the request and receive the response
  begin
    response = order_stub.create_order(order_request)
    puts "Order created successfully:"
    puts "Order ID: #{response.order_id}"
    puts "Product Name: #{response.product_name}"
    puts "Total Price: $#{response.total_price}"
  rescue GRPC::BadStatus => e
    puts "ERROR: #{e.message}"
  end
end

main
