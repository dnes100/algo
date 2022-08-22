class Foo
  include Enumerable

  def initialize
    @data = (1..10)
  end

  def each
    @data.each do |i|
      yield i, i.to_s
    end
  end

end

ff = Foo.new
puts ff

ff.each_cons(2) do |x, y|
  puts [x, y].inspect
end
puts '--'
