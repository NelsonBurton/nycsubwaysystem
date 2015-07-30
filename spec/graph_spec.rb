require 'graph'
require 'spec_helper'

describe Graph, "initialize" do
    before(:each) do
        @g = Graph.new 
    end
    context "building the graph" do
    	it "should create vertices" do
            @g.add_vertex('A', {'B' => 2})
    		hash_e = {}
    		hash_e['A'] = {'B' => 2}
            hash_e['B'] = {'A' => 2}
    		expect(@g.to_s).to eq hash_e.inspect
    	end

        it "should retrieve vertices" do
            @g.add_vertex('A', {'B' => 2, 'C' => 4})
            hash_e = {}
            hash_e['A'] = {'B' => 2, 'C' => 4}
            expect(@g.get_edges('A')).to eq hash_e['A']
        end

        it "should create & overwrite multiple vertices" do
            @g.add_vertex('A', {'B' => 2, 'C' => 4})
            @g.add_vertex('B', {'A' => 3, 'C' => 2})
            hash_e = {}
            hash_e['A'] = {'B' => 2, 'C' => 4}
            hash_e['B'] = {'A' => 3, 'C' => 2}
            expect(@g.get_edges('A')).to eq hash_e['A']
            expect(@g.get_edges('B')).to eq hash_e['B']
        end

        it "should add unconnected vertices" do
            @g.add_vertex('A', {'B' => 2, 'C' => 4})
            @g.add_vertex('D', {'E' => 1, 'F' => 2})
            hash_e = {}
            hash_e['A'] = {'B' => 2, 'C' => 4}
            hash_e['E'] = {'D' => 1}
            expect(@g.get_edges('A')).to eq hash_e['A']
            expect(@g.get_edges('E')).to eq hash_e['E']
        end

        it "should merge existing vertices with new ones" do
            @g.add_vertex('A', {'B' => 2, 'C' => 4})
            @g.add_vertex('A', {'D' => 6})
            hash_e = {}
            hash_e['A'] = {'B' => 2, 'C' => 4, 'D' => 6}
            expect(@g.get_edges('A')).to eq hash_e['A']
        end

        it "should add array types as edge values" do
            @g.add_vertex('A', {'B' => [2, 'tr1'], 'C' => [4,'tr1']})
            hash_e = {}
            hash_e['A'] = {'B' => [2, 'tr1'], 'C' => [4,'tr1']}
            expect(@g.get_edges('A')).to eq hash_e['A']
        end
    end


    context "shortest path" do
        it "should work for adjacent nodes" do
            @g.add_vertex('A', {'B' => [2,"1"], 'C' => [4,"1"]})
            @g.add_vertex('B', {'A' => [2,"1"], 'C' => [2,"1"]})

            path = @g.shortest_path('A', 'B')
            correct_path = ['A','B']
            expect(path).to eq correct_path
        end
=begin
        it "should find correct route for more complex graph" do
            @g.add_vertex('A', {'B' => 7, 'C' => 8})
            @g.add_vertex('B', {'A' => 7, 'F' => 2})
            @g.add_vertex('C', {'A' => 8, 'F' => 6, 'G' => 4})
            @g.add_vertex('D', {'F' => 8})
            @g.add_vertex('E', {'H' => 1})
            @g.add_vertex('F', {'B' => 2, 'C' => 6, 'D' => 8, 'G' => 9, 'H' => 3})
            @g.add_vertex('G', {'C' => 4, 'F' => 9})
            @g.add_vertex('H', {'E' => 1, 'F' => 3})

            path = @g.shortest_path('A', 'H')
            correct_path = ['A','B','F','H']
            expect(path).to eq correct_path
        end
=end
    end
end