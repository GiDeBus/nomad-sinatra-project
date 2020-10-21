class User < ActiveRecord::Base
  
  require_relative './slugify.rb'
  include Slugify::InstanceMethod
  extend Slugify::ClassMethod  
  
  has_secure_password 
  has_many :places
end