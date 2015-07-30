# graph implementation
# fibornacci heap priority queue implemntation
# http://www.rubydoc.info/gems/PriorityQueue/0.1.2
require 'priority_queue'

class Graph
    def initialize
        @vertices = {}
    end

    def add_vertex(name, edges)
        @vertices.has_key?(name) ? @vertices[name].merge!(edges) : @vertices[name] = edges
        # below iterates through edges on one vertex addition impacts existing vertices
        edges.each do |key, value|
            @vertices[key] ||= {name => value}
            @vertices[key].merge(name => value)  
        end
    end

    def get_vertices
        @vertices.keys
    end

    def get_edges(name)
        return @vertices[name] if @vertices.has_key?(name)
        false
    end

    def to_s
        @vertices.inspect
    end

    # Dijkstra with Priority queue of Fibonacci Heap
    def shortest_path(start, finish, append_trip_time = false)
        maxint = (2**(0.size * 8 -2) -1) # this is the infinity
        distances = {}
        previous = {}
        nodes = PriorityQueue.new
        total_trip_time = 0
        # intialize distances to 0 for start, infinite for remainder
        @vertices.each do | vertex, value |
            if vertex == start
                distances[vertex] = 0
                nodes[vertex] = 0
            else
                distances[vertex] = maxint
                nodes[vertex] = maxint
            end
            previous[vertex] = nil
        end
        while nodes
            # O(log n) to choose best vertex (shortest)
            smallest = nodes.delete_min_return_key 
            if smallest == finish
                path = []
                while previous[smallest]
                    path.push(smallest)
                    smallest = previous[smallest]
                end
                final_path = path.push(start).reverse
                return append_trip_time ? [final_path, total_trip_time] : final_path
            end
            
            if smallest == nil or distances[smallest] == maxint
                break            
            end
            # for each edge from current vertex
            @vertices[smallest].each do | neighbor, value |
                # [0] is because distance is first value in array
                alt = distances[smallest] + @vertices[smallest][neighbor][0] 
                if alt < distances[neighbor]
                    distances[neighbor] = alt
                    previous[neighbor] = smallest
                    nodes[neighbor] = alt
                end
                total_trip_time = alt if neighbor == finish
            end
        end
        return distances.inspect
    end  

end