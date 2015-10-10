require_relative 'tsv_buddy'
require_relative 'yaml_buddy'
require 'yaml'

# a class that is able to transfer between YSML
class FlipFlap
  include TsvBuddy
  attr_accessor :data
  include YamlBuddy
  # def take_yaml(yml)
  #   @data = YAML.load(yml)
  # end
  #
  # def to_yaml
  #   @data.to_yaml
  # end
end
