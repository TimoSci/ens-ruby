# require 'ethereum'
require 'ethereum.rb'
require 'yaml'
# require 'digest/sha3'
require 'pry'
require_relative './encoding.rb'


@config = YAML::load(File.open('config.yml'))
Path = @config['ipc_path']


def connect
  client = Ethereum::IpcClient.new(Path)
end


class Web3

  def self.sha3(text)
    Digest::SHA3.hexdigest(text, 256)
  end

end


module ENSUtils

  # def namehash(name)
  #   if name == ''
  #     return '0' * 32
  #   else
  #     label, _, remainder = name.partition('.')
  #     return sha3(namehash(remainder) + sha3(label))
  #   end
  # end

  def namehash(name)
    node = '0x0000000000000000000000000000000000000000000000000000000000000000';
    if (name != '')
      labels = name.split(".");
      labels.each do |label|
        binding.pry
        node = sha3(node + sha3(label).slice(2..-1));
      end
    end
    return node.to_s;
  end

  private

  def sha3(s)
    Web3.sha3(s)
  end


end


class Api

 extend ENSUtils

end
