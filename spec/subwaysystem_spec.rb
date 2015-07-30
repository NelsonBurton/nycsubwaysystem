require 'subwaysystem'
require 'spec_helper'

describe SubwaySystem, "build map/add train line" do
    before(:each) do
        @subway_system = SubwaySystem.new 
        @subway_system.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1")
    end

    context "challenge 1 tests" do

        it "should create vertices" do
            houston = @subway_system.get_stop("Houston")
            node = {"Canal" => [1, "1"], "Christopher" => [1,"1"] }
            expect(houston).to eq node
        end

        it "should work for first stop" do
            canal = @subway_system.get_stop("Canal")
            node = {"Houston" => [1, "1"]}
            expect(canal).to eq node        
        end

        it "should work for last stop" do
            s14th = @subway_system.get_stop("14th")
            node = {"Christopher" => [1, "1"]}
            expect(s14th).to eq node        
        end

        it "should add a perpendicular trains" do
            @subway_system.add_train_line(stops=["Spring", "West 4th", "14th", "23rd"], name="E")
            
            west4th = @subway_system.get_stop("West 4th")
            node = {"Spring" => [1, "E"], "14th" => [1,"E"] }
            expect(west4th).to eq node   
            
            s14th = @subway_system.get_stop("14th")
            node = {"Christopher" => [1,"1"], "West 4th" => [1, "E"], "23rd" => [1,"E"] }
            expect(s14th).to eq node   
        end
    end

    context "challenge 2 tests" do
        it "should calculate time between stations" do
            time = @subway_system.get_time_between_adjacent_stations(origin="Christopher",destination="Houston",
                        time_between_stations=[ ["Canal", "Houston", 3],
                                                ["Houston", "Christopher", 7],
                                                ["Christopher", "14th", 2]
                                             ])
            expect(time).to eq 7
        end 

        it "should modify existing train with new travel times" do
            @subway_system.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1",
                        time_between_stations=[ ["Canal", "Houston", 3],
                                                ["Houston", "Christopher", 7],
                                                ["Christopher", "14th", 2]
                                                ])
            houston = @subway_system.get_stop("Houston")
            node = {"Canal" => [3, "1"], "Christopher" => [7,"1"] }
            expect(houston).to eq node
            
            s14th = @subway_system.get_stop("14th")
            node = {"Christopher" => [2, "1"]}
            expect(s14th).to eq node      
        end
    end 
end




describe SubwaySystem, "take trains" do
    before(:each) do
        @subway_system = SubwaySystem.new 
        @subway_system.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1")
        @subway_system.add_train_line(stops=["Spring", "West 4th", "14th", "23rd"], name="E")

    end

    context "challenge 1 tests" do

        it "should work for no travel" do
            path = @subway_system.take_train(origin="Canal", destination="Canal")
            correct_path = ["Canal"]
            expect(path).to eq correct_path
        end

        it "should find shortest path for adjacent stations" do
            path = @subway_system.take_train(origin="Canal", destination="Houston")
            correct_path = ["Canal", "Houston"]
            expect(path).to eq correct_path
        end

        it "should find shortest path along single track line" do
            path = @subway_system.take_train(origin="14th", destination="Canal")
            correct_path = ["14th", "Christopher", "Houston", "Canal"]
            expect(path).to eq correct_path
        end

        it "should find shortest path along multiple track line" do
            path = @subway_system.take_train(origin="Canal", destination="Spring")
            correct_path = ["Canal", "Houston", "Christopher", "14th", "West 4th", "Spring"]
            expect(path).to eq correct_path
        end
    end


    context "challenge 2 tests" do
        it "should calculate total travel times" do
            @subway_system.add_train_line(stops=["Canal", "Houston", "Christopher", "14th"], name="1",
                time_between_stations=[ ["Canal", "Houston", 3],
                                        ["Houston", "Christopher", 7],
                                        ["Christopher", "14th", 2]
                                        ])
            @subway_system.add_train_line(stops=["Spring", "West 4th", "14th", "23rd"], name="E",
                time_between_stations=[ ["Spring", "West 4th", 1],
                                         ["West 4th", "14th", 5],
                                         ["14th", "23rd", 2],
                                         ])
            

            path = @subway_system.take_train(origin="Houston", destination="23rd")
            correct_path = [["Houston", "Christopher", "14th", "23rd"], 11]
            expect(path).to eq correct_path

            path = @subway_system.take_train(origin="Canal", destination="14th")
            correct_path = [["Canal", "Houston","Christopher", "14th"], 12]
            expect(path).to eq correct_path

            path = @subway_system.take_train(origin="Canal", destination="West 4th")
            correct_path = [["Canal", "Houston", "Christopher", "14th", "West 4th"], 17]
            expect(path).to eq correct_path
            
        end
    end 

end