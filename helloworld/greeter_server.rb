# greeter_server.rb
require 'grpc'
require './helloworld_services_pb'

class GreeterServer < Helloworld::Greeter::Service
  def say_hello(request, _unused_call)
    Helloworld::HelloReply.new(message: "Hello, #{request.name}")
  end

  def say_hello_again(request, _unused_call)
    Helloworld::HelloReply.new(message: "Hello Again, #{request.name}")
  end
end

def main
  server = GRPC::RpcServer.new
  server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  server.handle(GreeterServer)
  server.run_till_terminated
end

main