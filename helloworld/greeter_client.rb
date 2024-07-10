# greeter_client.rb
require 'grpc'
require './helloworld_services_pb'

def main
  stub = Helloworld::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
  request = Helloworld::HelloRequest.new(name: 'World')
#   response = stub.say_hello(request)
#   puts "Greeter client received: #{response.message}"

  response2 = stub.say_hello_again(request)
  puts "Greeter client received: #{response2.message}"
end

main