#!/usr/bin/env ruby

class A
  attr_accessor      :title  

  def initialize
    @title = "A"
    
  end

  def WriteTheTitle
    title
  end
  
end

class B < A
  
  def title
    "B"
  end
  
end

p "Hello"
a = A.new
b = B.new

p a.WriteTheTitle
p b.WriteTheTitle