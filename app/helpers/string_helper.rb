module StringHelper
  def random_string(length=6)
    length -= 1 unless length < 1
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    (0...length).map { o[rand(o.length)] }.join
  end
end
