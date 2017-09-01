# require 'ethereum'
require 'ethereum.rb'
require 'yaml'
# require 'digest/sha3'
require 'pry'
# require 'eth'
require_relative './encoding.rb'
require_relative './crypto.rb'
# require_relative '../ethereum.rb/lib/ethereum.rb'

ENS_CONTRACT_ADDRESS = "0x314159265dd8dbb310642f98f50c066173c1259b"
CONTRACTS = "./contracts"

@config = YAML::load(File.open('config.yml'))
Path = @config['ipc_path']


def connect
  client = Ethereum::IpcClient.new(Path)
end

def ens_contract
  Ethereum::Contract.create(file: "#{CONTRACTS}/ENS.sol", address: ENS_CONTRACT_ADDRESS )
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
    node = '0' * 64
    if (name != '')
      name.split('.').reverse.each do |label|
        node = sha3(node + sha3(label),encoding: :hex);
      end
    end
    '0x'+node
  end

  private

  def sha3(s,**options)
    case options[:encoding]
    when :hex
      s = Encoder.hex_to_byte_string(s)
    end
    Crypto.sha3(s)
  end


end


class Api
 extend ENSUtils
end
