# subway system 
require 'graph'

class SubwaySystem
	def initialize
		@map = Graph.new
        @append_trip_time = false
	end

    def get_stop(name)
        @map.get_edges(name)
    end

    def get_time_between_adjacent_stations (origin, destination, time_between_stations)
        return 1 if time_between_stations == 1
        time_between_stations.each do |station_list|
            if (station_list[0] == origin && station_list[1] == destination) ||
               (station_list[1] == origin and station_list[0] == destination)
               return station_list[2]
            end
        end
        return 1 # default value if no match found
    end

	def add_train_line(stops, name, time_between_stations = 1)
        # if time_between_stations is passed with array values, then set flag to true
        @append_trip_time = true unless time_between_stations == 1
        stops.each_with_index do |stop,i|
            edges = Hash.new
            unless i == 0 
                time = get_time_between_adjacent_stations(stop,stops[i-1], time_between_stations)
                edges.merge!( stops[i-1] => [time, name] ) 
            end
            unless i >= stops.length-1 
                time = get_time_between_adjacent_stations(stop,stops[i+1], time_between_stations)
                edges.merge!( stops[i+1] => [time, name] ) 
            end
            @map.add_vertex(stop, edges )
        end
	end

    def take_train(origin, destination) 
        path = @map.shortest_path(origin,destination, @append_trip_time)
    end
end