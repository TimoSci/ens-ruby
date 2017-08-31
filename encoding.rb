module Encode

  def hex_to_byte_string(string)
    string = chop_hex(string)
    hex_to_16bit_array(string).pack('c*')
  end

  def hex_to_byte_array(string)
    string.each_byte.to_a
  end

  def hex_to_16bit_array(string)
    string.split('').each_slice(2).to_a.map{|pair| pair.join.to_i(16)}
  end

  def chop_hex(string)
    if string.slice(0..1) =~ /[xX]/ then
      string = string.slice(2..-1)
    end
    string
  end

end

class Encoder
  extend Encode
end
