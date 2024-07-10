# product_service.rb
require 'grpc'
require './product_services_pb'

class ProductService < Ecommerce::ProductService::Service
  def get_product(product_request, _unused_call)
    # For simplicity, returning a hardcoded product
    product = { id: 1, name: 'Laptop', price: 999.99 }
    Ecommerce::ProductResponse.new(product)
  end
end

def main
  port = '0.0.0.0:50051'
  server = GRPC::RpcServer.new
  server.add_http2_port(port, :this_port_is_insecure)
  server.handle(ProductService)
  puts "Product Service is running on #{port}"
  server.run_till_terminated
end

main
