module Kernel
  def conditional_send(method_name, *args, condition: true, &block)
    if condition.is_a?(Proc)
      if condition.call
        self.send(method_name, *args, &block)
      else
        self
      end
    elsif condition
      self.send(method_name, *args, &block)
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
