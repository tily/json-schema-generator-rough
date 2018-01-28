module JSON
  class SchemaGenerator
    class Rough
      class Parser
        def parse(object)
          return walk(object, ['$'], {})
        end

        def walk(object, current_json_path, json_paths)
          case object
          when Array
            return walk_array(object, current_json_path, json_paths)
          when Hash
            return walk_hash(object, current_json_path, json_paths)
          else
            return walk_value(object, current_json_path, json_paths)
          end
        end

        def walk_array(array, current_json_path, json_paths)
          current_json_path.push("[*]")
          array.each_with_index do |element, i|
            walk(element, current_json_path, json_paths)
          end
          current_json_path.pop
          return json_paths
        end

        def walk_hash(hash, current_json_path, json_paths)
          hash.each do |k, v|
            current_json_path.push(".#{k}")
            walk(v, current_json_path, json_paths)
            current_json_path.pop
          end
          return json_paths
        end

        def walk_value(value, current_json_path, json_paths)
          json_path = current_json_path.join('')
          json_paths[json_path] ||= []
          json_paths[json_path] << value
          return json_paths
        end
      end
    end
  end
end
