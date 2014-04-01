# require "capistrano"

module Capsum
  VERSION = open(File.expand_path("../../VERSION", __FILE__)).read.chomp
end

# Capistrano::Configuration.instance(true).load do
  
#   def self.unbefore(task_name, name)
#     options = { :only => [ task_name ] }
#     unon :before, name, options
#   end
  
#   def self.unafter(task_name, name)
#     options = { :only => [ task_name ] }
#     unon :after, name, options
#   end
  
#   def self.unon(event, name, options)
#     self.callbacks[event].delete_if do |callback|
#       do_delete = false
#       if callback.respond_to?(:source)
#         do_delete = (name == callback.source)
#         do_delete &&= (options[:only] && options[:only] == callback.only)
#       end
      
#       do_delete
#     end
#   end
  
# end
