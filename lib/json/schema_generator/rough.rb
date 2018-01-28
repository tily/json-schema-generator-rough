require 'json'
require_relative 'rough/parser'

module JSON
  class SchemaGenerator
    class Rough
      def generate_for(json_strs, options)
        @pattern_property_paths = [
          "$.operations.*",
          "$.shapes.*",
          "$.shapes.*.members.*",
        ]

        all_json_paths = Hash.new([])
        objects = json_strs.map {|json_str| JSON.parse(json_str) }
        objects.each do |object|
          json_paths = Parser.new.parse(object)
          json_paths.each do |json_path, values|
            all_json_paths[with_pattern_property(json_path)] += values
          end
        end

        all_json_paths.each do |k, v|
          #puts "#{k} -> #{v}"
          puts "#{k}"
        end
        # If top-level is object, detect required keys for all jsons
      end

      def with_pattern_property(json_path)
        ret = json_path
        @pattern_property_paths.each do |pattern_property_path|
          regexp = /^(#{pattern_property_path.gsub(/\$/, '\$').gsub(/\./, '\.').gsub(/\*/, '[^.]+')})(\..+)/
          if json_path.match(regexp)
            ret = json_path.gsub(regexp) { pattern_property_path + $2 }
          end
        end
        return ret
      end
    end
  end
end
