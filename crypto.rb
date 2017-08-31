class Crypto

  def self.sha3(text)

    Digest::SHA3.hexdigest(text, 256)

  end

end
