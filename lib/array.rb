class Array
  def symbolize
    self.map {|attr| attr.gsub(/\W+/, '_').to_sym}
  end
end
