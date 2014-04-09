require "rubygems"
require "ffi-rzmq"

$queue = Array.new

@context = ZMQ::Context.new(1)
@push_socket = @context.socket(ZMQ::REP)
@push_socket.bind("tcp://0.0.0.0:5570")
puts "after bind push"

@pop_socket = @context.socket(ZMQ::REP)
@pop_socket.bind("tcp://0.0.0.0:5571")
puts "after bind pop"

def push()
        while(true)
#       push_socket = @context.socket(ZMQ::REP)
#       push_socket.bind("tcp://10.114.90.164:5560")
#       puts "after bind push"
        push_req = ''
        @push_socket.recv_string(push_req)
        puts "request received for push is " + push_req
        @push_socket.send_string "Success"
        puts "reply sent"
        $queue << push_req
#       push_socket.close
        end
end

def pop()
        while(true)
#       pop_socket = @context.socket(ZMQ::REP)
#        pop_socket.bind("tcp://10.114.90.164:5561")
#        puts "after bind pop"
        pop_req = ''
        @pop_socket.recv_string(pop_req)
        puts "request received for pop is " + pop_req
        if $queue.length > 0
                to_return = $queue[0]
                $queue.pop
                @pop_socket.send_string to_return
                puts "popped message sent is " + to_return
#               pop_socket.close
        else
                @pop_socket.send_string "empty queue"
                puts "empty queue sent by pop"
#                pop_socket.close
        end
        end
end

t1 = Thread.new{push()}
t2 = Thread.new{pop()}
t1.join()
t2.join()
@push_socket.close
@pop_socket.close
