# order_service.rb
require 'grpc'
require './order_services_pb'
require './product_services_pb'

class OrderService < Ecommerce::OrderService::Service
  def initialize(product_stub)
    @product_stub = product_stub
  end

  def create_order(order_request, _unused_call)
    product_response = @product_stub.get_product(Ecommerce::ProductRequest.new(id: order_request.product_id))

    total_price = product_response.price * order_request.quantity
    order_response = {
      order_id: 1,
      product_name: product_response.name,
      total_price: total_price
    }

    Ecommerce::OrderResponse.new(order_response)
  end
end

def main
  product_stub = Ecommerce::ProductService::Stub.new('localhost:50051', :this_channel_is_insecure)
  
  port = '0.0.0.0:50052'
  server = GRPC::RpcServer.new
  server.add_http2_port(port, :this_port_is_insecure)
  server.handle(OrderService.new(product_stub))
  puts "Order Service is running on #{port}"
  server.run_till_terminated
end

main
