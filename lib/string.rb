class String
  def constantize
    Object.module_eval("::#{self}", __FILE__, __LINE__)
  end
end