# require 'ethereum'
 require 'ethereum.rb'
require 'yaml'
# require 'digest/sha3'
require 'pry'


@config = YAML::load(File.open('config.yml'))
Path = @config['ipc_path']


def connect
  client = Ethereum::IpcClient.new(Path)
end


class Web3

  def self.sha3(text)
    "0x"+Digest::SHA3.hexdigest(text, 256)
  end

end

class ENSUtils

  def namehash(name)
      node = '0x0000000000000000000000000000000000000000000000000000000000000000';
      if (name != '')
          labels = name.split(".");
          labels.each do |label|
             node = Web3.sha3(node + Web3.sha3(label).slice(2));
          end
      end
      return node.to_s;
  end

end
