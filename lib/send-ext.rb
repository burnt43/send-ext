module Kernel
  def conditional_send(method_name, *args, condition: true, callable: nil, &block)
    if condition.is_a?(Proc)
      if condition.call
        if block.nil?
          self.send(method_name, *args, &callable)
        else
          self.send(method_name, *args, &block)
        end
      else
        self
      end
    elsif condition
      if block.nil?
        self.send(method_name, *args, &callable)
      else
        self.send(method_name, *args, &block)
      end
    else
      self
    end
  end

  def multi_send(*method_names)
    method_names.reduce(self) do |acc, method_name|
      acc.send(method_name)
    end
  end
end
