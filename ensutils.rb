# require 'ethereum'
require 'ethereum.rb'
require 'yaml'
# require 'digest/sha3'
require 'pry'
require_relative './encoding.rb'
require_relative './crypto.rb'


@config = YAML::load(File.open('config.yml'))
Path = @config['ipc_path']


def connect
  client = Ethereum::IpcClient.new(Path)
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

  # private

  def sha3(s,**options)
    binding.pry
    s = Encoder.hex_to_byte_string(s) if options[:encoding] == :hex
    Crypto.sha3(s)
  end


end


class Api
 extend ENSUtils
end
